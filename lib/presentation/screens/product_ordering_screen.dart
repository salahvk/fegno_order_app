import 'package:cached_network_image/cached_network_image.dart';
import 'package:fegno_order_app/data/db/mycart.dart';
import 'package:fegno_order_app/domain/entities/cart_item.dart';
import 'package:fegno_order_app/presentation/bloc/bloc/product_bloc.dart';
import 'package:fegno_order_app/presentation/widgets/custom_chatbubble.dart';
import 'package:fegno_order_app/presentation/widgets/custom_diologue.dart';
import 'package:fegno_order_app/utilis/grand_total.dart';
import 'package:fegno_order_app/utilis/manager/color_manager.dart';
import 'package:fegno_order_app/utilis/manager/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProductOrderingPage extends StatefulWidget {
  const ProductOrderingPage({super.key});

  @override
  State<ProductOrderingPage> createState() => _ProductOrderingPageState();
}

class _ProductOrderingPageState extends State<ProductOrderingPage> {
  bool isItemAdding = false;
  final ProductBloc productBloc = ProductBloc();
  var cartList = GetIt.I<MyCartList>().myList;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<ProductBloc, ProductState>(
      bloc: productBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProductBlocInitial) {
          final grandTotal = calculateGrandTotal();
          final coupenLimit = (300 - double.parse(grandTotal));
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Grand Total',
                          style: getRegularStyle(
                              color: ColorManager.mainTextColor, fontSize: 16)),
                      Text(
                          '\$$grandTotal', // Replace this with the actual calculated grand total
                          style: getSemiBoldStyle(
                              color: ColorManager.mainTextColor, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildChangeInfoRow(),
                  const SizedBox(height: 20),
                  cartList.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildCartItemRow(
                              cartItem: cartList[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemCount: cartList.length,
                        )
                      : Container(),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey, height: 2, thickness: 1),
                  const SizedBox(height: 10),
                  _buildAddMoreItemsRow(),
                ]),
                isItemAdding
                    ? CustomChatBubble(isSendByServer: true, widget: [
                        ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: state.cartItem?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                productBloc
                                    .add(AddItemEvent(state.cartItem![index]));
                                isItemAdding = false;
                              },
                              child: Text(
                                state.cartItem?[index].itemName ?? '',
                                textAlign: TextAlign.center,
                                style: getRegularStyle(
                                    color: ColorManager.mainTextColor,
                                    fontSize: 14),
                              ),
                            );
                          },
                        )
                      ])
                    : Container(),
                coupenLimit > 0
                    ? CustomChatBubble(isSendByServer: true, widget: [
                        RichText(
                          text: TextSpan(
                            style: getRegularStyle(
                                color: ColorManager.mainTextColor,
                                fontSize: 14),
                            children: [
                              const TextSpan(text: 'Add product Worth  '),
                              TextSpan(
                                text: coupenLimit.toString(),
                                style: getBoldStyle(
                                    color: ColorManager.mainTextColor,
                                    fontSize: 16),
                              ),
                              const TextSpan(text: '  to available coupon'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: size.width,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Procceed"),
                            ),
                          ),
                        ),
                      ])
                    : CustomChatBubble(isSendByServer: true, widget: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MainDialog();
                              },
                            );
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: ColorManager.secondary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(Icons.view_carousel_sharp),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        ' 5 Unused coupens',
                                        style: getBoldStyle(
                                            color: ColorManager.mainTextColor,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Apply one and get discount',
                                        style: getRegularStyle(
                                            color: ColorManager.mainTextColor,
                                            fontSize: 12),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: size.width,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Continue Without applying"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.chatGreen),
                              onPressed: () {},
                              child: const Text("Apply Coupen")),
                        )
                      ])
              ],
            ),
          );
        }
        return Container();
      },
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
    required CartItemModel cartItem,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: cartItem.imageUrl,
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
                cartItem.itemName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                '\$${cartItem.price} per ${cartItem.quantityUnit}',
                style: getRegularStyle(color: ColorManager.green, fontSize: 14),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                productBloc.add(DecrementQuantityEvent(cartItem));
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(width: 5),
            Text(
              cartItem.quantity.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: () {
                productBloc.add(IncrementQuantityEvent(cartItem));
              },
              icon: const Icon(Icons.add),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildAddMoreItemsRow() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: ColorManager.green.withOpacity(.2),
        onTap: () => setState(() {
          isItemAdding = true;
        }),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add items',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
            Icon(Icons.add, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
