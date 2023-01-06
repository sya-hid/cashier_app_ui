import 'package:cashier_app_ui/const.dart';
import 'package:cashier_app_ui/model/menu.dart';
import 'package:cashier_app_ui/model/my_data.dart';
import 'package:cashier_app_ui/pages/home_page.dart';
import 'package:cashier_app_ui/size_config.dart';
import 'package:cashier_app_ui/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _myBox = Hive.box('cashier_app');
  MyData data = MyData();
  @override
  void initState() {
    super.initState();
    if (_myBox.get('carts') == null) {
      data.initData();
    } else {
      data.loadData();
    }
  }

  @override
  void dispose() {
    Hive.box('carts').close();
    super.dispose();
  }

  int currentMenu = 0;
  Widget body() {
    switch (currentMenu) {
      case 0:
        return HomePage(data: data);
      case 1:
        return Center(
            child: Text('Transaction', style: roboto.copyWith(fontSize: 32)));
      case 2:
        return Center(
            child: Text('Cashier', style: roboto.copyWith(fontSize: 32)));
      case 3:
        return Center(
            child: Text('Settings', style: roboto.copyWith(fontSize: 32)));
      default:
        return HomePage(data: data);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: darkBlue,
      body: Row(
        children: [
          //menu
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(30)),
                color: blue),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(
                    menus.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              currentMenu = index;
                            });
                          },
                          child: VertMenuItem(
                            menu: menus[index],
                            active: currentMenu == index ? true : false,
                          ),
                        ))
              ],
            ),
          ),
          const SizedBox(width: 20),
          //body
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
            width: SizeConfig.screenWidth! * 0.9 - 6,
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: bgColor),
            child: body(),
          )
        ],
      ),
    );
  }
}
