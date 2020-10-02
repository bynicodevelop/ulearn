import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:leadee/models/user.dart';

class AuthService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;

  UserModel _userFormUserCredential(User userCredential,
      {String about = '',
      String backgroundImage = '',
      String selectedActivity = ''}) {
    return userCredential != null
        ? UserModel(
            uid: userCredential.uid,
            phoneNumber: userCredential.phoneNumber,
            photoURL: userCredential.photoURL,
            displayName: userCredential.displayName,
            about: about == null ? '' : about,
            backgroundImage: backgroundImage == null ? '' : backgroundImage,
            selectedActivity: selectedActivity == null ? '' : selectedActivity)
        : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().asyncMap((user) async {
      DataSnapshot dataSnapshot = await _database
          .reference()
          .child('users/${_auth.currentUser.uid}')
          .once();

      return dataSnapshot.value == null
          ? _userFormUserCredential(user)
          : _userFormUserCredential(user,
              about: dataSnapshot.value['about'],
              backgroundImage: dataSnapshot.value['background-image'],
              selectedActivity: dataSnapshot.value['activity']);
    });
  }

  Future<void> registerWithPhone(String phone) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          print(authCredential);
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          print('verificationId: ${verificationId}');
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Timout");
        });
  }

  Future<UserModel> auth(String smsCode) async {
    AuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);

    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(_credential);

      return _userFormUserCredential(userCredential.user);
    } catch (error) {
      print('Error: ${error.code.toString()}');
    }

    return null;
  }

  Future<UserModel> updatePhotoUrl(String photoUrl) async {
    await _auth.currentUser.updateProfile(photoURL: photoUrl);

    await _database
        .reference()
        .child('users/${_auth.currentUser.uid}')
        .update({'photo-url': photoUrl});

    return _userFormUserCredential(_auth.currentUser);
  }

  Future<UserModel> updateDiaplayName(String displayName) async {
    await _auth.currentUser.updateProfile(displayName: displayName);

    await _database
        .reference()
        .child('users/${_auth.currentUser.uid}')
        .update({'display-name': displayName});

    return _userFormUserCredential(_auth.currentUser);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> updateUser(UserModel userModel) async {
    Map<String, dynamic> updates = {};

    Map<String, String> data = {};

    if (!userModel.displayName.isEmpty) {
      data.putIfAbsent('display-name', () => userModel.displayName);
    }

    if (!userModel.photoURL.isEmpty) {
      data.putIfAbsent('photo-url', () => userModel.photoURL);
    }

    if (!userModel.backgroundImage.isEmpty) {
      data.putIfAbsent('background-image', () => userModel.backgroundImage);
    }

    if (!userModel.about.isEmpty) {
      data.putIfAbsent('about', () => userModel.about);
    }

    if (!userModel.selectedActivity.isEmpty) {
      data.putIfAbsent('activity', () => userModel.selectedActivity);
    }

    updates['users/${userModel.uid}'] = data;

    await _database.reference().update(updates);
  }
}
