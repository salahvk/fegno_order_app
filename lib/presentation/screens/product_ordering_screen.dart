import 'package:cached_network_image/cached_network_image.dart';
import 'package:fegno_order_app/presentation/widgets/custom_chatbubble.dart';
import 'package:fegno_order_app/utilis/color_manager.dart';
import 'package:fegno_order_app/utilis/style_manager.dart';
import 'package:flutter/material.dart';

class ProductOrderingPage extends StatelessWidget {
  const ProductOrderingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Ordering'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomChatBubble(isSendByServer: false, widget: [
            Row(
              children: [
                Text(
                  "Cart",
                  style: getSemiBoldStyle(
                      color: ColorManager.mainTextColor, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey, height: 2, thickness: 1),
            const SizedBox(height: 10),
            _buildGrandTotalRow(),
            const SizedBox(height: 20),
            _buildChangeInfoRow(),
            const SizedBox(height: 20),
            _buildCartItemRow(
              imageUrl:
                  'https://images.moneycontrol.com/static-mcnews/2022/04/fish.jpg?impolicy=website&width=1600&height=900',
              productName: 'Product 1',
              price: 10.99,
              unit: 'pieces',
              itemCount: 2,
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey, height: 2, thickness: 1),
            const SizedBox(height: 10),
            _buildAddMoreItemsRow(),
          ]),
          const CustomChatBubble(
              isSendByServer: true,
              widget: [Text("Add product Worth 15 to available coupen")])
        ],
      ),
    );
  }

  Widget _buildGrandTotalRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Grand Total',
            style: getRegularStyle(
                color: ColorManager.mainTextColor, fontSize: 16)),
        Text('\$21.98', // Replace this with the actual calculated grand total
            style: getSemiBoldStyle(
                color: ColorManager.mainTextColor, fontSize: 16)),
      ],
    );
  }

  Widget _buildChangeInfoRow() {
    return Text(
      'There might be a change in the final bill which will be generated from the shop',
      style: getRegularStyle(
        color: ColorManager.textColor,
      ),
    );
  }

  Widget _buildCartItemRow({
    required String imageUrl,
    required String productName,
    required double price,
    required String unit,
    required int itemCount,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: 50,
            width: 50,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                '\$$price per $unit',
                style: getRegularStyle(color: ColorManager.green, fontSize: 14),
              ),
            ],
          ),
        ),
        _buildQuantityControl(itemCount),
      ],
    );
  }

  Widget _buildQuantityControl(int itemCount) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            // Handle decrement button press
          },
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: 5),
        Text(
          itemCount.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () {
            // Handle increment button press
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildAddMoreItemsRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Add more items',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5),
        Icon(Icons.add, color: Colors.blue),
      ],
    );
  }
}
