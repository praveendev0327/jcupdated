import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProduct extends ProductEvent {
  final String productName;
  double productPrice;
  AddProduct(this.productName, this.productPrice);

  @override
  List<Object> get props => [productName,productPrice];
}

class RemoveProduct extends ProductEvent {
  final String productName;
  RemoveProduct(this.productName);

  @override
  List<Object> get props => [productName];
}

class ResetProduct extends ProductEvent {}

class DeleteProduct extends ProductEvent {
  final String productName;
  DeleteProduct(this.productName);

  @override
  List<Object> get props => [productName];
}
