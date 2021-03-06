import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genchi_web/components/edit_account_text_field.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/screens/register_screen.dart';
import 'package:genchi_web/services/firestore_api_service.dart';

class UniversityNotListedScreen extends StatefulWidget {
  static const String id = '/uninotlisted';

  @override
  _UniversityNotListedScreenState createState() =>
      _UniversityNotListedScreenState();
}

class _UniversityNotListedScreenState extends State<UniversityNotListedScreen> {
  TextEditingController universityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  bool showSpinner = false;

  @override
  void dispose() {
    super.dispose();
    universityController.dispose();
    emailController.dispose();
    reasonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kGenchiCream),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            color: Color(kGenchiGreen),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // _index = 0;
                      });
                    },
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.07),
                        child: Image.asset('images/Logo_Only.png')),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Center(
            child: Container(
              width: 300,
              child: EditAccountField(
                textController: universityController,
                field: 'What University are you from?',
                onChanged: (value) {},
                hintText: 'Enter University',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 300,
              child: EditAccountField(
                textController: emailController,
                field: 'Email (optional)',
                onChanged: (value) {},
                hintText: 'Enter email',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 400,
              child: EditAccountField(
                textController: emailController,
                field: 'What would you like Genchi for? (optional)',
                onChanged: (value) {},
                hintText: 'Enter reason',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: MaterialButton(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Color(kGenchiGreen),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onPressed: () async {
                if (universityController.text != '' ||
                    emailController.text != '' ||
                    reasonController.text != '') {
                  setState(() {
                    showSpinner = true;
                  });

                  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                  await firebaseAuth.signInAnonymously();
                  firebaseAuth.currentUser;

                  final FirestoreAPIService firestore = FirestoreAPIService();

                  await firestore.addUniveristy(
                      uni: universityController.text,
                      email: emailController.text,
                      reason: reasonController.text);

                  universityController.clear();
                  emailController.clear();
                  reasonController.clear();

                  await firebaseAuth.signOut();
                  setState(() {
                    showSpinner = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Color(kGenchiLightOrange),
                    duration: Duration(seconds: 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    content: const Text(
                      'Thanks!\nWe will do our best to bring Genchi to you soon!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'FuturaPT',
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ));
                }
              },
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 1,
            endIndent: MediaQuery.of(context).size.width * 0.25,
            indent: MediaQuery.of(context).size.width * 0.25,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: MaterialButton(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,

              onPressed: () {
                Navigator.pushNamed(context,RegisterScreen.id);
              },
              child:Center(
                child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Back to ',
                          style: TextStyle(
                              fontFamily: 'FuturaPT',
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                      TextSpan(
                        text: 'Create Account',
                        style: TextStyle(
                            color: Color(kGenchiOrange),
                            fontFamily: 'FuturaPT',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ])),
              ),
            ),
          )
        ],
      ),
    );
  }
}
