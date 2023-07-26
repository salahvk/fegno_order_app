import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fegno_order_app/data/datasource/dummy_cartdata.dart';
import 'package:fegno_order_app/domain/entities/cart_item.dart';
import 'package:meta/meta.dart';

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

class ProductBlocBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  ProductBlocBloc() : super(ProductBlocInitial()) {
    on<InitialProductFetchEvent>(initialProductFetchEvent);
  }

  FutureOr<void> initialProductFetchEvent(
      InitialProductFetchEvent event, Emitter<ProductBlocState> emit) {
    emit(ProductBlocLoaded(DummyDataSource()
        .getCartItems()
        .map((e) => CartItem(
            itemName: e['itemName'],
            price: e['price'],
            quantity: e['quantity'],
            quantityUnit: e['quantityUnit'],
            imageUrl: e['imageUrl']))
        .toList()));
  }
}
