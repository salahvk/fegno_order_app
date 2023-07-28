class CouponModel {
  String couponModelCode;
  double discountAmount;
  double applicableAmount;

  CouponModel({
    required this.couponModelCode,
    required this.discountAmount,
    required this.applicableAmount,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      couponModelCode: json['couponModelCode'],
      discountAmount: json['discountAmount'].toDouble(),
      applicableAmount: json['applicableAmount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'couponModelCode': couponModelCode,
      'discountAmount': discountAmount,
      'applicableAmount': applicableAmount,
    };
  }
}
