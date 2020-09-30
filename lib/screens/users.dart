import 'package:flutter/material.dart';
import 'package:leadee/models/user.dart';
import 'package:leadee/screens/loading.dart';
import 'package:leadee/services/user.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/avatar.dart';
import 'package:leadee/widgets/search_form.dart';
import 'package:leadee/widgets/users/user_item.dart';

class Users extends StatefulWidget {
  Users({Key key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  UserService _userService = UserService();
  bool _isSearching = false;
  String _search = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !_isSearching,
          backgroundColor:
              !_isSearching ? Theme.of(context).primaryColor : Colors.white,
          actions: _isSearching
              ? []
              : [
                  IconButton(
                      onPressed: () =>
                          setState(() => _isSearching = !_isSearching),
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                ],
          flexibleSpace: _isSearching
              ? SearchForm(
                  onChanged: (val) => setState(() => _search = val),
                  onClear: () => setState(() => _search = ''),
                  onBack: () => setState(() {
                    _isSearching = !_isSearching;
                    _search = '';
                  }),
                )
              : null,
          title: !_isSearching ? Text('Users') : null,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: FutureBuilder(
            future: _userService.getAll(_search),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Loading()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return UserItem(
                          photoURL: snapshot.data[index].photoURL,
                          displayName: snapshot.data[index].displayName,
                          about: snapshot.data[index].about,
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
