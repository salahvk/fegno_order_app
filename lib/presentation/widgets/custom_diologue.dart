import 'package:fegno_order_app/data/datasource/dummy_coupendata.dart';
import 'package:fegno_order_app/domain/entities/coupen_model.dart';
import 'package:fegno_order_app/presentation/bloc/bloc/product_bloc.dart';
import 'package:fegno_order_app/presentation/widgets/coupen_applied_diologue.dart';
import 'package:fegno_order_app/utilis/grand_total.dart';
import 'package:fegno_order_app/utilis/manager/color_manager.dart';
import 'package:fegno_order_app/utilis/manager/style_manager.dart';
import 'package:flutter/material.dart';

class MainDialog extends StatefulWidget {
  final ProductBloc productBloc;
  const MainDialog({super.key, required this.productBloc});

  @override
  State<MainDialog> createState() => _MainDialogState();
}

class _MainDialogState extends State<MainDialog> {
  List<CouponModel>? dummyCoupenData;
  String? grandTotal;
  @override
  void initState() {
    super.initState();
    dummyCoupenData = DummyCoupenData()
        .getCoupenData()
        .map((e) => CouponModel(
            couponModelCode: e['couponCode'],
            discountAmount: e['discountAmount'],
            applicableAmount: e['applicableAmount']))
        .toList();
    grandTotal = calculateGrandTotal();
  }

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
                  children:
                      List.generate(dummyCoupenData?.length ?? 0, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CoupenApplied(
                                  coupenDiscount:
                                      dummyCoupenData![index].discountAmount,
                                );
                              },
                            );
                            await Future.delayed(const Duration(seconds: 3));
                            widget.productBloc
                                .add(CoupenRedeem(dummyCoupenData![index]));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: 80.0,
                            width: 80.0,
                            child: Column(
                              children: [
                                double.parse(grandTotal ?? '0') >=
                                        dummyCoupenData![index].applicableAmount
                                    ? const Icon(Icons.card_giftcard,
                                        size: 50.0)
                                    : const Icon(Icons.close, size: 50.0),
                                Text(
                                  dummyCoupenData?[index].couponModelCode ?? '',
                                  style: getRegularStyle(
                                      color: ColorManager.mainTextColor),
                                )
                              ],
                            ),
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
