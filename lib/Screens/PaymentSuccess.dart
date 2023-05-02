import 'package:e_commerce/BottomNavigators/BottomController.dart';
import 'package:flutter/material.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: NetworkImage(
                'https://openjournalsystems.com/wp-content/uploads/2017/07/payment-success.png'),
          ),
          Center(
            child: Text(
              'Your Payment was done successfully!!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavController(),
                ),
              );
            },
            child: Text('Done',
                style: TextStyle(
                  fontSize: 25,
                )),
          ),
        ],
      ),
    );
  }
}
