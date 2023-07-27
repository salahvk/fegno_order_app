part of 'product_bloc.dart';

abstract class ProductState {}

class ProductBlocInitial extends ProductState {
  List<CartItemModel>? cartItem;
  bool? isCoupenAvailable;

  ProductBlocInitial({this.cartItem, this.isCoupenAvailable});
}

class ProductItemAdded extends ProductState {
  final List<CartItemModel> cartItem;

  ProductItemAdded(this.cartItem);
}
