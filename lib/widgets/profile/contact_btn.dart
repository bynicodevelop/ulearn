import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';

class ContactBtn extends StatelessWidget {
  const ContactBtn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Palette.blue[200])),
              height: 40,
              onPressed: () => print('message'),
              child: SizedBox(
                width: 120,
                child: Center(
                  child: Text(
                    'message'.toUpperCase(),
                    style: TextStyle(color: Palette.blue[200], fontSize: 14),
                  ),
                ),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              height: 40,
              onPressed: () => print('follow'),
              child: SizedBox(
                width: 120,
                child: Center(
                  child: Text(
                    'follow'.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              color: Palette.blue[50],
            ),
          ],
        ),
      ),
    );
  }
}
