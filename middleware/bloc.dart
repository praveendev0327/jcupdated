import 'package:bloc/bloc.dart';
import 'package:justcall/middleware/events.dart';
import 'package:justcall/middleware/state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState([])) {
    on<AddProduct>((event, emit) {
      // print("event : ${event}");
      final updatedProducts = List<Product>.from(state.products);
      final productIndex = updatedProducts.indexWhere((p) => p.name == event.productName);

      if (productIndex != -1) {
        updatedProducts[productIndex].quantity += 1;

      } else {
        updatedProducts.add(Product(name: event.productName, price: event.productPrice));
        // print("bloc : ${event.productName}");
      }

      emit(ProductState(updatedProducts));
    });

    on<RemoveProduct>((event, emit) {
      final updatedProducts = List<Product>.from(state.products);
      final productIndex = updatedProducts.indexWhere((p) => p.name == event.productName);

      if (productIndex != -1) {
        if (updatedProducts[productIndex].quantity > 1) {
          updatedProducts[productIndex].quantity -= 1;
        } else {
          updatedProducts.removeAt(productIndex);
        }
      }

      emit(ProductState(updatedProducts));
    });

    on<DeleteProduct>((event, emit) {
      final updatedProducts = List<Product>.from(state.products);
      final productIndex = updatedProducts.indexWhere((p) => p.name == event.productName);

      if (productIndex != -1) {
        if (updatedProducts[productIndex].quantity > 1) {
          updatedProducts[productIndex].quantity -= 1;
        } else {
          updatedProducts.removeAt(productIndex);
        }
      }

      emit(ProductState(updatedProducts));
    });

    on<ResetProduct>((event, emit) {
      emit(ProductState([])); // Emit initial state or any other default state
    });
  }
}
