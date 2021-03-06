import 'package:flutter/material.dart';
import 'package:genchi_web/screens/opportunities_screen.dart';
import 'package:genchi_web/screens/sign_in_screen.dart';
import 'package:genchi_web/services/authentication_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class MyHomePage extends StatefulWidget {

  static const String id = '/home';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  bool isSmallScreen = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      ///SCREEN IS LARGE
      if (constraints.maxWidth > 600) {
        isSmallScreen = false;
        return Scaffold(
            backgroundColor: Color(kGenchiGreen),
            body: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  color: Color(kGenchiGreen),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                // _index = 0;
                              });
                            },
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.07),
                                child: Image.asset('images/Logo_Only.png')),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () async {

                                  bool isLoggedIn = await AuthenticationService().isUserLoggedIn();

                                  Navigator.pushNamedAndRemoveUntil(context, isLoggedIn ? OpportunitiesScreen.id : SignInScreen.id,
                                    (Route<dynamic> route) => false);
                                },
                                // highlightColor: Colors.transparent,
                                // splashColor: Colors.transparent,
                                // hoverColor: Colors.transparent,
                                child: Text(
                                  'Opportunities',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              // SizedBox(width: 20,),
                              // TextButton(
                              //   onPressed: () {
                              //     setState(() {
                              //       // _index = 1;
                              //     });
                              //   },
                              //   // highlightColor: Colors.transparent,
                              //   // splashColor: Colors.transparent,
                              //   // hoverColor: Colors.transparent,
                              //   child: Text(
                              //     'Team',
                              //     style: TextStyle(
                              //         color: Colors.white, fontSize: 20),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                HomeScreen(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      color: Color(kGenchiGreen),
                      child: Center(child: Text('Footer'))),
                ),
              ],
            ));

        ///SCREEN IS SMALL
      } else {
        isSmallScreen = true;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * .1,
            title: SizedBox(
              width: MediaQuery.of(context).size.height * 0.5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // _index = 0;
                  });
                },
                child: Image.asset('images/Logo_Only.png'),
              ),
            ),
            backgroundColor: Color(kGenchiGreen),
            elevation: 0,
          ),
          backgroundColor: Color(kGenchiGreen),
          endDrawer: Drawer(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(color: Color(kGenchiGreen)),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Text('Home',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                          onTap: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: GestureDetector(
                      child: Text(
                        'Be a Hirer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        setState(() {
                          // _index = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: GestureDetector(
                      child: Text(
                        'Be a Provider',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        setState(() {
                          // _index = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: GestureDetector(
                      child: Text(
                        'About Us',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        setState(() {
                          // _index = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: GestureDetector(
                      child: Text(
                        'Opportunities',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        setState(() {
                          // _index = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: ListView(
            children: <Widget>[
              HomeScreen(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    color: Color(kGenchiGreen),
                    child: Center(child: Text('Footer'))),
              ),
            ],
          ),
        );
      }
    });
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectableText(
                            'A platform for students to find opportunities',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  child: Container(
                                    height: 50,
                                    child: Image.asset(
                                        'images/badges/app_store_badge.png'),
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
                                MaterialButton(
                                  child: Container(
                                    height: 50,
                                    child: Image.asset(
                                        'images/badges/google-play-badge.png'),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Image.asset('images/HomePageGraphic.png'),
                      ),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              ],
            ),
          ),
        ),
        Container(
          color: Color(kGenchiCream),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                    child: SelectableText(
                      'Our Mission',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.w500),
                    )),
                Center(
                    child: SelectableText(
                      'We believe in empowering people to create their own impact through equal access to opportunities. We enable people to develop their skillset and contribute towards causes that are meaningful to them.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    )),
                SizedBox(
                  height: 200,
                ),
                Center(
                    child: SelectableText(
                      'Supporters',

                      style: TextStyle(
                          fontSize: 60, fontWeight: FontWeight.w500),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Image.asset('images/supporters/YCSUSLogo.png')),
                      Expanded(
                          flex: 1,
                          child: Image.asset('images/supporters/RAELogo.png')),
                      Expanded(
                          flex: 1,
                          child:
                          Image.asset('images/supporters/CambridgeLogo.png')),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],

            ),
          ),
        )
      ],

    );
  }
}
