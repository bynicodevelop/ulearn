import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';

class Input extends StatelessWidget {
  final String label;
  final String placehoder;
  final String value;
  final bool multiline;
  final int maxLine;
  final TextInputType textInputType;
  Function onChange;
  Function validator;

  TextEditingController _controller = TextEditingController();

  Input(
      {Key key,
      this.label,
      this.value,
      this.placehoder,
      this.onChange,
      this.validator,
      this.multiline = false,
      this.maxLine = 1,
      this.textInputType})
      : super(key: key) {
    _controller.value = _controller.value.copyWith(text: value);
  }

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
            //initialValue: value,
            controller: _controller,
            keyboardType: multiline
                ? TextInputType.multiline
                : textInputType != null
                    ? textInputType
                    : TextInputType.text,
            maxLines: maxLine,
            onChanged: onChange,
            validator: validator,
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
