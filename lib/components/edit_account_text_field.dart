import 'package:flutter/material.dart';
import 'package:genchi_web/constants.dart';

class EditAccountField extends StatelessWidget {
  const EditAccountField(
      {@required this.field,
      @required this.onChanged,
      this.isEditable = true,
      @required this.textController,
      this.isPassword = false,
      this.hintText});

  final String field;
  final Function onChanged;
  final bool isEditable;
  final bool isPassword;
  final TextEditingController textController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(
            field,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 5.0),
        TextField(
          textCapitalization: TextCapitalization.sentences,
          maxLines: isPassword? 1: null,
          style: TextStyle(
            color: isEditable ? Colors.black : Colors.grey,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            fontFamily: isPassword ? 'Lato' : 'FuturaPT',
          ),
          obscureText: isPassword,
          textAlign: TextAlign.left,
          onChanged: onChanged,
          readOnly: isEditable ? false : true,
          controller: textController,
          decoration: kEditAccountTextFieldDecoration.copyWith(
            hintText: hintText,

          ),
          cursorColor: Color(kGenchiOrange),
        ),
      ],
    );
  }
}
