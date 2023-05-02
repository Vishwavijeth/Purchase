import 'package:e_commerce/Screens/LoginScreen.dart';
import 'package:e_commerce/Screens/UserForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
RegExp regExp = RegExp(emailRegex);

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String user = '';
  String pass = '';
  String mail = '';

  SignUp() async {
    if (mail.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your email and password',
          ),
        ),
      );
    } else if (!regExp.hasMatch(mail)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email address'),
        ),
      );
    } else if (pass.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password is too short'),
        ),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail, password: pass);
        var authCredential = userCredential.user;

        //print(authCredential?.uid);

        if (authCredential != null &&
            authCredential.uid != null &&
            authCredential.uid.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserForm(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        //print(e);
        String errorMessage = '';
        if (e.code == 'email-already-in-use') {
          errorMessage = 'Email is already in used by another user';
        } else if (e.code == 'weak-password') {
          errorMessage = 'Password is too short';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Please enter a valid email';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
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
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: email,
              onChanged: (value) {
                setState(() {
                  mail = value;

                  // if (mail == "") {
                  //   print('Fill the email');
                  // } else if (!regExp.hasMatch(value)) {
                  //   print('Invalid email');
                  // }
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
                  pass = value;

                  // if (value == "") {
                  //   print("Please fill the password");
                  // } else if (value.length < 8) {
                  //   print("Password is too short");
                  // }
                });
              },
              controller: password,
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
                SignUp();
              },
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 17.0,
                ),
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            Divider(
              color: Colors.black,
              thickness: 1.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Do have an account? ',
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
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign In',
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
