class ProductModel {
  final String id;
  final String categoryId;
  final String subCategoryId;
  final String name;
  final double price; // Price per unit (e.g., per 1 kg)
  final String imagePath;
  final bool isAvailable;
  final String unit; // 'кг', 'шт', etc.
  final String description;
  final double weightPerUnitKg; // For delivery cost calculation

  const ProductModel({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.name,
    required this.price,
    required this.imagePath,
    this.isAvailable = true,
    this.unit = 'кг',
    this.description = '',
    this.weightPerUnitKg = 1.0,
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
      description:
          'Сочное яблоко золотистого сорта, выращенное в местных садах. Отличается сладким вкусом с лёгкой кислинкой и хрустящей текстурой.',
    ),
    ProductModel(
      id: '2',
      categoryId: 'fruits',
      subCategoryId: 'local',
      name: 'Груша Дюшес',
      price: 15000,
      imagePath: 'assets/images/pear.png',
      description:
          'Ароматная груша сорта Дюшес с нежной маслянистой мякотью. Идеально подходит для свежего употребления и десертов.',
    ),
    ProductModel(
      id: '3',
      categoryId: 'fruits',
      subCategoryId: 'local',
      name: 'Виноград кишмиш',
      price: 22000,
      imagePath: 'assets/images/grape.png',
      description:
          'Бескосточковый виноград сорта кишмиш. Сладкие и сочные ягоды, богатые витаминами и антиоксидантами.',
    ),
    // Фрукты — Цитрусовые
    ProductModel(
      id: '4',
      categoryId: 'fruits',
      subCategoryId: 'citrus',
      name: 'Апельсин импортный',
      price: 25000,
      imagePath: 'assets/images/orange.png',
      description:
          'Крупный сочный апельсин с ярким цитрусовым ароматом. Богат витамином C, идеален для свежевыжатого сока.',
    ),
    ProductModel(
      id: '5',
      categoryId: 'fruits',
      subCategoryId: 'citrus',
      name: 'Лимон Ташкент',
      price: 18000,
      imagePath: 'assets/images/lemon.png',
      description:
          'Ташкентский лимон с тонкой кожурой и насыщенным кислым вкусом. Незаменим на кухне и для приготовления напитков.',
    ),
    ProductModel(
      id: '6',
      categoryId: 'fruits',
      subCategoryId: 'citrus',
      name: 'Мандарин Марокко',
      price: 28000,
      imagePath: 'assets/images/mandarin.png',
      description:
          'Сладкие марокканские мандарины с тонкой кожурой, легко чистятся. Отличный перекус, богатый витаминами.',
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
      description:
          'Спелые бананы из Эквадора. Сладкие, питательные и богатые калием — идеальный источник энергии.',
    ),
    ProductModel(
      id: '8',
      categoryId: 'fruits',
      subCategoryId: 'tropical',
      name: 'Манго Индия',
      price: 45000,
      imagePath: 'assets/images/mango.png',
      description:
          'Экзотическое индийское манго с сочной сладкой мякотью и ярким тропическим ароматом.',
    ),
    ProductModel(
      id: '9',
      categoryId: 'fruits',
      subCategoryId: 'tropical',
      name: 'Ананас',
      price: 38000,
      imagePath: 'assets/images/pineapple.png',
      description:
          'Свежий тропический ананас с кисло-сладким вкусом. Идеально подходит для десертов и фруктовых салатов.',
    ),

    // Овощи — Корнеплоды
    ProductModel(
      id: '10',
      categoryId: 'vegetables',
      subCategoryId: 'root',
      name: 'Картофель местный',
      price: 5000,
      imagePath: 'assets/images/potato.png',
      description:
          'Местный картофель отборного качества. Отлично подходит для жарки, варки и запекания.',
    ),
    ProductModel(
      id: '11',
      categoryId: 'vegetables',
      subCategoryId: 'root',
      name: 'Морковь свежая',
      price: 6000,
      imagePath: 'assets/images/carrot.png',
      description:
          'Свежая сочная морковь, выращенная на местных фермах. Богата бета-каротином и клетчаткой.',
    ),
    ProductModel(
      id: '12',
      categoryId: 'vegetables',
      subCategoryId: 'root',
      name: 'Свёкла',
      price: 4500,
      imagePath: 'assets/images/beet.png',
      description:
          'Столовая свёкла насыщенного бордового цвета. Используется для салатов, борщей и свежевыжатых соков.',
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
      description:
          'Свежий ароматный укроп. Незаменимая зелень для салатов, супов и гарниров.',
    ),
    ProductModel(
      id: '14',
      categoryId: 'vegetables',
      subCategoryId: 'greens',
      name: 'Петрушка пучок',
      price: 3000,
      imagePath: 'assets/images/parsley.png',
      unit: 'шт',
      description:
          'Свежая петрушка с ярким вкусом и ароматом. Отлично дополняет блюда и салаты.',
    ),
    // Овощи — Томаты и огурцы
    ProductModel(
      id: '15',
      categoryId: 'vegetables',
      subCategoryId: 'tomatoes_cucumbers',
      name: 'Помидоры розовые',
      price: 14000,
      imagePath: 'assets/images/tomato.png',
      description:
          'Розовые помидоры с нежной мякотью и сладковатым вкусом. Отлично подходят для салатов и нарезки.',
    ),
    ProductModel(
      id: '16',
      categoryId: 'vegetables',
      subCategoryId: 'tomatoes_cucumbers',
      name: 'Огурцы свежие',
      price: 10000,
      imagePath: 'assets/images/cucumber.png',
      description:
          'Хрустящие свежие огурцы с насыщенным вкусом. Идеальны для салатов и лёгких закусок.',
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
      description:
          'Натуральное коровье молоко жирностью 3.2%. Свежее, пастеризованное, без добавок.',
    ),
    ProductModel(
      id: '18',
      categoryId: 'dairy',
      subCategoryId: 'milk',
      name: 'Кефир 1%',
      price: 11000,
      imagePath: 'assets/images/kefir.png',
      unit: 'л',
      description:
          'Лёгкий кефир жирностью 1%. Полезный кисломолочный продукт для здорового пищеварения.',
    ),
    ProductModel(
      id: '19',
      categoryId: 'dairy',
      subCategoryId: 'eggs',
      name: 'Яйца куриные 10 шт',
      price: 16000,
      imagePath: 'assets/images/eggs.png',
      unit: 'шт',
      description:
          'Свежие куриные яйца категории С1. Упаковка 10 штук. Незаменимый продукт на каждый день.',
    ),
    ProductModel(
      id: '20',
      categoryId: 'dairy',
      subCategoryId: 'butter_oil',
      name: 'Масло сливочное 200г',
      price: 18000,
      imagePath: 'assets/images/butter.png',
      unit: 'шт',
      description:
          'Натуральное сливочное масло 82.5% жирности. Изготовлено из свежих сливок.',
    ),
    ProductModel(
      id: '21',
      categoryId: 'dairy',
      subCategoryId: 'butter_oil',
      name: 'Масло подсолнечное 1л',
      price: 22000,
      imagePath: 'assets/images/oil.png',
      unit: 'шт',
      description:
          'Рафинированное подсолнечное масло для жарки и заправки. Без запаха и осадка.',
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
      description:
          'Пшеничная мука высшего сорта. Идеальна для выпечки хлеба, лепёшек и кондитерских изделий.',
    ),
    ProductModel(
      id: '23',
      categoryId: 'grains',
      subCategoryId: 'cereals',
      name: 'Рис длиннозёрный',
      price: 15000,
      imagePath: 'assets/images/rice.png',
      description:
          'Длиннозёрный рис премиум качества. Рассыпчатый после варки, подходит для плова и гарниров.',
    ),
    ProductModel(
      id: '24',
      categoryId: 'grains',
      subCategoryId: 'cereals',
      name: 'Гречка 1кг',
      price: 14000,
      imagePath: 'assets/images/buckwheat.png',
      unit: 'шт',
      description:
          'Гречневая крупа ядрица. Богата железом и белком, отличный гарнир для здорового питания.',
    ),
    ProductModel(
      id: '25',
      categoryId: 'grains',
      subCategoryId: 'pasta',
      name: 'Макароны спагетти',
      price: 9000,
      imagePath: 'assets/images/pasta.png',
      unit: 'шт',
      description:
          'Спагетти из твёрдых сортов пшеницы. Быстро готовятся, сохраняют форму при варке.',
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
      description:
          'Листовой зелёный чай с мягким вкусом и освежающим ароматом. Богат антиоксидантами.',
    ),
    ProductModel(
      id: '27',
      categoryId: 'tea_coffee',
      subCategoryId: 'tea',
      name: 'Чай чёрный 100г',
      price: 10000,
      imagePath: 'assets/images/black_tea.png',
      unit: 'шт',
      description:
          'Классический чёрный чай с насыщенным вкусом и бодрящим эффектом. Идеален для утреннего чаепития.',
    ),
    ProductModel(
      id: '28',
      categoryId: 'tea_coffee',
      subCategoryId: 'coffee',
      name: 'Кофе молотый 250г',
      price: 35000,
      imagePath: 'assets/images/coffee.png',
      unit: 'шт',
      description:
          'Молотый кофе средней обжарки из отборных зёрен арабики. Насыщенный аромат и глубокий вкус.',
    ),
    ProductModel(
      id: '29',
      categoryId: 'tea_coffee',
      subCategoryId: 'coffee',
      name: 'Кофе растворимый 100г',
      price: 28000,
      imagePath: 'assets/images/instant_coffee.png',
      unit: 'шт',
      description:
          'Растворимый кофе для быстрого приготовления. Сохраняет аромат и вкус натурального кофе.',
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
      description:
          'Туалетное мыло с нежным ароматом. Бережно очищает кожу, не пересушивая её.',
    ),
    ProductModel(
      id: '31',
      categoryId: 'hygiene',
      subCategoryId: 'personal',
      name: 'Зубная паста',
      price: 15000,
      imagePath: 'assets/images/toothpaste.png',
      unit: 'шт',
      description:
          'Зубная паста с фтором для комплексной защиты зубов и дёсен. Освежает дыхание.',
    ),
    ProductModel(
      id: '32',
      categoryId: 'hygiene',
      subCategoryId: 'cleaning',
      name: 'Средство для мытья посуды',
      price: 12000,
      imagePath: 'assets/images/dish_soap.png',
      unit: 'шт',
      description:
          'Эффективное средство для мытья посуды. Легко удаляет жир, бережно к коже рук.',
    ),
    ProductModel(
      id: '33',
      categoryId: 'hygiene',
      subCategoryId: 'cleaning',
      name: 'Стиральный порошок 1кг',
      price: 25000,
      imagePath: 'assets/images/detergent.png',
      unit: 'шт',
      description:
          'Универсальный стиральный порошок для всех типов тканей. Эффективно удаляет пятна при любой температуре.',
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
      description:
          'Чистая питьевая вода из горных источников. Без газа, идеальна для ежедневного потребления.',
    ),
    ProductModel(
      id: '35',
      categoryId: 'drinks',
      subCategoryId: 'water',
      name: 'Вода газированная 1л',
      price: 5000,
      imagePath: 'assets/images/sparkling_water.png',
      unit: 'шт',
      description:
          'Природная газированная вода с приятным освежающим вкусом. Утоляет жажду в любое время.',
    ),
    ProductModel(
      id: '36',
      categoryId: 'drinks',
      subCategoryId: 'juice',
      name: 'Сок яблочный 1л',
      price: 14000,
      imagePath: 'assets/images/apple_juice.png',
      unit: 'шт',
      description:
          'Натуральный яблочный сок прямого отжима. Без добавления сахара и консервантов.',
    ),
    ProductModel(
      id: '37',
      categoryId: 'drinks',
      subCategoryId: 'juice',
      name: 'Сок апельсиновый 1л',
      price: 16000,
      imagePath: 'assets/images/orange_juice.png',
      unit: 'шт',
      description:
          'Свежий апельсиновый сок, богатый витамином C. Яркий цитрусовый вкус для бодрого утра.',
    ),
    ProductModel(
      id: '38',
      categoryId: 'drinks',
      subCategoryId: 'soda',
      name: 'Кола 1л',
      price: 10000,
      imagePath: 'assets/images/cola.png',
      unit: 'шт',
      description:
          'Классическая кола с карамельным вкусом и приятной газацией. Подавать охлаждённой.',
    ),
    ProductModel(
      id: '39',
      categoryId: 'drinks',
      subCategoryId: 'soda',
      name: 'Лимонад 0.5л',
      price: 7000,
      imagePath: 'assets/images/lemonade.png',
      unit: 'шт',
      description:
          'Освежающий лимонад с натуральным вкусом лимона. Лёгкая газация, идеален в жаркую погоду.',
    ),
  ];

  static ProductModel? findById(String id) {
    try {
      return mockProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

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
