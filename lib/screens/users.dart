import 'package:flutter/material.dart';
import 'package:leadee/services/user.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/avatar.dart';

class Users extends StatefulWidget {
  Users({Key key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  UserService _userService = UserService();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !_isSearching,
          backgroundColor:
              !_isSearching ? Theme.of(context).primaryColor : Colors.white,
          actions: [
            IconButton(
                onPressed: () => setState(() => _isSearching = !_isSearching),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ],
          title: !_isSearching
              ? Text('Users')
              : TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search user',
                      icon: IconButton(
                        onPressed: () =>
                            setState(() => _isSearching = !_isSearching),
                        icon: Icon(Icons.arrow_back),
                        color: Palette.blue[300],
                      )),
                ),
        ),
        body: FutureBuilder(
          future: _userService.getAll(),
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Avatar(
                    radius: 20,
                  ),
                  title: Align(
                    alignment: Alignment(-1.1, 0),
                    child: Text(snapshot.data[index].displayName),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
