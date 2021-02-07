import 'package:flutter/material.dart';
import '../constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color(kGenchiGreen),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Text(
              'A PLATFORM TO FIND AND SHARE OPPORTUNITIES',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: FlatButton(
                          child: Image.asset(
                            'images/badges/app_store_badge.png',
                            height: 50,
                          ),
                          onPressed: (){

                            //TODO: go to app store
                          },
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: FlatButton(
                          child: Image.asset(
                            'images/badges/google-play-badge.png',
                            height: 50,
                          ),
                          onPressed: () {

                            //TODO: go to play store
                          },
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1
              ),
              Center(
                  child: Text(
                'Connecting YOU to Opportunities',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 60),
              )),
              Center(
                  child: Text(
                'ABOUT GENCHI',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.w400),
              )),
              Center(
                  child: Text(
                'Genchi is a platform for students to find and share opportunities within Cambridge.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40),
              )),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          'HIRE',
                          style: TextStyle(fontSize: 60),
                        )),
                        Text(
                          'Genchi minimises the effort of finding local students by putting service providers on one page. Genchi achieves this by giving you the freedom to easily select between providers you need or by posting a job and choosing from those that apply.',
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          'PROVIDE',
                          style: TextStyle(fontSize: 60),
                        )),
                        Text(
                          'Support the local community with your skills that are in demand. Genchi allows you to effortlessly set up a provider profile and start applying to opportunities so you can gain valuable experience.',
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                  child: Text(
                'SUPPORTERS',
                style: TextStyle(fontSize: 60),
              )),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Image.asset(
                          'images/supporters/RAELogo.png',
                        )),
                    Expanded(
                        flex: 1,
                        child: Image.asset('images/supporters/YCSUSLogo.png')),
                    Expanded(
                        flex: 1,
                        child:
                            Image.asset('images/supporters/CambridgeLogo.png')),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
