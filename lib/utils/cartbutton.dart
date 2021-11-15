import 'package:flutter/material.dart';
import 'package:food_bill/models/product.dart';
import 'package:food_bill/models/provider.dart';
import 'package:provider/provider.dart';

class CartButton extends StatefulWidget {
  final Product product;

  const CartButton({Key key, this.product}) : super(key: key);
  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  int cartValue = 0;
  FoodProvider foodProvider;
  @override
  Widget build(BuildContext context) {
    foodProvider = Provider.of<FoodProvider>(context);
    return Container(
      width: 100,
      height: 25,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              foodProvider.addCart(widget.product);
            },
            child: Container(
              height: 25,
              width: 25,
              color: Colors.green,
              alignment: Alignment.center,
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
          Container(
            height: 25,
            width: 50,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text(
              foodProvider.isInCart(widget.product)
                  ? foodProvider.cart[foodProvider.indexInCart(widget.product)].qty.toString()
                  : "0",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              foodProvider.removeCart(widget.product);
            },
            child: Container(
              height: 25,
              width: 25,
              color: Colors.green,
              alignment: Alignment.center,
              child: Icon(Icons.remove, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
