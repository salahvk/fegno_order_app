part of 'product_bloc.dart';

abstract class ProductState {}

class ProductBlocInitial extends ProductState {
  List<CartItemModel>? cartItem;
  bool? isHome;
  CouponModel? couponModel;
  List<TimeSlot>? timeSlot;
  TimeSlot? selectedTimeSlot;

  ProductBlocInitial(
      {this.cartItem,
      this.isHome,
      this.couponModel,
      this.timeSlot,
      this.selectedTimeSlot});
}

class ProductItemAdded extends ProductState {
  final List<CartItemModel> cartItem;

  ProductItemAdded(this.cartItem);
}
