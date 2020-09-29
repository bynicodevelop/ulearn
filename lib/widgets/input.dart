import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';

class Input extends StatelessWidget {
  final String label;
  final String placehoder;
  final TextInputType textInputType;
  Function onChange;
  Function validator;

  Input(
      {Key key,
      this.label,
      this.placehoder,
      this.onChange,
      this.validator,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 9.0,
          ),
          TextFormField(
            onChanged: onChange,
            validator: validator,
            keyboardType: textInputType,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                isDense: true,
                hintText: placehoder,
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
    );
  }
}
