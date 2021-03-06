import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:genchi_web/components/edit_account_text_field.dart';
import 'package:genchi_web/components/platform_alerts.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/models/user.dart';
import 'package:genchi_web/screens/opportunities_screen.dart';
import 'package:genchi_web/screens/sign_in_screen.dart';
import 'package:genchi_web/screens/uni_not_listed_screen.dart';
import 'package:genchi_web/services/account_service.dart';
import 'package:genchi_web/services/authentication_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController universityTypeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool showErrorField = false;
  String errorMessage = '';

  bool showSpinner = false;

  bool agreed = false;

  @override
  void initState() {
    super.initState();
    accountTypeController.text = 'Select type';
    universityTypeController.text = 'Select University';
  }

  @override
  void dispose() {
    super.dispose();
    accountTypeController.dispose();
    universityTypeController.dispose();
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationService authProvider =
        Provider.of<AuthenticationService>(context);

    AccountService accountService = Provider.of<AccountService>(context);
    return Scaffold(
      backgroundColor: Color(kGenchiCream),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(kGenchiOrange),
          ),
          strokeWidth: 3.0,
        ),
        child: Scrollbar(
          child: ListView(
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
                    onChanged: (value) {},
                    field: 'Name',
                    hintText: "Enter name",
                    textController: nameController,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          'University',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: PopupMenuButton(
                            elevation: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 0.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20.0),
                                child: Text(
                                  universityTypeController.text,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: universityTypeController.text ==
                                            'Select University'
                                        ? Colors.black45
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            itemBuilder: (_) {
                              List<PopupMenuItem<String>> items = [
                                new PopupMenuItem<String>(
                                    child: Text(
                                      'Select University',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    value: 'Select University')
                              ];
                              for (String accountType
                                  in GenchiUser().accessibleUniversities) {
                                items.add(
                                  new PopupMenuItem<String>(
                                      child: Text(accountType),
                                      value: accountType),
                                );
                              }
                              return items;
                            },
                            onSelected: (value) {
                              universityTypeController.text = value;
                              setState(() {});
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              'Account Type',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          IconButton(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.help_outline_outlined,
                              size: 18,
                            ),
                            onPressed: () async {
                              await showDialogBox(
                                  context: context,
                                  title: 'Account Type',
                                  body:
                                      'Are you creating this account as an individual or for a society / project group?');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: new PopupMenuButton(
                          elevation: 1,
                          itemBuilder: (_) {
                            List<PopupMenuItem<String>> items = [
                              new PopupMenuItem<String>(
                                  child: Text(
                                    'Select type',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  value: 'Select type')
                            ];
                            for (String accountType
                                in GenchiUser().accessibleAccountTypes) {
                              items.add(
                                new PopupMenuItem<String>(
                                    child: Text(accountType),
                                    value: accountType),
                              );
                            }
                            return items;
                          },
                          onSelected: (value) {
                            accountTypeController.text = value;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 20.0),
                              child: Text(
                                accountTypeController.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: accountTypeController.text ==
                                          'Select type'
                                      ? Colors.black45
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 300,
                  child: EditAccountField(
                    field: 'Email',
                    onChanged: (value) {},
                    hintText: 'Enter your email',
                    textController: emailController,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 300,
                  child: EditAccountField(
                    field: 'Password',
                    isPassword: true,
                    onChanged: (value) {},
                    textController: passwordController,
                    hintText: 'Enter your password',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: agreed,
                      onChanged: (value) {
                        setState(() {
                          agreed = value;
                        });
                      }),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'I have read and accept the ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch('https://www.genchi.app/privacy-policy');
                            },
                        ),
                        TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              showErrorField
                  ? SizedBox(
                      height: 20,
                      child: Center(
                          child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )))
                  : SizedBox(
                      height: 20,
                    ),
              SizedBox(height: 5),
              Center(
                child: MaterialButton(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    setState(() {
                      showErrorField = false;
                      showSpinner = true;
                    });
                    try {
                      if (nameController.text == '' ||
                          emailController.text == '' ||
                          accountTypeController.text == 'Select type' ||
                          universityTypeController.text == 'Select University')
                        throw (Exception('Enter name, email and account type'));

                      if (agreed == false)
                        throw (Exception('Please accept the Privacy Policy'));

                      await authProvider.registerWithEmail(
                          email: emailController.text.replaceAll(' ', ''),
                          password: passwordController.text,
                          uni: universityTypeController.text,
                          type: accountTypeController.text,
                          name: nameController.text);

                      await FirebaseAnalytics()
                          .logSignUp(signUpMethod: 'email');

                      ///This populates the current user simultaneously
                      if (await authProvider.isUserLoggedIn() == true) {
                        ///Registration complete, so now handing over to the accountService to handle provider
                        await accountService.updateCurrentAccount(
                            id: authProvider.currentUser.id);

                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            OpportunitiesScreen.id,
                            (Route<dynamic> route) => false);
                            // arguments: PreferencesScreenArguments(
                            //     isFromRegistration: true));
                      }
                    } catch (e) {
                      print(e);
                      showErrorField = true;
                      errorMessage = e.message;
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Color(kGenchiOrange),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        'GO AND SEE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
                endIndent: MediaQuery.of(context).size.width * 0.25,
                indent: MediaQuery.of(context).size.width * 0.25,
              ),
              Center(
                child: MaterialButton(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, SignInScreen.id);
                  },
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Have an account? ',
                        style: TextStyle(
                            fontFamily: 'FuturaPT',
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                    TextSpan(
                      text: 'Log in',
                      style: TextStyle(
                          color: Color(kGenchiOrange),
                          fontFamily: 'FuturaPT',
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ])),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: MaterialButton(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pushNamed(context, UniversityNotListedScreen.id);
                  },
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Color(kGenchiBlue),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        'University not listed?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
