part of 'product_bloc.dart';

abstract class ProductState {}

class ProductBlocInitial extends ProductState {
  List<CartItemModel>? cartItem;

  ProductBlocInitial({
    this.cartItem,
  });
}

class ProductItemAdded extends ProductState {
  final List<CartItemModel> cartItem;

  ProductItemAdded(this.cartItem);
}
