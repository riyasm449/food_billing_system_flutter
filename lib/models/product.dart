import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  int price;
  String image;

  Product({this.name, this.price, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}

class ProductList {
  List<Product> product;

  ProductList({this.product});

  ProductList.fromJson(List<QueryDocumentSnapshot> json) {
    // if (json['product'] != null) {
    product = new List<Product>();
    json.forEach((v) {
      product.add(new Product.fromJson(v.data()));
    });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
