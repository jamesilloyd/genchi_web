import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/screens/forgot_password_screen.dart';
import 'package:genchi_web/screens/home_screen.dart';
import 'package:genchi_web/screens/opportunities_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:genchi_web/screens/post_reg_details_screen.dart';
import 'package:genchi_web/screens/preferences_screen.dart';
import 'package:genchi_web/screens/register_screen.dart';
import 'package:genchi_web/screens/sign_in_screen.dart';
import 'package:genchi_web/screens/uni_not_listed_screen.dart';
import 'package:genchi_web/services/account_service.dart';
import 'package:genchi_web/services/authentication_service.dart';
import 'package:genchi_web/services/task_service.dart';
import 'package:provider/provider.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() {
  print('main');
  configureApp();
  runApp(Startup());
}

class Startup extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    print('Startup');
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

        /// Otherwise, show something whilst waiting for initialization to complete
        return Container(
          color: Color(kGenchiGreen),
        );
      },
    );
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AuthenticationService>(context, listen: false)
          .isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool loggedIn = snapshot.data;
          print(loggedIn);
          print('Routing to ${loggedIn ? 'opps' : 'signin'}');
          return MaterialApp(
            title: 'Genchi',
            theme: ThemeData(
              fontFamily: 'FuturaPT',
              accentColor: Color(kGenchiGreen),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent
            ),
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            initialRoute: loggedIn ? OpportunitiesScreen.id : SignInScreen.id,
            routes: {
              MyHomePage.id: (context) => MyHomePage(),
              OpportunitiesScreen.id: (context) => OpportunitiesScreen(),
              SignInScreen.id: (context) => SignInScreen(),
              ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
              RegisterScreen.id: (context) => RegisterScreen(),
              PreferencesScreen.id: (context) => PreferencesScreen(),
              PostRegDetailsScreen.id: (context) => PostRegDetailsScreen(),
              UniversityNotListedScreen.id: (context) =>
                  UniversityNotListedScreen(),
            },
          );
        }
        return Container(color: Color(kGenchiGreen));
      },
    );
  }
}
