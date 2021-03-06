import 'package:flutter/material.dart';
import 'package:genchi_web/components/edit_account_text_field.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/screens/opportunities_screen.dart';
import 'package:genchi_web/screens/register_screen.dart';
import 'package:genchi_web/services/authentication_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const id = '/login';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showErrorField = true;
  String errorMessage = '';
  bool showSpinner = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  try {
                    if (emailController.text == '')
                      throw (Exception('Enter email'));

                    setState(() {
                      showSpinner = true;
                    });

                    await authProvider.loginWithEmail(
                        email: emailController.text,
                        password: passwordController.text);

                    setState(() {
                      showSpinner = false;
                    });
                    //This populates the current user simultaneously
                    if (await authProvider.isUserLoggedIn() == true) {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          OpportunitiesScreen.id,
                          (Route<dynamic> route) => false);
                    }
                  } catch (e) {
                    print(e);
                    showErrorField = true;
                    errorMessage = e.message;
                    showSpinner = false;
                    setState(() {});
                  }
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(kGenchiOrange),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'LOG IN',
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
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(kGenchiGreen),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
