import 'package:cashier_app_ui/const.dart';
import 'package:cashier_app_ui/model/menu.dart';
import 'package:flutter/material.dart';

class VertMenuItem extends StatelessWidget {
  final Menu menu;
  final bool active;
  const VertMenuItem({
    Key? key,
    required this.menu,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            color: active ? white : blue,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Icon(
              menu.icon,
              color: active ? blue : white,
            ),
            const SizedBox(width: 10),
            Text(
              menu.text,
              style: roboto.copyWith(
                  color: active ? blue : white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
