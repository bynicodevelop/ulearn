import 'package:flutter/material.dart';
import 'package:leadee/share/palette.dart';

class SearchForm extends StatefulWidget {
  Function onChanged;
  Function onBack;
  Function onClear;

  SearchForm({Key key, this.onChanged, this.onBack, this.onClear})
      : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  TextEditingController _textEditingController = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _showClearButton = _textEditingController.text.length > 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: TextField(
        controller: _textEditingController,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search user',
          suffixIcon: _showClearButton
              ? IconButton(
                  onPressed: () {
                    _textEditingController.clear();
                    widget.onClear();
                  },
                  icon: Icon(Icons.clear),
                  color: Palette.blue[300],
                )
              : null,
          icon: IconButton(
            onPressed: widget.onBack,
            icon: Icon(Icons.arrow_back),
            color: Palette.blue[300],
          ),
        ),
      ),
    );
  }
}
