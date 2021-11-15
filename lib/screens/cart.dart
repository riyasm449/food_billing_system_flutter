import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_bill/models/provider.dart';
import 'package:food_bill/utils/cartbutton.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FoodProvider foodProvider;
  @override
  Widget build(BuildContext context) {
    foodProvider = Provider.of<FoodProvider>(context);
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 60,
      height: (MediaQuery.of(context).size.height) - 100,
      constraints: BoxConstraints(maxWidth: 450, minWidth: 150),
      color: Colors.white,
      child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Cart",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          if (!foodProvider.cart.isNotEmpty)
            Column(
              children: [
                SizedBox(height: 70),
                Icon(
                  Icons.add_shopping_cart_rounded,
                  size: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cart is Empty",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Some items to Cart",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                for (int index = 0; index < foodProvider.cart.length; index++)
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
                              foodProvider.cart[index].product.name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              "₹" + foodProvider.cart[index].product.price.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            CartButton(
                              product: foodProvider.cart[index].product,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "|  ₹" +
                                  (foodProvider.cart[index].product.price * foodProvider.cart[index].qty).toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        ),
                      ])),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Amount: ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "₹" + foodProvider.tatal.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}
