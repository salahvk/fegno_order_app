import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fegno_order_app/data/datasource/dummy_cartdata.dart';
import 'package:fegno_order_app/data/db/mycart.dart';
import 'package:fegno_order_app/domain/entities/cart_item.dart';
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
  ProductBloc() : super(ProductBlocInitial(cartItem: dummyData)) {
    on<AddItemEvent>(addItemEvent);
    on<IncrementQuantityEvent>(incrementQuantityEvent);
    on<DecrementQuantityEvent>(decrementQuantityEvent);
  }

  FutureOr<void> addItemEvent(AddItemEvent event, Emitter<ProductState> emit) {
    final currentEvent = event;
    cartList.add(currentEvent.cartItem);
    dummyData.remove(currentEvent.cartItem);
    emit(ProductBlocInitial(cartItem: dummyData));
  }

  FutureOr<void> incrementQuantityEvent(
      IncrementQuantityEvent event, Emitter<ProductState> emit) {
    final currentEvent = event;
    // cartList.contains(currentEvent.cartItem)
    cartList.any((item) {
      final isContain = currentEvent.cartItem.itemName == item.itemName;
      item.quantity += 1;
      emit(ProductBlocInitial(cartItem: dummyData));
      return isContain;
    });
  }

  FutureOr<void> decrementQuantityEvent(
      DecrementQuantityEvent event, Emitter<ProductState> emit) {}
}
