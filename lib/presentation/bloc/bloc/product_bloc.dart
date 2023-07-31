import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fegno_order_app/data/datasource/dummy_cartdata.dart';
import 'package:fegno_order_app/data/datasource/dummy_timeslots.dart';
import 'package:fegno_order_app/data/db/mycart.dart';
import 'package:fegno_order_app/domain/entities/cart_item.dart';
import 'package:fegno_order_app/domain/entities/coupen_model.dart';
import 'package:fegno_order_app/domain/entities/time_slot_model.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  static var cartList = GetIt.I<MyCartList>().myList;
  static final dummyData = DummyDataSource()
      .getCartItems()
      .map((e) => CartItemModel(
          itemName: e['itemName'],
          price: e['price'].toDouble(),
          quantity: (e['quantity']),
          quantityUnit: e['quantityUnit'],
          imageUrl: e['imageUrl']))
      .toList();
  static final timeSlots = DummyTimeSlots()
      .getTimeSlots()
      .map((e) => TimeSlot(timeslot: e['timeslot']))
      .toList();
  ProductBloc() : super(ProductBlocInitial(cartItem: dummyData)) {
    on<AddItemEvent>(addItemEvent);
    on<IncrementQuantityEvent>(incrementQuantityEvent);
    on<DecrementQuantityEvent>(decrementQuantityEvent);
    on<DeliveryMethodSelection>(deliveryMethodSelection);
    on<CoupenRedeem>(coupenRedeem);
    on<TimeSlotSelected>(timeSlotSelected);
    on<PlaceOrder>(placeOrder);
  }

  FutureOr<void> addItemEvent(AddItemEvent event, Emitter<ProductState> emit) {
    final currentEvent = event;
    cartList.add(currentEvent.cartItem);
    dummyData.remove(currentEvent.cartItem);

    emit(ProductBlocInitial(cartItem: dummyData));
  }

  FutureOr<void> incrementQuantityEvent(
      IncrementQuantityEvent event, Emitter<ProductState> emit) {
    for (var item in cartList) {
      if (item.itemName == event.cartItem.itemName) {
        item.quantity += 1;

        emit(ProductBlocInitial(cartItem: dummyData));
        break;
      }
    }
  }

  FutureOr<void> decrementQuantityEvent(
      DecrementQuantityEvent event, Emitter<ProductState> emit) {
    for (var item in cartList) {
      if (item.itemName == event.cartItem.itemName && item.quantity != 0) {
        item.quantity -= 1;

        emit(ProductBlocInitial(cartItem: dummyData));
        break;
      }
    }
  }

  FutureOr<void> deliveryMethodSelection(
      DeliveryMethodSelection event, Emitter<ProductState> emit) {
    emit(ProductBlocInitial(
        cartItem: dummyData, isHome: event.isHome, timeSlot: timeSlots));
  }

  FutureOr<void> coupenRedeem(CoupenRedeem event, Emitter<ProductState> emit) {
    emit(ProductBlocInitial(
        cartItem: dummyData, couponModel: event.couponModel));
  }

  FutureOr<void> timeSlotSelected(
      TimeSlotSelected event, Emitter<ProductState> emit) {
    final prevState = state;
    if (prevState is ProductBlocInitial) {
      emit(ProductBlocInitial(
          cartItem: dummyData,
          isHome: prevState.isHome,
          timeSlot: timeSlots,
          selectedTimeSlot: event.timeSlot,
          couponModel: prevState.couponModel));
    }
  }

  FutureOr<void> placeOrder(PlaceOrder event, Emitter<ProductState> emit) {
    emit(PaymentSuccess());
  }
}
