part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class InitialFetchEvent extends ProductEvent {}

class AddItemEvent extends ProductEvent {
  final CartItemModel cartItem;

  AddItemEvent(this.cartItem);
}

class IncrementQuantityEvent extends ProductEvent {
  final CartItemModel cartItem;

  IncrementQuantityEvent(this.cartItem);
}

class DecrementQuantityEvent extends ProductEvent {
  final CartItemModel cartItem;

  DecrementQuantityEvent(this.cartItem);
}

class DeliveryMethodSelection extends ProductEvent {
  final bool isHome;

  DeliveryMethodSelection(this.isHome);
}
