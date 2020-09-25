import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Function codeSent;

  AuthService({this.codeSent});

  addCodeSentCb(Function codeSent) {
    this.codeSent = codeSent;
  }

  Future<void> registerWithPhone(String phone) async {
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) {
          print(authCredential);
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.message);
        },
        codeSent:
            codeSent, //(String verificationId, [int forceResendingToken]) {
        //print('verificationId: ${verificationId}');
        //show dialog to take input from the user
        //},
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        });
  }

  // Future<void> auth(String verificationId, String smsCode) async {
  //   AuthCredential _credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId, smsCode: smsCode);
  //   _auth
  //       .signInWithCredential(_credential)
  //       .then((value) => print(value))
  //       .catchError(print);
  // }
}
