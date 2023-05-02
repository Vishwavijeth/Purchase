import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users-Favourite-Items')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection('items')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something is wrong'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Card(
                    elevation: 3.0,
                    child: ListTile(
                      leading: Text(
                        documentSnapshot['name'],
                        style: TextStyle(fontSize: 25),
                      ),
                      title: Text(
                        "\$ ${documentSnapshot['price']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.red,
                        ),
                      ),
                      trailing: GestureDetector(
                        child: CircleAvatar(
                          child: Icon(Icons.remove_circle),
                        ),
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('Users-Favourite-Items')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection('items')
                              .doc(documentSnapshot.id)
                              .delete();
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
