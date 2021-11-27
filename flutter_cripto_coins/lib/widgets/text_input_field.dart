import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class TextInputField extends StatefulWidget {

  final String hintText;
  final TextInputType inpuType;
  final TextEditingController controller;
  final Icon icon;
  final String labelText;
  final int maxLines;
  final IconButton suffixIcon;
  //final bool obscureText;

  TextInputField({Key key,
    @required this.hintText,
    @required this.inpuType,
    this.controller,
    @required this.maxLines,
    //@required this.obscureText,
    this.icon,
    this.labelText,
    this.suffixIcon,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      child: TextField(
        //obscureText: widget.obscureText,
        controller: widget.controller,
        keyboardType: widget.inpuType,
        maxLines: widget.maxLines,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 15.0,
            fontFamily: "Lato",
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          prefixIcon: widget.icon,
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
