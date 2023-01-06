import 'dart:async';

import 'package:cashier_app_ui/const.dart';
import 'package:cashier_app_ui/model/cart.dart';
import 'package:cashier_app_ui/model/category.dart';
import 'package:cashier_app_ui/model/my_data.dart';
import 'package:cashier_app_ui/model/product.dart';
import 'package:cashier_app_ui/size_config.dart';
import 'package:cashier_app_ui/widgets/cart_item.dart';
import 'package:cashier_app_ui/widgets/category_item.dart';
import 'package:cashier_app_ui/widgets/fade_in_animation.dart';
import 'package:cashier_app_ui/widgets/my_animation.dart';
import 'package:cashier_app_ui/widgets/product_item.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final MyData data;
  const HomePage({super.key, required this.data});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  PageController controller = PageController();

  int currentProductPage = 0;
  int currentCategory = 0;
  bool moreCategory = false;
  AnimatedContainer indicator({int? index}) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 500),
      height: 5,
      width: currentProductPage == index ? 30 : 5,
      decoration: BoxDecoration(
          color: currentProductPage == index ? blue : white,
          borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  initState() {
    super.initState();
    dateTimer();
  }

  @override
  dispose() {
    dateTimer();
    super.dispose();
  }

  dateTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          now = DateTime.now();
        });
      }
    });
  }

  List<Product> myProduct = products;
  addCart(Product product) {
    setState(() {
      if (widget.data.carts
              .indexWhere((element) => element.product == product) ==
          -1) {
        widget.data.carts.add(Cart(product: product, quantity: 1));
      } else {
        int qty;
        int index = widget.data.carts
            .indexWhere((element) => element.product == product);
        qty = widget.data.carts[index].quantity! + 1;
        removeCart(index);
        widget.data.carts.add(Cart(product: product, quantity: qty));
      }
      widget.data.updateData();
    });
  }

  void addQty(int index) {
    setState(() {
      widget.data.carts[index].quantity =
          widget.data.carts[index].quantity! + 1;
      widget.data.updateData();
    });
  }

  void reduceQty(int index) {
    setState(() {
      if (widget.data.carts[index].quantity! > 1) {
        widget.data.carts[index].quantity =
            widget.data.carts[index].quantity! - 1;
      } else {
        removeCart(index);
      }
      widget.data.updateData();
    });
  }

  void removeCart(int index) {
    setState(() {
      widget.data.carts.removeAt(index);
      widget.data.updateData();
    });
  }

  void removeAll() {
    setState(() {
      widget.data.carts.clear();
      widget.data.updateData();
    });
  }

  getTotal() {
    int total = 0;
    for (var element in widget.data.carts) {
      total += element.product!.price! * element.quantity!;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        //product
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          height: double.infinity,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                    style: roboto.copyWith(
                        fontSize: 24,
                        color: black,
                        fontWeight: FontWeight.bold),
                    children: [
                      const TextSpan(text: 'Order No. #'),
                      TextSpan(text: '5'.padLeft(3, '0'))
                    ])),
                Text(SizeConfig.screenWidth.toString()),
                Text(SizeConfig.screenHeight.toString()),
                Text(
                  DateFormat('EEE, d MMM y, hh:mm aa').format(now),
                  style: roboto.copyWith(
                      fontSize: 18, color: grey, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: white),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter item code',
                    hintStyle: roboto.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold, color: grey),
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ...List.generate((myProduct.length / 8).ceil(),
                        (index) => indicator(index: index))
                  ],
                ),
                Text(
                    '${(currentProductPage + 1) * 8 > myProduct.length ? myProduct.length : (currentProductPage + 1) * 8} of ${myProduct.length}',
                    style: roboto.copyWith(
                        fontSize: 16, color: grey, fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() => currentProductPage = value);
                  },
                  children: [
                    ...List.generate(
                        (myProduct.length / 8).ceil(),
                        (index) => Wrap(
                              runSpacing: 15,
                              spacing: 15,
                              children: [
                                ...List.generate(
                                    index == (myProduct.length / 8).ceil() - 1
                                        ? myProduct.length % 8
                                        : 8, (index_) {
                                  var newIndex =
                                      (currentProductPage * 8) + index_;
                                  newIndex = newIndex > myProduct.length - 1
                                      ? myProduct.length - 1
                                      : newIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      addCart(myProduct[newIndex]);
                                    },
                                    child: SizedBox(
                                      height: 230,
                                      width: 180,
                                      child: Stack(
                                        children: [
                                          FadeInAnimation(
                                            durationInMs: (index_ + 1) * 250,
                                            animatePosition: MyAnimation(
                                                topAfter: 0, topBefore: 230),
                                            child: ProductItem(
                                              product: myProduct[newIndex],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              ],
                            )),
                  ]),
            ),
            const SizedBox(height: 20),
            Container(
              width: SizeConfig.screenWidth! * 0.6,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth! * 0.6 - 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                              moreCategory ? categories.length : 3,
                              (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentCategory = index;
                                        myProduct = products
                                            .where((element) => element
                                                .category!
                                                .contains(categories[index]))
                                            .toList();
                                        if (controller.hasClients) {
                                          controller.animateToPage(0,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        }
                                      });
                                    },
                                    child: CategoryItem(
                                      category: categories[index],
                                      active: currentCategory == index
                                          ? true
                                          : false,
                                    ),
                                  ))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        moreCategory = !moreCategory;
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: lightBlue.withOpacity(0.5),
                                offset: const Offset(0, 10),
                                spreadRadius: 0,
                                blurRadius: 5)
                          ]),
                      child: Icon(
                        moreCategory ? Icons.close : Icons.more_horiz,
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),

        const SizedBox(width: 20),
        //cart
        Container(
          padding: const EdgeInsets.only(top: 20),
          width: SizeConfig.screenWidth! * 0.3 - 66,
          height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cart',
                      style: roboto.copyWith(
                          fontSize: 28,
                          color: black,
                          fontWeight: FontWeight.bold),
                    ),
                    widget.data.carts.isNotEmpty
                        ? GestureDetector(
                            onTap: () => removeAll(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              const SizedBox(height: 20),
              widget.data.carts.isNotEmpty
                  ? Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                verticalDirection: VerticalDirection.up,
                                children: [
                                  ...List.generate(widget.data.carts.length,
                                      (index) {
                                    var cart = widget.data.carts[index];
                                    return Dismissible(
                                      key: Key(cart.product!.name!),
                                      onDismissed: (direction) =>
                                          removeCart(index),
                                      child: CartItem(
                                        onAdd: () => addQty(index),
                                        onReduce: () => reduceQty(index),
                                        cart: cart,
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sub Total',
                                      style: roboto.copyWith(
                                          fontSize: 18,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '\$${getTotal()}',
                                      style: roboto.copyWith(
                                          fontSize: 24,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tax',
                                      style: roboto.copyWith(
                                          fontSize: 18,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '\$${(getTotal() * 0.1).toStringAsFixed(2)}',
                                      style: roboto.copyWith(
                                          fontSize: 24,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      color: bgColor,
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: Offset(0, -10))
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: roboto.copyWith(
                                          fontSize: 20,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '\$${(getTotal() * 1.1).toStringAsFixed(2)}',
                                      style: roboto.copyWith(
                                          fontSize: 28,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      color: blue,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: lightBlue.withOpacity(0.3),
                                            offset: const Offset(0, 10),
                                            spreadRadius: 0,
                                            blurRadius: 10)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      'CHECKOUT',
                                      style: roboto.copyWith(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: bgColor,
                                            offset: Offset(0, 10),
                                            spreadRadius: 0,
                                            blurRadius: 10)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      'PENDING',
                                      style: roboto.copyWith(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: Center(
                      child: Text(
                        'Empty',
                        style: roboto.copyWith(
                            fontSize: 32,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
            ],
          ),
        ),
      ],
    );
  }
}
