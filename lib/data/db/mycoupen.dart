import 'package:fegno_order_app/domain/entities/coupen_model.dart';

class MyCoupenList {
  static final MyCoupenList _instance = MyCoupenList._internal();
  final List<CouponModel> _myList = [];

  factory MyCoupenList() {
    return _instance;
  }

  MyCoupenList._internal();

  List<CouponModel> get myList => _myList;

  void addItemToList(CouponModel item) {
    _myList.add(item);
  }
}
