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
      description: 'Свежие сезонные фрукты',
      imagePath: 'assets/images/fruits.jpg',
      icon: Icons.shopping_bag_outlined,
    ),
    CategoryModel(
      id: 'vegetables',
      name: 'Овощи',
      description: 'Фермерские овощи и зелень',
      imagePath: 'assets/images/vegetables.jpg',
      icon: Icons.eco_outlined,
    ),
    CategoryModel(
      id: 'meat',
      name: 'Мясо',
      description: 'Говядина, курица и другое мясо',
      imagePath: 'assets/images/meet.jpg',
      icon: Icons.set_meal_outlined,
    ),
    CategoryModel(
      id: 'sausage',
      name: 'Колбасы',
      description: 'Колбасные изделия и деликатесы',
      imagePath: 'assets/images/sausage.jpg',
      icon: Icons.lunch_dining_outlined,
    ),
    CategoryModel(
      id: 'grains',
      name: 'Мука и крупы',
      description: 'Мука, крупы и макароны',
      imagePath: 'assets/images/flour cereals.jpg',
      icon: Icons.bakery_dining_outlined,
    ),
    CategoryModel(
      id: 'hygiene',
      name: 'Гигиена и уборка',
      description: 'Средства для дома и ухода',
      imagePath: 'assets/images/Hygiene and cleaning products.jpg',
      icon: Icons.cleaning_services_outlined,
    ),
    CategoryModel(
      id: 'drinks',
      name: 'Напитки',
      description: 'Соки, вода и напитки',
      imagePath: 'assets/images/drinks.jpg',
      icon: Icons.local_drink_outlined,
    ),
    CategoryModel(
      id: 'snacks',
      name: 'Снеки',
      description: 'Чипсы, орехи и сладости',
      imagePath: 'assets/images/snaks.jpg',
      icon: Icons.fastfood_outlined,
    ),
  ];
}
