import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/BottomNavigators/BottomController.dart';
import 'package:e_commerce/Screens/AppColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _name = TextEditingController();
  TextEditingController _mob = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _age = TextEditingController();

  List<String> gender = ['Male', 'Female', 'Other'];

  Future<void> SelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dob.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  UserData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var curUser = _auth.currentUser;

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Users-Form-Data');
    return collectionReference.doc(curUser!.email).set({
      "name": _name.text,
      "phone": _mob.text,
      "dob": _dob.text,
      "gender": _gender.text,
      "age": _age.text,
    }).then(
      (value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavController(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Submit the form to continue',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: AppColor.lightBlue,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _name,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _mob,
                  decoration: InputDecoration(
                    hintText: 'Enter your mobile number',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _dob,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Date of birth',
                    suffixIcon: IconButton(
                      onPressed: () => SelectDate(context),
                      icon: Icon(
                        Icons.calendar_today_outlined,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _gender,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: ' Gender',
                      suffixIcon: DropdownButton<String>(
                        iconSize: 25.0,
                        items: gender.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: new Text(value),
                            onTap: () {
                              setState(() {
                                _gender.text = value;
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (_) {},
                      )),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _age,
                  decoration: InputDecoration(
                    hintText: 'Enter your age',
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightBlue),
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
                      UserData();
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
