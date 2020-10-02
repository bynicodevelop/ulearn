import 'package:firebase_database/firebase_database.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/services/auth.dart';

class UserService {
  final AuthService _authService = AuthService();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Stream<UserModel> get(String uid, bool isCurrentUser) async* {
    DataSnapshot data =
        await _database.reference().child('users').child(uid).once();

    Map<dynamic, dynamic> map = data.value;

    UserModel userModel = UserModel(
        uid: uid,
        displayName: map['display-name'] != null ? map['display-name'] : '',
        photoURL: map['photo-url'] != null ? map['photo-url'] : '',
        backgroundImage:
            map['background-image'] != null ? map['background-image'] : '',
        selectedActivity: map['activity'] != null ? map['activity'] : '',
        about: map['about'] != null ? map['about'] : '',
        isCurrentUser: isCurrentUser);

    yield userModel;
  }

  Future<List<UserModel>> getAll(String searchValue) async {
    List<UserModel> users = [];
    UserModel user = await _authService.user.first;

    DataSnapshot data = await _database
        .reference()
        .child('users')
        .orderByChild('display-name')
        .startAt(searchValue)
        .endAt(searchValue + "\uf8ff")
        .once();

    Map<dynamic, dynamic> map = data.value;

    if (map != null && map.length > 0) {
      map.forEach((key, value) {
        if (key != user.uid) {
          users.add(UserModel(
              uid: key,
              displayName:
                  value['display-name'] != null ? value['display-name'] : '',
              photoURL: value['photo-url'] != null ? value['photo-url'] : '',
              about: value['about'] != null ? value['about'] : ''));
        }
      });
    }

    return users;
  }
}
