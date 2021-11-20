import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String hint;
  final void Function(String? value) changedText;
  const TextBox({Key? key, required this.hint, required this.changedText})
      : super(key: key);
  final colour = const Color(0xffbfc0c0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextFormField(
        onChanged: changedText,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffe5e5e5),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: colour),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colour),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colour),
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
