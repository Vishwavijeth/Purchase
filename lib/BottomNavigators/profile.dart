import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? name;
  TextEditingController? phone;
  TextEditingController? age;

  Future<void> Logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  SetDataToTextField(data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.grey,
              filled: true,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            //initialValue: 'Name',
            controller: name = TextEditingController(
              text: data['name'],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.grey,
              filled: true,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            controller: phone = TextEditingController(
              text: data['phone'],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.grey,
              filled: true,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            controller: age = TextEditingController(
              text: data['age'],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => UpdateData(),
            child: Text(
              'Update',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => Logout(),
            child: Text(
              'Log out',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  UpdateData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Users-Form-Data');
    return collectionReference
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'name': name!.text,
      'phone': phone!.text,
      'age': age!.text
    }).then((value) => print('updated'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users-Form-Data')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data = snapshot.data;

              if (data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SetDataToTextField(data);
            },
          ),
        ),
      ),
    );
  }
}
