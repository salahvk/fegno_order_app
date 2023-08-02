part of 'product_bloc.dart';

abstract class ProductState {}

class ProductBlocInitial extends ProductState {
  List<CartItemModel>? cartItem;
  bool? isHome;
  bool? ispaymentSuccess;
  CouponModel? couponModel;
  List<TimeSlot>? timeSlot;
  TimeSlot? selectedTimeSlot;

  ProductBlocInitial(
      {this.cartItem,
      this.isHome,
      this.couponModel,
      this.timeSlot,
      this.selectedTimeSlot,
      this.ispaymentSuccess});
}

class ProductItemAdded extends ProductState {
  final List<CartItemModel> cartItem;

  ProductItemAdded(this.cartItem);
}

class PaymentSuccess extends ProductState {
  final String itemTotal;
  final String coupenDiscount;
  final String grandTotal;

  PaymentSuccess(
      {required this.itemTotal,
      required this.coupenDiscount,
      required this.grandTotal});
}
