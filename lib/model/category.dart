import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 3)
class Categories extends HiveObject {
  @HiveField(0)
  String? text;
  @HiveField(1)
  String? image;

  Categories({required this.text, required this.image});
}

List<Categories> categories = [
  Categories(text: 'Vegetable', image: 'vegetables.png'),
  Categories(text: 'Fresh Fruit', image: 'fruits.png'),
  Categories(text: 'Carbohydrate', image: 'carbohydrate.jpg'),
  Categories(text: 'Protein', image: 'protein.jpg'),
];
