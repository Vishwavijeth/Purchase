import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users-Cart-Items')
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

            totalPrice = 0;
            for (var doc in snapshot.data!.docs) {
              totalPrice += doc['price'] as int;
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
                              .collection('Users-Cart-Items')
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$ $totalPrice',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
