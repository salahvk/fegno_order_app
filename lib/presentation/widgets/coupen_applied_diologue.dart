import 'package:flutter/material.dart';

class CoupenApplied extends StatelessWidget {
  const CoupenApplied({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
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
            Icon(Icons.card_giftcard, color: Colors.amber, size: 180.0),
            SizedBox(height: 10.0),
            Row(
              children: [
                SizedBox(width: 5.0),
                Text(
                  "Congratulation, you've saved \$9",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
