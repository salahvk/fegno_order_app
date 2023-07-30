import 'package:fegno_order_app/utilis/manager/assets_manager.dart';
import 'package:fegno_order_app/utilis/manager/color_manager.dart';
import 'package:fegno_order_app/utilis/manager/style_manager.dart';
import 'package:fegno_order_app/utilis/pdfApi.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

import 'package:screenshot/screenshot.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  final player = AudioPlayer();
  bool isProgress = true;
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;

  paySuccessSound() async {
    await player.setAsset(ImageAssets.gPay);
  }

  @override
  void initState() {
    super.initState();
    paySuccessSound();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isProgress = false;
      });
      player.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.green,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Screenshot(
                  controller: screenshotController,
                  child: Column(
                    children: [
                      isProgress
                          ? const SizedBox(
                              height: 280,
                              width: 280,
                              child: Center(
                                child: SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: CircularProgressIndicator(
                                      backgroundColor: ColorManager.primary,
                                      color: ColorManager.white,
                                      strokeWidth: 5,
                                    )),
                              ))
                          : SizedBox(
                              // height: 280,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  LottieBuilder.asset(
                                    ImageAssets.paymentSuccess,
                                    repeat: false,
                                  ),
                                  const Positioned(
                                      bottom: 20,
                                      // left: 2,
                                      child: Column(
                                        children: [
                                          // Text(
                                          //   "Transaction no : #123456789",
                                          //   style: getRegularStyle(
                                          //       color: ColorManager
                                          //           .paymentPageColor1,
                                          //       fontSize: 16),
                                          // ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                      Text(
                        'Your order has been \nPlaced successfully',
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                            color: ColorManager.chatGreen, fontSize: 16),
                      ),
                      // Text(
                      //   str.su_title_1,
                      //   textAlign: TextAlign.center,
                      //   style: getRegularStyle(
                      //       color: ColorManager.paymentPageColor1,
                      //       fontSize: 16),
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Text("Continue Shopping")),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  generatePdf() {
    setState(() {
      isLoading = true;
    });
    screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((capturedImage) async {
      final pdfFile = await PdfApi.generateCenteredText(
        capturedImage,
      );
      await PdfApi.openFile(pdfFile);
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
