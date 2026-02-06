class SubcategoryModel {
  final String id;
  final String categoryId;
  final String name;

  const SubcategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  static const List<SubcategoryModel> subcategories = [
    // Фрукты
    SubcategoryModel(id: 'local', categoryId: 'fruits', name: 'Местные'),
    SubcategoryModel(id: 'citrus', categoryId: 'fruits', name: 'Цитрусовые'),
    SubcategoryModel(id: 'tropical', categoryId: 'fruits', name: 'Тропические'),
    // Овощи
    SubcategoryModel(id: 'root', categoryId: 'vegetables', name: 'Корнеплоды'),
    SubcategoryModel(id: 'greens', categoryId: 'vegetables', name: 'Зелень'),
    SubcategoryModel(id: 'tomatoes_cucumbers', categoryId: 'vegetables', name: 'Томаты и огурцы'),
    // Масло, яйца, молоко
    SubcategoryModel(id: 'milk', categoryId: 'dairy', name: 'Молоко'),
    SubcategoryModel(id: 'eggs', categoryId: 'dairy', name: 'Яйца'),
    SubcategoryModel(id: 'butter_oil', categoryId: 'dairy', name: 'Масло'),
    // Мука и зерновые
    SubcategoryModel(id: 'flour', categoryId: 'grains', name: 'Мука'),
    SubcategoryModel(id: 'cereals', categoryId: 'grains', name: 'Крупы'),
    SubcategoryModel(id: 'pasta', categoryId: 'grains', name: 'Макароны'),
    // Чаи и кофе
    SubcategoryModel(id: 'tea', categoryId: 'tea_coffee', name: 'Чай'),
    SubcategoryModel(id: 'coffee', categoryId: 'tea_coffee', name: 'Кофе'),
    // Средства гигиены
    SubcategoryModel(id: 'personal', categoryId: 'hygiene', name: 'Личная гигиена'),
    SubcategoryModel(id: 'cleaning', categoryId: 'hygiene', name: 'Для уборки'),
    // Напитки
    SubcategoryModel(id: 'water', categoryId: 'drinks', name: 'Вода'),
    SubcategoryModel(id: 'juice', categoryId: 'drinks', name: 'Соки'),
    SubcategoryModel(id: 'soda', categoryId: 'drinks', name: 'Газировка'),
  ];

  static List<SubcategoryModel> getByCategoryId(String categoryId) {
    return subcategories
        .where((sub) => sub.categoryId == categoryId)
        .toList();
  }
}
