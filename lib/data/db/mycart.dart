import 'package:fegno_order_app/domain/entities/cart_item.dart';

class MyCartList {
  static final MyCartList _instance = MyCartList._internal();
  final List<CartItemModel> _myList = [];

  factory MyCartList() {
    return _instance;
  }

  MyCartList._internal();

  List<CartItemModel> get myList => _myList;

  void addItemToList(CartItemModel item) {
    _myList.add(item);
  }
}
