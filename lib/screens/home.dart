import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_bill/models/product.dart';
import 'package:food_bill/screens/cart.dart';
import 'package:food_bill/utils/cartbutton.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                "Billing System",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              // crossAxisSpacing: 1,
              physics: NeverScrollableScrollPhysics(),
              children: [productsCard(), CartScreen()],
            ),
          ],
        ));
  }

  Widget productsCard() {
    return Container(
      child: Column(
        children: [
          Text(
            "Products List",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('product').snapshots(),
              builder: (context, parentSnapShot) {
                if (parentSnapShot.hasError) {
                  return Center(child: Text('Error occured ${parentSnapShot.error}'));
                }
                switch (parentSnapShot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());

                  default:
                    if (!parentSnapShot.hasData) {
                      return Text('No one is joined');
                    }
                    ProductList products = ProductList.fromJson(parentSnapShot.data.docs);
                    int len = parentSnapShot.data.size;

                    return ListView(
                      shrinkWrap: true,
                      children: [
                        for (int i = 0; i < len; i++)
                          Stack(alignment: Alignment.center, children: [
                            Container(
                              width: (MediaQuery.of(context).size.width / 2) - 60,
                              margin: EdgeInsets.all(10),
                              height: 160,
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width / 2) - 60,
                              constraints: BoxConstraints(maxWidth: 450, minWidth: 150),
                              margin: EdgeInsets.all(10),
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                                top: 0,
                                child: Column(children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width / 2) - 60,
                                    constraints: BoxConstraints(maxWidth: 450, minWidth: 150),
                                    margin: EdgeInsets.all(10),
                                    height: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[100],
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(products.product[i].image),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Container(
                                      width: (MediaQuery.of(context).size.width / 2) - 60,
                                      constraints: BoxConstraints(maxWidth: 450, minWidth: 150),
                                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              products.product[i].name,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            Text(
                                              "₹" + products.product[i].price.toString(),
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                            )
                                          ],
                                        ),
                                        CartButton(
                                          product: products.product[i],
                                        )
                                      ]))
                                ]))
                          ])
                      ],
                    );
                }
              }),
        ],
      ),
    );
  }
}
