import 'package:fegno_order_app/utilis/manager/color_manager.dart';
import 'package:flutter/material.dart';

class CustomChatBubble extends StatelessWidget {
  final bool isSendByServer;
  final List<Widget> widget;
  const CustomChatBubble(
      {super.key, required this.isSendByServer, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: isSendByServer ? 0 : 25,
          right: isSendByServer ? 25 : 0,
          bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: isSendByServer ? ColorManager.white : ColorManager.chatGreen,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.grey.shade300,
              offset: const Offset(5, 8.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: widget,
          ),
        ),
      ),
    );
  }
}
