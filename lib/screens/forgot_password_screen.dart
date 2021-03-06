import 'package:flutter/material.dart';
import 'package:genchi_web/components/edit_account_text_field.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/screens/sign_in_screen.dart';
import 'package:genchi_web/services/authentication_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';


class ForgotPasswordScreen extends StatefulWidget {
  static const String id = '/forgotpassword';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  bool showSpinner = false;
  bool showErrorField = false;
  String errorMessage = '';


  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Forgot password screen open');
    AuthenticationService authProvider =
    Provider.of<AuthenticationService>(context);
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
        child: ListView(
          children: <Widget>[
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
              height: MediaQuery.of(context).size.height * 0.15,
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
            SizedBox(
              height: 5,
            ),
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
            SizedBox(
              height: 5,
            ),
            Center(
              child: MaterialButton(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onPressed: () async {

                  setState(() {
                    showErrorField = false;
                    showSpinner = true;
                  });
                  try {
                    print(emailController.text == '');
                    if (emailController.text != '') {
                      await authProvider.sendResetEmail(email: emailController.text);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color(kGenchiLightOrange),
                        duration: Duration(seconds: 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0))),
                        content: const Text(
                          'Thanks!\nCheck your email for a reset email!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'FuturaPT',
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ));
                    } else {
                      throw (Exception('Enter email'));
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
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(kGenchiOrange),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'Send Password Reset',
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
            SizedBox(height: 10),
            Center(
              child: MaterialButton(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,

                onPressed: () {
                  Navigator.pushNamed(context,SignInScreen.id);
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
                          text: 'Sign In',
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
      ),
    );
  }
}
