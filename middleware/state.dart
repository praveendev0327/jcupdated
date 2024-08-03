import 'package:equatable/equatable.dart';

class Product {
  final String name;
  int quantity;
  double price;

  Product({required this.name, this.quantity = 1, required this.price});


}

class ProductState extends Equatable {
  final List<Product> products;

  ProductState(this.products);

  @override
  List<Object> get props => [products];

  double get grandTotal => products.fold(0.0, (total, product) => total + (product.price * product.quantity));
}
