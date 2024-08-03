import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final int id;
  final String branchName;
  final String productName;
  final String unit;
  final String mainGroup;
  final String subGroup;
  final String barcode;
  final double unitCost;
  final double profitMargin;
  final double profitMarkup;
  final double price1;
  final String imgUrl;


  Product({
    required this.id,
    required this.branchName,
    required this.productName,
    required this.unit,
    required this.mainGroup,
    required this.subGroup,
    required this.barcode,
    required this.unitCost,
    required this.profitMargin,
    required this.profitMarkup,
    required this.price1,
    required this.imgUrl,
  });

  // factory Product.fromFirestore(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return Product(
  //     id: doc.id,
  //     name: data['name'],
  //     description: data['description'],
  //     productType: data['productType'],
  //     gender: data['gender'],
  //     category: data['category'],
  //     color: data['color'],
  //     role: data['role'],
  //   );
  // }
  //
  //
  //
  // factory Product.fromDocument(DocumentSnapshot doc) {
  //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //   return Product(
  //     id: doc.id,
  //     name: data['name'],
  //     description: data['description'],
  //     productType: data['productType'],
  //     gender: data['gender'],
  //     category: data['category'],
  //     color: data['color'],
  //     role: data['role'],
  //   );
  // }


}
