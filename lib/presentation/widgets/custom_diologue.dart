import 'package:fegno_order_app/presentation/widgets/coupen_applied_diologue.dart';
import 'package:flutter/material.dart';

class MainDialog extends StatelessWidget {
  const MainDialog({super.key});

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
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.pie_chart, color: Colors.white),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Apply coupon and get discount'),
                    Text('5 unused coupons'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            SizedBox(
                height: 200.0,
                child: GridView.count(
                  crossAxisCount: 3, // Set to 3 for maximum 3 items in a row
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CoupenApplied();
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: 80.0,
                            width: 80.0,
                            child: const Icon(Icons.card_giftcard, size: 50.0),
                          ),
                        ),
                      ),
                    );
                  }),
                )),
            const Divider(),
            const Text('Note: Lorem ipsum dolor sit amet'),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ContinueDialog();
                  },
                );
              },
              child: const Text('Continue without applying'),
            ),
          ],
        ),
      ),
    );
  }
}

class ContinueDialog extends StatelessWidget {
  const ContinueDialog({super.key});

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
            const Text('Continue without applying the coupon?'),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Perform the action when "Continue" is pressed
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
