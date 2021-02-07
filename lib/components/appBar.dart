import 'package:flutter/material.dart';
import 'package:genchi_web/constants.dart';

class BasicAppNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/Logo_Only.png',
            fit: BoxFit.contain,
            height: 80,
          ),
        ],
      ),
      backgroundColor: Color(kGenchiGreen),
      elevation: 2.0,
      brightness: Brightness.light,
    );
  }

  Size get preferredSize => new Size.fromHeight(80);
}
