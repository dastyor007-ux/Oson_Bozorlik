class ProductModel {
  final String id;
  final String categoryId;
  final String subCategoryId;
  final String name;
  final double price; // Price per unit (e.g., per 1 kg)
  final String imagePath;
  final bool isAvailable;
  final String unit; // 'кг', 'шт', etc.

  const ProductModel({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.name,
    required this.price,
    required this.imagePath,
    this.isAvailable = true,
    this.unit = 'кг',
  });

  static const List<ProductModel> mockProducts = [
    // Фрукты — Местные
    ProductModel(
      id: '1',
      categoryId: 'fruits',
      subCategoryId: 'local',
      name: 'Яблоко золотое местное',
      price: 12000,
      imagePath: 'assets/images/apple_gold.png',
    ),
    ProductModel(
      id: '2',
      categoryId: 'fruits',
      subCategoryId: 'local',
      name: 'Груша Дюшес',
      price: 15000,
      imagePath: 'assets/images/pear.png',
    ),
    ProductModel(
      id: '3',
      categoryId: 'fruits',
      subCategoryId: 'local',
      name: 'Виноград кишмиш',
      price: 22000,
      imagePath: 'assets/images/grape.png',
    ),
    // Фрукты — Цитрусовые
    ProductModel(
      id: '4',
      categoryId: 'fruits',
      subCategoryId: 'citrus',
      name: 'Апельсин импортный',
      price: 25000,
      imagePath: 'assets/images/orange.png',
    ),
    ProductModel(
      id: '5',
      categoryId: 'fruits',
      subCategoryId: 'citrus',
      name: 'Лимон Ташкент',
      price: 18000,
      imagePath: 'assets/images/lemon.png',
    ),
    ProductModel(
      id: '6',
      categoryId: 'fruits',
      subCategoryId: 'citrus',
      name: 'Мандарин Марокко',
      price: 28000,
      imagePath: 'assets/images/mandarin.png',
    ),
    // Фрукты — Тропические
    ProductModel(
      id: '7',
      categoryId: 'fruits',
      subCategoryId: 'tropical',
      name: 'Банан Эквадор',
      price: 18000,
      imagePath: 'assets/images/banana.png',
      isAvailable: false,
    ),
    ProductModel(
      id: '8',
      categoryId: 'fruits',
      subCategoryId: 'tropical',
      name: 'Манго Индия',
      price: 45000,
      imagePath: 'assets/images/mango.png',
    ),
    ProductModel(
      id: '9',
      categoryId: 'fruits',
      subCategoryId: 'tropical',
      name: 'Ананас',
      price: 38000,
      imagePath: 'assets/images/pineapple.png',
    ),

    // Овощи — Корнеплоды
    ProductModel(
      id: '10',
      categoryId: 'vegetables',
      subCategoryId: 'root',
      name: 'Картофель местный',
      price: 5000,
      imagePath: 'assets/images/potato.png',
    ),
    ProductModel(
      id: '11',
      categoryId: 'vegetables',
      subCategoryId: 'root',
      name: 'Морковь свежая',
      price: 6000,
      imagePath: 'assets/images/carrot.png',
    ),
    ProductModel(
      id: '12',
      categoryId: 'vegetables',
      subCategoryId: 'root',
      name: 'Свёкла',
      price: 4500,
      imagePath: 'assets/images/beet.png',
    ),
    // Овощи — Зелень
    ProductModel(
      id: '13',
      categoryId: 'vegetables',
      subCategoryId: 'greens',
      name: 'Укроп пучок',
      price: 3000,
      imagePath: 'assets/images/dill.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '14',
      categoryId: 'vegetables',
      subCategoryId: 'greens',
      name: 'Петрушка пучок',
      price: 3000,
      imagePath: 'assets/images/parsley.png',
      unit: 'шт',
    ),
    // Овощи — Томаты и огурцы
    ProductModel(
      id: '15',
      categoryId: 'vegetables',
      subCategoryId: 'tomatoes_cucumbers',
      name: 'Помидоры розовые',
      price: 14000,
      imagePath: 'assets/images/tomato.png',
    ),
    ProductModel(
      id: '16',
      categoryId: 'vegetables',
      subCategoryId: 'tomatoes_cucumbers',
      name: 'Огурцы свежие',
      price: 10000,
      imagePath: 'assets/images/cucumber.png',
    ),

    // Масло, яйца, молоко
    ProductModel(
      id: '17',
      categoryId: 'dairy',
      subCategoryId: 'milk',
      name: 'Молоко 3.2%',
      price: 12000,
      imagePath: 'assets/images/milk.png',
      unit: 'л',
    ),
    ProductModel(
      id: '18',
      categoryId: 'dairy',
      subCategoryId: 'milk',
      name: 'Кефир 1%',
      price: 11000,
      imagePath: 'assets/images/kefir.png',
      unit: 'л',
    ),
    ProductModel(
      id: '19',
      categoryId: 'dairy',
      subCategoryId: 'eggs',
      name: 'Яйца куриные 10 шт',
      price: 16000,
      imagePath: 'assets/images/eggs.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '20',
      categoryId: 'dairy',
      subCategoryId: 'butter_oil',
      name: 'Масло сливочное 200г',
      price: 18000,
      imagePath: 'assets/images/butter.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '21',
      categoryId: 'dairy',
      subCategoryId: 'butter_oil',
      name: 'Масло подсолнечное 1л',
      price: 22000,
      imagePath: 'assets/images/oil.png',
      unit: 'шт',
    ),

    // Мука и зерновые
    ProductModel(
      id: '22',
      categoryId: 'grains',
      subCategoryId: 'flour',
      name: 'Мука пшеничная 1кг',
      price: 8000,
      imagePath: 'assets/images/flour.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '23',
      categoryId: 'grains',
      subCategoryId: 'cereals',
      name: 'Рис длиннозёрный',
      price: 15000,
      imagePath: 'assets/images/rice.png',
    ),
    ProductModel(
      id: '24',
      categoryId: 'grains',
      subCategoryId: 'cereals',
      name: 'Гречка 1кг',
      price: 14000,
      imagePath: 'assets/images/buckwheat.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '25',
      categoryId: 'grains',
      subCategoryId: 'pasta',
      name: 'Макароны спагетти',
      price: 9000,
      imagePath: 'assets/images/pasta.png',
      unit: 'шт',
    ),

    // Чаи и кофе
    ProductModel(
      id: '26',
      categoryId: 'tea_coffee',
      subCategoryId: 'tea',
      name: 'Чай зелёный 100г',
      price: 12000,
      imagePath: 'assets/images/green_tea.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '27',
      categoryId: 'tea_coffee',
      subCategoryId: 'tea',
      name: 'Чай чёрный 100г',
      price: 10000,
      imagePath: 'assets/images/black_tea.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '28',
      categoryId: 'tea_coffee',
      subCategoryId: 'coffee',
      name: 'Кофе молотый 250г',
      price: 35000,
      imagePath: 'assets/images/coffee.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '29',
      categoryId: 'tea_coffee',
      subCategoryId: 'coffee',
      name: 'Кофе растворимый 100г',
      price: 28000,
      imagePath: 'assets/images/instant_coffee.png',
      unit: 'шт',
    ),

    // Средства гигиены
    ProductModel(
      id: '30',
      categoryId: 'hygiene',
      subCategoryId: 'personal',
      name: 'Мыло туалетное',
      price: 5000,
      imagePath: 'assets/images/soap.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '31',
      categoryId: 'hygiene',
      subCategoryId: 'personal',
      name: 'Зубная паста',
      price: 15000,
      imagePath: 'assets/images/toothpaste.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '32',
      categoryId: 'hygiene',
      subCategoryId: 'cleaning',
      name: 'Средство для мытья посуды',
      price: 12000,
      imagePath: 'assets/images/dish_soap.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '33',
      categoryId: 'hygiene',
      subCategoryId: 'cleaning',
      name: 'Стиральный порошок 1кг',
      price: 25000,
      imagePath: 'assets/images/detergent.png',
      unit: 'шт',
    ),

    // Напитки
    ProductModel(
      id: '34',
      categoryId: 'drinks',
      subCategoryId: 'water',
      name: 'Вода питьевая 1.5л',
      price: 4000,
      imagePath: 'assets/images/water.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '35',
      categoryId: 'drinks',
      subCategoryId: 'water',
      name: 'Вода газированная 1л',
      price: 5000,
      imagePath: 'assets/images/sparkling_water.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '36',
      categoryId: 'drinks',
      subCategoryId: 'juice',
      name: 'Сок яблочный 1л',
      price: 14000,
      imagePath: 'assets/images/apple_juice.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '37',
      categoryId: 'drinks',
      subCategoryId: 'juice',
      name: 'Сок апельсиновый 1л',
      price: 16000,
      imagePath: 'assets/images/orange_juice.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '38',
      categoryId: 'drinks',
      subCategoryId: 'soda',
      name: 'Кола 1л',
      price: 10000,
      imagePath: 'assets/images/cola.png',
      unit: 'шт',
    ),
    ProductModel(
      id: '39',
      categoryId: 'drinks',
      subCategoryId: 'soda',
      name: 'Лимонад 0.5л',
      price: 7000,
      imagePath: 'assets/images/lemonade.png',
      unit: 'шт',
    ),
  ];

  static List<ProductModel> getByCategoryId(String categoryId) {
    return mockProducts.where((p) => p.categoryId == categoryId).toList();
  }

  static List<ProductModel> getBySubCategoryId(
    String categoryId,
    String subCategoryId,
  ) {
    return mockProducts
        .where(
          (p) => p.categoryId == categoryId && p.subCategoryId == subCategoryId,
        )
        .toList();
  }
}
