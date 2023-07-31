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
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductOrderingPage extends StatefulWidget {
  const ProductOrderingPage({super.key});

  @override
  State<ProductOrderingPage> createState() => _ProductOrderingPageState();
}

class _ProductOrderingPageState extends State<ProductOrderingPage> {
  bool isItemAdding = false;
  bool isProceed = false;
  final ProductBloc productBloc = ProductBloc();
  var cartList = GetIt.I<MyCartList>().myList;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<ProductBloc, ProductState>(
      bloc: productBloc,
      listener: (context, state) {
        if (state is ProductBlocInitial && state.couponModel != null) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      builder: (context, state) {
        if (state is ProductBlocInitial) {
          final grandTotal = calculateGrandTotal();
          final coupenLimit = (300 - double.parse(grandTotal));
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Product Ordering',
                style: getSemiBoldStyle(
                    color: ColorManager.mainTextColor, fontSize: 20),
              ),
            ),
            body: ListView(
              reverse: true,
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
                      ])
                    : CustomChatBubble(isSendByServer: true, widget: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MainDialog(
                                  productBloc: productBloc,
                                );
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
                                        'Place Orderd get discount',
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
                              child: const Text("Place Order")),
                        )
                      ]),
                state.couponModel != null
                    ? CustomChatBubble(isSendByServer: false, widget: [
                        SizedBox(
                            child: LottieBuilder.asset(
                          'assets/i_won.json',
                          height: size.height * .2,
                          width: size.width * .2,
                        )),
                        Text(
                          "I Won \$${state.couponModel?.discountAmount}",
                          style: getRegularStyle(
                              color: ColorManager.mainTextColor),
                        )
                      ])
                    : Container(),
                state.couponModel != null || isProceed
                    ? CustomChatBubble(isSendByServer: true, widget: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MainDialog(
                                  productBloc: productBloc,
                                );
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
                                  Text(
                                    'Select delivery method',
                                    style: getBoldStyle(
                                        color: ColorManager.mainTextColor,
                                        fontSize: 16),
                                  ),
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
                              onPressed: () {
                                productBloc.add(DeliveryMethodSelection(true));
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.home),
                                  SizedBox(width: 5),
                                  Text("Home delivery"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                productBloc.add(DeliveryMethodSelection(false));
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bike_scooter),
                                  SizedBox(width: 5),
                                  Text("Take away"),
                                ],
                              )),
                        )
                      ])
                    : Container(),
                state.isHome == null
                    ? Container()
                    : state.isHome ?? true
                        ? CustomChatBubble(isSendByServer: false, widget: [
                            Text(
                              'I Prefer Home delivery',
                              style: getRegularStyle(
                                  color: ColorManager.mainTextColor,
                                  fontSize: 14),
                            ),
                          ])
                        : CustomChatBubble(isSendByServer: false, widget: [
                            Text(
                              'I Prefer Take away',
                              style: getRegularStyle(
                                  color: ColorManager.mainTextColor,
                                  fontSize: 14),
                            ),
                          ]),
                state.isHome != null
                    ? CustomChatBubble(isSendByServer: true, widget: [
                        Text(
                          'Please Select a time slot to collect the prodcuts from our store',
                          style: getRegularStyle(
                              color: ColorManager.mainTextColor, fontSize: 14),
                        ),
                        state.selectedTimeSlot == null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Wrap(
                                  alignment: WrapAlignment.spaceAround,
                                  children: List.generate(
                                      state.timeSlot?.length ?? 0,
                                      (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  productBloc.add(
                                                      TimeSlotSelected(state
                                                          .timeSlot![index]));
                                                },
                                                child: Text(state
                                                        .timeSlot?[index]
                                                        .timeslot ??
                                                    '')),
                                          )),
                                ),
                              )
                            : Container(),
                      ])
                    : Container(),
                state.selectedTimeSlot != null
                    ? CustomChatBubble(isSendByServer: false, widget: [
                        Text(
                          state.selectedTimeSlot?.timeslot ?? '',
                          style: getRegularStyle(
                              color: ColorManager.mainTextColor, fontSize: 14),
                        ),
                      ])
                    : Container(),
                state.selectedTimeSlot != null
                    ? CustomChatBubble(isSendByServer: true, widget: [
                        Row(
                          children: [
                            Text(
                              'Bill Details',
                              style: getBoldStyle(
                                  color: ColorManager.mainTextColor,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Item Total',
                                style: getSemiBoldStyle(
                                    color: ColorManager.mainTextColor,
                                    fontSize: 14),
                              ),
                              Text(
                                '\$$grandTotal',
                                style: getSemiBoldStyle(
                                    color: ColorManager.mainTextColor,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Coupen discount',
                              style: getRegularStyle(
                                  color: ColorManager.mainTextColor,
                                  fontSize: 14),
                            ),
                            state.couponModel != null
                                ? Text(
                                    '\$${state.couponModel?.discountAmount}',
                                    style: getSemiBoldStyle(
                                        color: ColorManager.green,
                                        fontSize: 14),
                                  )
                                : Text(
                                    '\$0.00',
                                    style: getSemiBoldStyle(
                                        color: ColorManager.green,
                                        fontSize: 14),
                                  ),
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Grand total',
                                style: getBoldStyle(
                                    color: ColorManager.mainTextColor,
                                    fontSize: 16),
                              ),
                              Text(
                                '\$${double.parse(grandTotal) + (state.couponModel?.discountAmount ?? 0)}',
                                style: getBoldStyle(
                                    color: ColorManager.green, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: _buildChangeInfoRow(),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add Instructions',
                                style: getSemiBoldStyle(
                                    color: ColorManager.mainTextColor,
                                    fontSize: 14),
                              ),
                              const SizedBox(width: 5),
                              Icon(Icons.add,
                                  color: ColorManager.mainTextColor),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: size.width,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Cancel"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.chatGreen),
                              onPressed: () {},
                              child: const Text("Place Order")),
                        ),
                      ])
                    : Container(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 25),
                  child: !isProceed
                      ? SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.chatGreen),
                            onPressed: () {
                              if (double.parse(grandTotal) < 1) {
                                showTopSnackBar(
                                    Overlay.of(context),
                                    const SizedBox(
                                      height: 50,
                                      child: CustomSnackBar.error(
                                        icon: Icon(Icons.people),
                                        iconPositionLeft: 20,
                                        iconPositionTop: -25,
                                        message: "Add a product",
                                      ),
                                    ));
                              } else {
                                setState(() {
                                  isProceed = true;
                                });
                              }
                            },
                            child: const Text("Proceed"),
                          ),
                        )
                      : Container(),
                ),
              ].reversed.toList(),
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
