import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/Screens/AppColor.dart';
import 'package:e_commerce/Screens/ProductDetailScreen.dart';
import 'package:e_commerce/Screens/searchScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  List<String> carouselImages = [];
  var DotPosition = 0;
  //List products = [];
  List<Map<String, dynamic>> products = [];
  var firestoreInstance = FirebaseFirestore.instance;

  FetchCarouselImages() async {
    var firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot q =
        await firestoreInstance.collection('carousel-slider').get();
    setState(
      () {
        for (int i = 0; i < q.docs.length; i++) {
          carouselImages.add(
            q.docs[i]['img-path'],
          );
        }
      },
    );
    return q.docs;
  }

  Future<void> FetchProducts() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    querySnapshot.docs.forEach((doc) {
      final data = doc.data();
      products.add({
        'product-description': data['product-description'],
        'product-img': data['product-img'],
        'product-name': data['product-name'],
        'product-prize': data['product-prize'],
      });
    });
    //print('Fetched ${products.length} products');
  }

  @override
  void initState() {
    FetchCarouselImages();
    FetchProducts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    hintText: 'Search products here',
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                  items: carouselImages
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(item),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      //reverse: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChanged) {
                        setState(() {
                          DotPosition = val;
                        });
                      }),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              DotsIndicator(
                dotsCount:
                    carouselImages.length == 0 ? 1 : carouselImages.length,
                position: DotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: AppColor.lightBlue,
                  color: AppColor.lightBlue.withOpacity(0.5),
                  spacing: EdgeInsets.all(2),
                  activeSize: Size(8, 8),
                  size: Size(6, 6),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemBuilder: (_, index) {
                    //print('itemcount : ${products.length}');
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(products[index]),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          margin:
                              EdgeInsets.only(bottom: 50, left: 0, right: 0),
                          elevation: 3,
                          child: Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: Container(
                                  color: Colors.lightGreen,
                                  child: Image.network(
                                    products[index]['product-img'],
                                  ),
                                ),
                              ),
                              Text(
                                " ${products[index]['product-name']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                "\$ ${products[index]['product-prize'].toString()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
