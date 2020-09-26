import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leadee/share/palette.dart';
import 'package:leadee/widgets/avatar/change_avatar.dart';
import 'package:leadee/widgets/input.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> activities = <String>['developer', 'musician', 'marketer'];
  int _selectedActivity = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context)),
              Center(
                child: ChangeAvatar(
                  editable: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Input(
                      label: 'Fullname',
                      placehoder: 'John Doe',
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'About',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              isDense: true,
                              hintText: "About you...",
                              hintStyle: TextStyle(fontSize: 14),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: Palette.grey[50]),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: Palette.grey[50]),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Activity',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 9.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Palette.grey[50])),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                onChanged: (val) => print('ok'),
                                value: activities[_selectedActivity],
                                hint: Text("Select activity"),
                                isDense: true,
                                style: TextStyle(color: Palette.blue[300]),
                                items: activities.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      height: 40,
                      onPressed: () => Navigator.pop(context),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            'Save'.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      color: Palette.blue[50],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
