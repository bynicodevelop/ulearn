import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:leadee/models/user.dart';

class AuthService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;

  Future<UserModel> init() async {
    DataSnapshot dataSnapshot = await _database
        .reference()
        .child('users/${_auth.currentUser.uid}')
        .once();

    return _userFormUserCredential(_auth.currentUser,
        about: dataSnapshot.value['about'] == null
            ? ''
            : dataSnapshot.value['about'],
        backgroundImage: dataSnapshot.value['background-image'] == null
            ? ''
            : dataSnapshot.value['background-image']);
  }

  UserModel _userFormUserCredential(User userCredential,
      {String about = '', String backgroundImage = ''}) {
    return userCredential != null
        ? UserModel(
            uid: userCredential.uid,
            phoneNumber: userCredential.phoneNumber,
            photoURL: userCredential.photoURL,
            displayName: userCredential.displayName,
            about: about == null ? '' : about,
            backgroundImage: backgroundImage == null ? '' : backgroundImage)
        : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().asyncMap((user) async {
      DataSnapshot dataSnapshot = await _database
          .reference()
          .child('users/${_auth.currentUser.uid}')
          .once();

      return _userFormUserCredential(user,
          about: dataSnapshot.value['about'],
          backgroundImage: dataSnapshot.value['background-image']);
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

    return _userFormUserCredential(_auth.currentUser);
  }

  Future<UserModel> updateDiaplayName(String displaName) async {
    await _auth.currentUser.updateProfile(displayName: displaName);

    return _userFormUserCredential(_auth.currentUser);
  }

  Future<UserModel> updateAbout(String about) async {
    await _database
        .reference()
        .child('users/${_auth.currentUser.uid}')
        .update({'about': about});

    return _userFormUserCredential(_auth.currentUser, about: about);
  }

  Future<UserModel> updateBackground(String backgroundImage) async {
    await _database
        .reference()
        .child('users/${_auth.currentUser.uid}')
        .update({'background-image': backgroundImage});

    return _userFormUserCredential(_auth.currentUser,
        backgroundImage: backgroundImage);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
