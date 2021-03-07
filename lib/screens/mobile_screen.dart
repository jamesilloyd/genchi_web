import 'package:flutter/material.dart';
import 'package:genchi_web/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color(kGenchiGreen),
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Text(
                'Welcome To Genchi\n\n',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'We notice you are on a mobile browser.\n\nPlease sign up on our mobile app for a better experience',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  child: Container(
                    height: 50,
                    child: Image.asset('images/badges/app_store_badge.png'),
                  ),
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onPressed: () async {
                    if (await canLaunch(kAppStoreURL)) {
                      await launch(kAppStoreURL);
                    } else {
                      print("Could not open URL");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  child: Container(
                    height: 50,
                    child: Image.asset('images/badges/google-play-badge.png'),
                  ),
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onPressed: () async {
                    if (await canLaunch(kPlayStoreURL)) {
                      await launch(kPlayStoreURL);
                    } else {
                      print("Could not open URL");
                    }
                  },
                ),
              ),
            ],
          ),
          Image.asset('images/HomePageGraphic.png')
        ],
      ),
    );
  }
}
