import 'package:e_commerce/Screens/AppColor.dart';
import 'package:e_commerce/Screens/PaymentSuccess.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  final int totalPrice;

  const Payment({Key? key, required this.totalPrice}) : super(key: key);
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final paymentLabels = [
    'Credit Card / Debit Card',
    'Cash on delivery',
    'Google Wallet',
    'PayPal'
  ];

  final paymentIcons = [
    Icons.credit_card,
    Icons.money_off,
    Icons.account_balance,
    Icons.payment
  ];

  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.lightBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Payment',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Center(
              child: Text(
                'Total Fare: \$${widget.totalPrice}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              'Choose your payment method',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Radio(
                  activeColor: AppColor.lightBlue,
                  value: index,
                  groupValue: value,
                  onChanged: (i) => setState(() {
                    value = i!;
                  }),
                ),
                title: Text(
                  paymentLabels[index],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(
                  paymentIcons[index],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: paymentLabels.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccess(),
                  ),
                );
              },
              child: Text(
                'Pay',
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
