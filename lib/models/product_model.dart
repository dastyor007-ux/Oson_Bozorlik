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
      subCategoryId: 'citrus',
      name: 'Апельсин импортный',
      price: 25000,
      imagePath: 'assets/images/orange.png',
    ),
    ProductModel(
      id: '3',
      categoryId: 'fruits',
      subCategoryId: 'tropical',
      name: 'Банан Эквадор',
      price: 18000,
      imagePath: 'assets/images/banana.png',
      isAvailable: false,
    ),
    ProductModel(
      id: '4',
      categoryId: 'fruits',
      subCategoryId: 'local',
      name: 'Груша Дюшес',
      price: 15000,
      imagePath: 'assets/images/pear.png',
    ),
  ];
}
