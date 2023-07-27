import 'package:fegno_order_app/data/db/mycart.dart';
import 'package:get_it/get_it.dart';

String calculateGrandTotal() {
  var cartList = GetIt.I<MyCartList>().myList;
  double grandTotal = 0;
  for (var cartItem in cartList) {
    grandTotal += (cartItem.price) * (cartItem.quantity);
  }
  return grandTotal.toString();
}
