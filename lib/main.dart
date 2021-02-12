import 'package:flutter/material.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/screens/home_screen.dart';
import 'package:genchi_web/screens/opportunities_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:genchi_web/screens/sign_in_screen.dart';
import 'package:genchi_web/services/account_service.dart';
import 'package:genchi_web/services/authentication_service.dart';
import 'package:genchi_web/services/task_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Startup());
}

class Startup extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      /// Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        // if (snapshot.hasError) {
        //   return SomethingWentWrong();
        // }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(providers: [
            ChangeNotifierProvider(create: (_) => AuthenticationService()),
            ChangeNotifierProvider(create: (_) => TaskService()),
            ChangeNotifierProvider(create: (_) => AccountService()),
          ], child: MyApp());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GENCHI',
      theme: ThemeData(
        fontFamily: 'FuturaPT',
        accentColor: Color(kGenchiGreen),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //TODO: decide whether login is required or not
      // home: SignInScreen(),
      home: OpportunitiesScreen(),
      routes: {
        OpportunitiesScreen.id: (context) => OpportunitiesScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int _index = 0;

  List screens = [
    HomeScreen(),
    SignInScreen(),
  ];

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
                  height: MediaQuery.of(context).size.height * 0.15,
                  color: Color(kGenchiGreen),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _index = 0;
                              });
                            },
                            // highlightColor: Colors.transparent,
                            // splashColor: Colors.transparent,
                            // hoverColor: Colors.transparent,
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.1),
                                child: Image.asset('images/Logo_Only.png')),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _index = 1;
                            });
                          },
                          // highlightColor: Colors.transparent,
                          // splashColor: Colors.transparent,
                          // hoverColor: Colors.transparent,
                          child: Text(
                            'Opportunities',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection('users').get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        QuerySnapshot hello = snapshot.data;

                        return Center(
                          child: Text(
                            '${hello.size.toString()} ACTIVE USERS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        );
                      }
                    }),
                // FlatButton(
                //     onPressed: () async {
                //       print('hi');
                //       final authResult =
                //           await _firebaseAuth.signInWithEmailAndPassword(
                //         email: 'jl2009@cam.ac.uk',
                //         password: 'MyPassword123',
                //       );
                //
                //       var user = _firebaseAuth.currentUser;
                //
                //       print(user.email);
                //     },
                //     child: Text('Get user')),

                screens[_index],
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
                    _index = 0;
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
                          child: Text(
                            'Home',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          onTap: () {
                            setState(() {
                              _index = 0;
                            });
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
                          _index = 1;
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
                          _index = 2;
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
                          _index = 3;
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
                          _index = 4;
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
              screens[_index],
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
