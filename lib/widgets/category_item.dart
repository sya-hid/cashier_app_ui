import 'package:cashier_app_ui/const.dart';
import 'package:cashier_app_ui/model/category.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Categories category;
  final bool active;
  const CategoryItem({
    Key? key,
    required this.category,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.fromLTRB(10, 10, 35, 10),
      decoration: BoxDecoration(
        color: active ? lightBlue.withOpacity(0.3) : white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/${category.image}'),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(width: 10),
          Text(
            category.text!,
            style: roboto.copyWith(
                fontSize: 18, color: lightBlue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
