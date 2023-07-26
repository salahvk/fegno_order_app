part of 'product_bloc_bloc.dart';

@immutable
abstract class ProductBlocState {}

class ProductBlocInitial extends ProductBlocState {}

class ProductBlocLoaded extends ProductBlocState {
  final List<CartItem> cartItem;

  ProductBlocLoaded(this.cartItem);
}
