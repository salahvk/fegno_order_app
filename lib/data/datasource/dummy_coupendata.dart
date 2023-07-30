List<Map<String, dynamic>> coupons = [
  {
    'couponCode': 'COUPON1',
    'discountAmount': 40.0,
    'applicableAmount': 300.0,
  },
  {
    'couponCode': 'COUPON2',
    'discountAmount': 50.0,
    'applicableAmount': 350.0,
  },
  {
    'couponCode': 'COUPON3',
    'discountAmount': 75.0,
    'applicableAmount': 400.0,
  },
  {
    'couponCode': 'COUPON4',
    'discountAmount': 100.0,
    'applicableAmount': 500.0,
  },
  {
    'couponCode': 'COUPON5',
    'discountAmount': 150.0,
    'applicableAmount': 600.0,
  },
];

class DummyCoupenData {
  List<Map<String, dynamic>> getCoupenData() {
    return coupons;
  }
}
