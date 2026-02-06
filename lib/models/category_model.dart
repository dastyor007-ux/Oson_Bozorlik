import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final IconData icon;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.icon,
  });

  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'fruits',
      name: 'Фрукты',
      description: 'Свежие сезонные фрукты и ягоды',
      imagePath: 'assets/images/fruits.png',
      icon: Icons.shopping_bag_outlined,
    ),
    CategoryModel(
      id: 'vegetables',
      name: 'Овощи',
      description: 'Фермерские овощи и зелень',
      imagePath: 'assets/images/vegetables.png',
      icon: Icons.eco_outlined,
    ),
    CategoryModel(
      id: 'dairy',
      name: 'Масло, яйца, молоко',
      description: 'Натуральные молочные продукты',
      imagePath: 'assets/images/dairy.png',
      icon: Icons.egg_outlined,
    ),
    CategoryModel(
      id: 'grains',
      name: 'Мука и зерновые',
      description: 'Крупы, макароны и мука',
      imagePath: 'assets/images/grains.png',
      icon: Icons.bakery_dining_outlined,
    ),
    CategoryModel(
      id: 'tea_coffee',
      name: 'Чаи и кофе',
      description: 'Бодрящие напитки на любой вкус',
      imagePath: 'assets/images/tea_coffee.png',
      icon: Icons.coffee_outlined,
    ),
    CategoryModel(
      id: 'hygiene',
      name: 'Средства гигиены',
      description: 'Уход за собой и домом',
      imagePath: 'assets/images/hygiene.png',
      icon: Icons.cleaning_services_outlined,
    ),
    CategoryModel(
      id: 'drinks',
      name: 'Напитки',
      description: 'Соки, воды и лимонады',
      imagePath: 'assets/images/drinks.png',
      icon: Icons.local_drink_outlined,
    ),
  ];
}
