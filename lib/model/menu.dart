import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'menu.g.dart';

@HiveType(typeId: 1)
class Menu extends HiveObject {
  @HiveField(0)
  String text;
  @HiveField(1)
  IconData icon;

  Menu({required this.text, required this.icon});
}

List<Menu> menus = [
  Menu(text: 'Home', icon: Icons.home_filled),
  Menu(text: 'Transaction', icon: Icons.list_alt_outlined),
  Menu(text: 'Cashier', icon: Icons.group_rounded),
  Menu(text: 'Settings', icon: Icons.settings_rounded),
];
