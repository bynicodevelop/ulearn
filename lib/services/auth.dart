import 'package:firebase_auth/firebase_auth.dart';
import 'package:leadee/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;

  UserModel _userFormUserCredential(User userCredential) {
    return userCredential != null
        ? UserModel(
            uid: userCredential.uid, phoneNumber: userCredential.phoneNumber)
        : null;
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
}
