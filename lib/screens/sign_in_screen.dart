import 'package:flutter/material.dart';
import 'package:genchi_web/components/edit_account_text_field.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/screens/opportunities_screen.dart';
import 'package:genchi_web/services/authentication_service.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const id = 'sign_in_screen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      backgroundColor: Color(kGenchiGreen),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: 200,
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
                width: 200,
                child: EditAccountField(
                  field: 'Password',
                  onChanged: (value) {},
                  textController: passwordController,
                  hintText: 'Enter your password',
                ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              height: 50,
              width: 100,
              child: RaisedButton(
                onPressed: () async{
                  try {
                    if (emailController.text == '') throw (Exception('Enter email'));

                    await authProvider.loginWithEmail(
                        email: emailController.text, password: passwordController.text);

                    //This populates the current user simultaneously
                    if (await authProvider.isUserLoggedIn() == true) {
                  Navigator.pushNamedAndRemoveUntil(
                  context,
                  OpportunitiesScreen.id,
                  (Route<dynamic> route) => false);
                  }
                  } catch (e) {
                  print(e);
                  // showErrorField = true;
                  // errorMessage = e.message;
                  }

                },
                color: Color(kGenchiOrange),
                child: Text('Sign In'),
              ),
            )

            // showErrorField ? PasswordErrorText(errorMessage: errorMessage) : SizedBox(height: 30.0),
            // RoundedButton(
            //   buttonColor: Color(kGenchiOrange),
            //   buttonTitle: "Log In",
            //   onPressed: () async {
            //     setState(() {
            //       showErrorField = false;
            //       showSpinner = true;
            //     });
            //     try {
            //       if (email == null) throw (Exception('Enter email'));
            //
            //       await authProvider.loginWithEmail(
            //           email: email, password: password);
            //
            //       //This populates the current user simultaneously
            //       if (await authProvider.isUserLoggedIn() == true) {
            //         Navigator.pushNamedAndRemoveUntil(
            //             context,
            //             HomeScreen.id,
            //                 (Route<dynamic> route) => false);
            //       }
            //     } catch (e) {
            //       print(e);
            //       showErrorField = true;
            //       errorMessage = e.message;
            //     }
            //     setState(() {
            //       showSpinner = false;
            //     });
            //   },
            // ),
            // RoundedButton(
            //   buttonColor: Color(kGenchiBlue),
            //   buttonTitle: "Forgot password",
            //   onPressed: () {
            //     Navigator.pushNamed(context, ForgotPasswordScreen.id);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
