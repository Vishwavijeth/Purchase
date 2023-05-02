import 'package:e_commerce/BottomNavigators/BottomController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  String curEmail = '';
  String curPass = '';

  SignIn() async {
    if (curEmail.isEmpty || curPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email and password'),
        ),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: curEmail, password: curPass);

        var authCredential = userCredential.user;
        print(authCredential?.uid);

        if (authCredential != null &&
            authCredential.uid != null &&
            authCredential.uid.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavController(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';

        if (e.code == 'user-not-found') {
          errorMessage = 'No user found';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Please enter a valid email address';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: $e',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Purchase',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: usernameController,
              onChanged: (value) {
                setState(() {
                  curEmail = value;
                });
              },
              decoration: InputDecoration(
                  hintText: 'Enter your email',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        15.0,
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  curPass = value;
                });
              },
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Enter your password',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        15.0,
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 25.0,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(
                    22.0,
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                SignIn();
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 17.0,
                ),
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            GestureDetector(
              onTap: () {
                print('forgot tapped');
              },
              child: Text(
                'Forgot your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Divider(
              color: Colors.black,
              thickness: 1.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                GestureDetector(
                  onTap: () {
                    print('signUp tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
