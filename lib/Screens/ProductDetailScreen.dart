import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Screens/AppColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  var product;
  ProductDetails(this.product);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Future AddToCart() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var curUser = auth.currentUser;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Users-Cart-Items');
    return collectionReference
        .doc(curUser!.email)
        .collection('items')
        .doc()
        .set({
      'name': widget.product['product-name'],
      'price': widget.product['product-prize'],
      'images': widget.product['product-img']
    }).then((value) => print('added to favourite'));
  }

  Future AddToFavourite() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var curUser = auth.currentUser;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Users-Favourite-Items');
    return collectionReference
        .doc(curUser!.email)
        .collection('items')
        .doc()
        .set({
      'name': widget.product['product-name'],
      'price': widget.product['product-prize'],
      'images': widget.product['product-img']
    }).then((value) => print('added to cart'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColor.lightBlue,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users-Favourite-Items')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection('items')
                .where('name', isEqualTo: widget.product['product-name'])
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text('');
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: AppColor.lightBlue,
                  child: IconButton(
                    onPressed: () => snapshot.data.docs.length == 0
                        ? AddToFavourite()
                        : print('Already added'),
                    icon: snapshot.data.docs.length == 0
                        ? Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                  items: [
                    for (final imageUrl in [widget.product['product-img']])
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                  ],
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      //reverse: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChanged) {
                        setState(() {});
                      }),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Center(
                child: Text(
                  widget.product['product-name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.product['product-description'],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "\$ ${widget.product["product-prize"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => AddToCart(),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.lightBlue,
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
