import 'package:hive/hive.dart';
import 'package:cashier_app_ui/model/category.dart';
part 'product.g.dart';

@HiveType(typeId: 2)
class Product extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? image;
  @HiveField(2)
  int? price;
  @HiveField(3)
  List<Categories>? category;
  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.category,
  });
}

List<Product> products = [
  Product(
      name: 'Apple',
      image: 'fruits/apple.png',
      price: 13,
      category: [categories[1], categories[2]]),
  Product(
      name: 'Avocado',
      image: 'fruits/avocado.png',
      price: 15,
      category: [categories[1], categories[3]]),
  Product(
      name: 'Banana',
      image: 'fruits/banana.png',
      price: 11,
      category: [categories[1], categories[2]]),
  Product(
      name: 'Beet',
      image: 'fruits/beet.png',
      price: 16,
      category: [categories[1], categories[2]]),
  Product(
      name: 'Blackberries',
      image: 'fruits/blackberries.png',
      price: 17,
      category: [categories[1], categories[3]]),
  Product(
      name: 'Chery',
      image: 'fruits/cherries.png',
      price: 14,
      category: [categories[1], categories[3]]),
  Product(
      name: 'Grape',
      image: 'fruits/grape.png',
      price: 13,
      category: [categories[1], categories[2]]),
  Product(
      name: 'Guava',
      image: 'fruits/guava.png',
      price: 17,
      category: [categories[1], categories[3]]),
  Product(
      name: 'Kiwi',
      image: 'fruits/kiwi.png',
      price: 13,
      category: [categories[1], categories[3]]),
  Product(
      name: 'Mango',
      image: 'fruits/mango.png',
      price: 8,
      category: [categories[1], categories[2]]),
  Product(
      name: 'Melon',
      image: 'fruits/melon.png',
      price: 10,
      category: [categories[1]]),
  Product(
      name: 'Orange',
      image: 'fruits/orange.png',
      price: 7,
      category: [categories[1], categories[2]]),
  Product(
      name: 'Pineapple',
      image: 'fruits/pineapple.png',
      price: 8,
      category: [categories[1], categories[2]]),
  Product(
      name: 'Asparagus',
      image: 'vegetables/asparagus.png',
      price: 8,
      category: [categories[0], categories[2], categories[3]]),
  Product(
      name: 'Broccoli',
      image: 'vegetables/broccoli.png',
      price: 9,
      category: [categories[0], categories[2]]),
  Product(
      name: 'Carrot',
      image: 'vegetables/carrot.png',
      price: 4,
      category: [categories[0], categories[2]]),
  Product(
      name: 'Celery',
      image: 'vegetables/celery.png',
      price: 7,
      category: [categories[0]]),
  Product(
      name: 'Corn',
      image: 'vegetables/corn.png',
      price: 11,
      category: [categories[0], categories[2]]),
  Product(
      name: 'Eggplant',
      image: 'vegetables/eggplant.png',
      price: 9,
      category: [categories[0], categories[2], categories[1]]),
  Product(
      name: 'Green Pea',
      image: 'vegetables/greenpeas.png',
      price: 8,
      category: [categories[0], categories[2], categories[3]]),
  Product(
      name: 'Lettuce',
      image: 'vegetables/lettuce.png',
      price: 17,
      category: [categories[0]]),
  Product(
      name: 'Potato',
      image: 'vegetables/potato.png',
      price: 7,
      category: [categories[0], categories[2]]),
  Product(
      name: 'Zucchini',
      image: 'vegetables/zucchini.png',
      price: 8,
      category: [categories[0], categories[2], categories[1]]),
];
