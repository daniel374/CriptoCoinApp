import 'package:flutter/material.dart';


class MyTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon prefixIcon;
  final String labelText;
  final int maxLines;
  final IconButton suffixIcon;
  final bool obscureText;
  final Function validator;
  final Function onsave;

  MyTextFormField({
    @required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    @required this.hintText,
    @required this.maxLines,
    this.validator,
    this.onsave,
    @required this.controller,
  });

  @override
  State createState() {
    return _MyTextFormField();
  }
}

class _MyTextFormField extends State<MyTextFormField> {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      child: TextFormField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        maxLines: widget.maxLines,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 15.0,
            fontFamily: "Lato",
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold),
        validator: widget.validator,
        onSaved: widget.onsave,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          filled: true,
          fillColor: Color(0xFFe5e5e5),
          border: InputBorder.none,
          hintText: widget.hintText,
          labelText: widget.labelText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFe5e5e5)),
              borderRadius: BorderRadius.all(Radius.circular(9.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFe5e5e5)),
              borderRadius: BorderRadius.all(Radius.circular(9.0))),
        ),
      ),
    );

  }
}