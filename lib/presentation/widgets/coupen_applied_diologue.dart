import 'package:fegno_order_app/utilis/manager/color_manager.dart';
import 'package:fegno_order_app/utilis/manager/style_manager.dart';
import 'package:flutter/material.dart';

class CoupenApplied extends StatelessWidget {
  final double coupenDiscount;
  const CoupenApplied({super.key, required this.coupenDiscount});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'COUPON APPLIED!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Icon(Icons.card_giftcard, color: Colors.amber, size: 180.0),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 5.0),
                Text(
                  "Congratulation, you've saved",
                  style: getRegularStyle(
                      color: ColorManager.mainTextColor, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              "\$$coupenDiscount",
              style: getSemiBoldStyle(color: ColorManager.green, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
