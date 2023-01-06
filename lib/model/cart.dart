import 'package:cashier_app_ui/model/product.dart';
import 'package:hive/hive.dart';
part 'cart.g.dart';

@HiveType(typeId: 4)
class Cart extends HiveObject {
  @HiveField(0)
  Product? product;
  @HiveField(1)
  int? quantity;

  Cart({required this.product, required this.quantity});
}
