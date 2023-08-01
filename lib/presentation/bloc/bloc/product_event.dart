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

class CoupenRedeem extends ProductEvent {
  final CouponModel couponModel;

  CoupenRedeem(this.couponModel);
}

class TimeSlotSelected extends ProductEvent {
  final TimeSlot timeSlot;

  TimeSlotSelected(this.timeSlot);
}

class PlaceOrder extends ProductEvent {}

class ContinueShopping extends ProductEvent {}

class CancelPurchase extends ProductEvent {}
