import 'package:flutter/material.dart';
import 'package:leadee/share/app_colors.dart';

class LoadingComponent extends StatefulWidget {
  LoadingComponent({Key key}) : super(key: key);

  @override
  _LoadingComponentState createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: 100.0,
                    maxWidth: 233.0,
                    minWidth: 150.0,
                    minHeight: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                      color: Colors.black.withOpacity(.5),
                                      offset: Offset(0, 1),
                                      blurRadius: 2)
                                ]),
                            text: 'lead'.toUpperCase(),
                            children: [
                          TextSpan(
                              text: 'ee'.toUpperCase(),
                              style: TextStyle(color: AppColors.orange[50]))
                        ])),
                    Text(
                      'loading...',
                      style: TextStyle(letterSpacing: 2),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
