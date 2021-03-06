import 'package:flutter/material.dart';
import 'package:genchi_web/constants.dart';


class BasicNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      color: Color(kGenchiGreen),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight:
                    MediaQuery.of(context).size.height * 0.07),
                child: Image.asset('images/Logo_Only.png')),
          ],
        ),
      ),
    );
  }
}
