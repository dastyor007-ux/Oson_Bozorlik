import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/subcategory_model.dart';

class AppStrings {
  AppStrings(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('ru'), Locale('uz'), Locale('en')];

  String get _lang => locale.languageCode;

  static const Map<String, Map<String, String>> _localizedValues = {
    'ru': {
      'appTitle': 'Oson Bozorlik',
      'cart': 'Корзина',
      'notifications': 'Уведомления',
      'notificationsEmpty': 'Пока нет уведомлений',
      'notificationsSubtitle': 'Мы сообщим о важных событиях',
      'orderHistory': 'История заказов',
      'orderHistoryEmpty': 'Пока нет истории заказов',
      'orderHistorySubtitle': 'Ваши заказы появятся здесь',
      'favorites': 'Избранное',
      'favoritesEmptyTitle': 'Пока нет избранных товаров',
      'favoritesEmptySubtitle': 'Добавляйте товары, чтобы не потерять',
      'addresses': 'Мои адреса',
      'addressesEmpty': 'Пока нет сохраненных адресов',
      'addressesSubtitle': 'Добавьте адрес для быстрой доставки',
      'language': 'Язык приложения',
      'about': 'О приложении',
      'aboutDescription':
          'Oson Bozorlik - свежие продукты и товары первой необходимости с доставкой на дом.',
      'support': 'Поддержка',
      'search': 'Поиск',
      'searchProducts': 'Поиск товаров',
      'nothingFound': 'Ничего не найдено',
      'tryDifferentQuery': 'Попробуйте изменить запрос',
      'enterQuery': 'Введите запрос для поиска',
      'sumOrder': 'Сумма заказа',
      'openCart': 'Открыть корзину',
      'langRu': 'Русский',
      'langUz': 'Узбекский',
      'langEn': 'Английский',
      'supportOpenFailed': 'Не удалось открыть ссылку',
      'loginProfile': 'Войти в профиль',
      'version': 'Версия',
      'categoryEmptyTitle': 'Пока нет товаров',
      'categoryEmptySubtitle': 'Мы скоро пополним каталог',
      'outOfStock': 'Нет в наличии',
      'removeProductTitle': 'Удалить товар?',
      'removeProductMessage':
          'Вы уверены, что хотите удалить "{name}" из корзины?',
      'cancel': 'Отмена',
      'yes': 'Да',
      'cartEmptyTitle': 'Корзина пуста',
      'cartEmptySubtitle': 'Добавьте товары из каталога',
      'products': 'Товары',
      'delivery': 'Доставка',
      'total': 'Итого',
      'removeUnavailable': 'Удалите недоступные товары из корзины',
      'checkout': 'Оформить заказ',
      'clearCartTitle': 'Очистить корзину?',
      'clearCartMessage': 'Вы уверены, что хотите очистить корзину?',
      'itemOne': 'товар',
      'itemFew': 'товара',
      'itemMany': 'товаров',
      'orderCheckoutTitle': 'Оформление заказа',
      'deliveryAddress': 'Адрес доставки',
      'selectDeliveryAddress': 'Выберите адрес доставки',
      'deliveryDate': 'Дата доставки',
      'today': 'Сегодня',
      'tomorrow': 'Завтра',
      'deliveryTime': 'Время доставки',
      'noSlotsToday':
          'На сегодня доступных интервалов нет - выберите дату завтра.',
      'payment': 'Оплата',
      'paymentCash': 'Наличные при получении',
      'paymentCard': 'Картой при получении',
      'checkoutForTotal': 'Оформить заказ на {total} SOM',
      'description': 'Описание',
      'descriptionSoon': 'Описание товара скоро появится.',
      'addedToCart': '{name} добавлен в корзину',
      'addToCart': 'В корзину',
      'selectQuantity': 'Выберите количество',
      'cities.zarafshan': 'Зарафшан',
      'cities.uchkuduk': 'Учкудук',
      'cities.navoi': 'Навои',
    },
    'uz': {
      'appTitle': 'Oson Bozorlik',
      'cart': 'Savat',
      'notifications': 'Bildirishnomalar',
      'notificationsEmpty': 'Hozircha bildirishnomalar yoq',
      'notificationsSubtitle': 'Muhim yangiliklar shu yerda chiqadi',
      'orderHistory': 'Buyurtmalar tarixi',
      'orderHistoryEmpty': 'Hozircha buyurtmalar tarixi yoq',
      'orderHistorySubtitle': 'Buyurtmalaringiz shu yerda korinadi',
      'favorites': 'Sevimlilar',
      'favoritesEmptyTitle': 'Hozircha sevimli mahsulotlar yoq',
      'favoritesEmptySubtitle': 'Mahsulotlarni yoqtirilganlarga qoshing',
      'addresses': 'Mening manzillarim',
      'addressesEmpty': 'Saqlangan manzillar yoq',
      'addressesSubtitle': 'Tez yetkazish uchun manzil qoshing',
      'language': 'Ilova tili',
      'about': 'Ilova haqida',
      'aboutDescription':
          'Oson Bozorlik - uyga yetkazib berish bilan yangi mahsulotlar va kundalik tovarlar.',
      'support': 'Yordam',
      'search': 'Qidiruv',
      'searchProducts': 'Mahsulotlarni qidirish',
      'nothingFound': 'Hech narsa topilmadi',
      'tryDifferentQuery': 'Boshqa sorovni kiriting',
      'enterQuery': 'Qidirish uchun sorov kiriting',
      'sumOrder': 'Buyurtma summasi',
      'openCart': 'Savatni ochish',
      'langRu': 'Ruscha',
      'langUz': 'Ozbekcha',
      'langEn': 'Inglizcha',
      'supportOpenFailed': 'Havolani ochib bolmadi',
      'loginProfile': 'Profilga kirish',
      'version': 'Versiya',
      'categoryEmptyTitle': 'Hozircha mahsulotlar yoq',
      'categoryEmptySubtitle': 'Tez orada katalog toldiriladi',
      'outOfStock': 'Mavjud emas',
      'removeProductTitle': 'Mahsulot ochirilsinmi?',
      'removeProductMessage': '"{name}" savatdan ochirilsinmi?',
      'cancel': 'Bekor qilish',
      'yes': 'Ha',
      'cartEmptyTitle': 'Savat bosh',
      'cartEmptySubtitle': 'Katalogdan mahsulot qoshing',
      'products': 'Mahsulotlar',
      'delivery': 'Yetkazish',
      'total': 'Jami',
      'removeUnavailable':
          'Mavjud bolmagan mahsulotlarni savatdan olib tashlang',
      'checkout': 'Buyurtma berish',
      'clearCartTitle': 'Savatni tozalaysizmi?',
      'clearCartMessage': 'Savatni tozalashni xohlaysizmi?',
      'itemOne': 'mahsulot',
      'itemFew': 'mahsulot',
      'itemMany': 'mahsulot',
      'orderCheckoutTitle': 'Buyurtmani rasmiylashtirish',
      'deliveryAddress': 'Yetkazish manzili',
      'selectDeliveryAddress': 'Yetkazish manzilini tanlang',
      'deliveryDate': 'Yetkazish sanasi',
      'today': 'Bugun',
      'tomorrow': 'Ertaga',
      'deliveryTime': 'Yetkazish vaqti',
      'noSlotsToday': 'Bugun vaqt oraligi yoq - ertangi sanani tanlang.',
      'payment': 'Tolov',
      'paymentCash': 'Qabulda naqd',
      'paymentCard': 'Qabulda karta orqali',
      'checkoutForTotal': '{total} SOM ga buyurtma berish',
      'description': 'Tavsif',
      'descriptionSoon': 'Mahsulot tavsifi tez orada qoshiladi.',
      'addedToCart': '{name} savatga qoshildi',
      'addToCart': 'Savatga',
      'selectQuantity': 'Miqdorni tanlang',
      'cities.zarafshan': 'Zarafshon',
      'cities.uchkuduk': 'Uchquduq',
      'cities.navoi': 'Navoiy',
    },
    'en': {
      'appTitle': 'Oson Bozorlik',
      'cart': 'Cart',
      'notifications': 'Notifications',
      'notificationsEmpty': 'No notifications yet',
      'notificationsSubtitle': 'Important updates will appear here',
      'orderHistory': 'Order history',
      'orderHistoryEmpty': 'No order history yet',
      'orderHistorySubtitle': 'Your orders will appear here',
      'favorites': 'Favorites',
      'favoritesEmptyTitle': 'No favorite products yet',
      'favoritesEmptySubtitle': 'Add products so you do not lose them',
      'addresses': 'My addresses',
      'addressesEmpty': 'No saved addresses yet',
      'addressesSubtitle': 'Add an address for quick delivery',
      'language': 'App language',
      'about': 'About app',
      'aboutDescription':
          'Oson Bozorlik - fresh groceries and daily essentials with home delivery.',
      'support': 'Support',
      'search': 'Search',
      'searchProducts': 'Search products',
      'nothingFound': 'Nothing found',
      'tryDifferentQuery': 'Try a different query',
      'enterQuery': 'Enter a query to search',
      'sumOrder': 'Order total',
      'openCart': 'Open cart',
      'langRu': 'Russian',
      'langUz': 'Uzbek',
      'langEn': 'English',
      'supportOpenFailed': 'Could not open link',
      'loginProfile': 'Sign in',
      'version': 'Version',
      'categoryEmptyTitle': 'No products yet',
      'categoryEmptySubtitle': 'We will update this catalog soon',
      'outOfStock': 'Out of stock',
      'removeProductTitle': 'Remove item?',
      'removeProductMessage':
          'Are you sure you want to remove "{name}" from cart?',
      'cancel': 'Cancel',
      'yes': 'Yes',
      'cartEmptyTitle': 'Cart is empty',
      'cartEmptySubtitle': 'Add products from the catalog',
      'products': 'Products',
      'delivery': 'Delivery',
      'total': 'Total',
      'removeUnavailable': 'Remove unavailable products from your cart',
      'checkout': 'Checkout',
      'clearCartTitle': 'Clear cart?',
      'clearCartMessage': 'Are you sure you want to clear your cart?',
      'itemOne': 'item',
      'itemFew': 'items',
      'itemMany': 'items',
      'orderCheckoutTitle': 'Checkout',
      'deliveryAddress': 'Delivery address',
      'selectDeliveryAddress': 'Select delivery address',
      'deliveryDate': 'Delivery date',
      'today': 'Today',
      'tomorrow': 'Tomorrow',
      'deliveryTime': 'Delivery time',
      'noSlotsToday': 'No available slots for today - select tomorrow.',
      'payment': 'Payment',
      'paymentCash': 'Cash on delivery',
      'paymentCard': 'Card on delivery',
      'checkoutForTotal': 'Checkout for {total} SOM',
      'description': 'Description',
      'descriptionSoon': 'Product description will be added soon.',
      'addedToCart': '{name} added to cart',
      'addToCart': 'Add to cart',
      'selectQuantity': 'Select quantity',
      'cities.zarafshan': 'Zarafshan',
      'cities.uchkuduk': 'Uchkuduk',
      'cities.navoi': 'Navoi',
    },
  };

  static const Map<String, Map<String, String>> _categoryNames = {
    'fruits': {'uz': 'Mevalar', 'en': 'Fruits'},
    'vegetables': {'uz': 'Sabzavotlar', 'en': 'Vegetables'},
    'meat': {'uz': 'Gosht', 'en': 'Meat'},
    'sausage': {'uz': 'Kolbasa', 'en': 'Sausages'},
    'grains': {'uz': 'Un va yorma', 'en': 'Flour and grains'},
    'hygiene': {'uz': 'Gigiyena va tozalash', 'en': 'Hygiene and cleaning'},
    'drinks': {'uz': 'Ichimliklar', 'en': 'Drinks'},
    'snacks': {'uz': 'Sneklar', 'en': 'Snacks'},
    'dairy': {'uz': 'Sut mahsulotlari', 'en': 'Dairy'},
    'tea_coffee': {'uz': 'Choy va qahva', 'en': 'Tea and coffee'},
  };

  static const Map<String, Map<String, String>> _subcategoryNames = {
    'local': {'uz': 'Mahalliy', 'en': 'Local'},
    'citrus': {'uz': 'Tsitrus', 'en': 'Citrus'},
    'tropical': {'uz': 'Tropik', 'en': 'Tropical'},
    'root': {'uz': 'Ildizmevalar', 'en': 'Root vegetables'},
    'greens': {'uz': 'Koklar', 'en': 'Greens'},
    'tomatoes_cucumbers': {
      'uz': 'Pomidor va bodring',
      'en': 'Tomatoes and cucumbers',
    },
    'milk': {'uz': 'Sut', 'en': 'Milk'},
    'eggs': {'uz': 'Tuxum', 'en': 'Eggs'},
    'butter_oil': {'uz': 'Yog', 'en': 'Butter and oil'},
    'flour': {'uz': 'Un', 'en': 'Flour'},
    'cereals': {'uz': 'Yormа', 'en': 'Cereals'},
    'pasta': {'uz': 'Makaron', 'en': 'Pasta'},
    'tea': {'uz': 'Choy', 'en': 'Tea'},
    'coffee': {'uz': 'Qahva', 'en': 'Coffee'},
    'personal': {'uz': 'Shaxsiy gigiyena', 'en': 'Personal care'},
    'cleaning': {'uz': 'Tozalash uchun', 'en': 'Cleaning'},
    'water': {'uz': 'Suv', 'en': 'Water'},
    'juice': {'uz': 'Sharbat', 'en': 'Juice'},
    'soda': {'uz': 'Gazli ichimlik', 'en': 'Soda'},
  };

  static const Map<String, Map<String, String>> _productNames = {
    '1': {'uz': 'Mahalliy oltin olma', 'en': 'Local golden apple'},
    '2': {'uz': 'Dyushes nok', 'en': 'Duchess pear'},
    '3': {'uz': 'Kishmish uzum', 'en': 'Seedless grapes'},
    '4': {'uz': 'Import apelsin', 'en': 'Imported orange'},
    '5': {'uz': 'Toshkent limoni', 'en': 'Tashkent lemon'},
    '6': {'uz': 'Marokash mandarini', 'en': 'Moroccan mandarin'},
    '7': {'uz': 'Ekvador banani', 'en': 'Ecuador banana'},
    '8': {'uz': 'Hind mango', 'en': 'Indian mango'},
    '9': {'uz': 'Ananas', 'en': 'Pineapple'},
    '10': {'uz': 'Mahalliy kartoshka', 'en': 'Local potato'},
    '11': {'uz': 'Yangi sabzi', 'en': 'Fresh carrot'},
    '12': {'uz': 'Lavlagi', 'en': 'Beetroot'},
    '13': {'uz': 'Shivit bog', 'en': 'Dill bunch'},
    '14': {'uz': 'Petrushka bog', 'en': 'Parsley bunch'},
    '15': {'uz': 'Pushti pomidor', 'en': 'Pink tomatoes'},
    '16': {'uz': 'Yangi bodring', 'en': 'Fresh cucumbers'},
    '17': {'uz': 'Sut 3.2%', 'en': 'Milk 3.2%'},
    '18': {'uz': 'Kefir 1%', 'en': 'Kefir 1%'},
    '19': {'uz': 'Tovuq tuxumi 10 dona', 'en': 'Chicken eggs 10 pcs'},
    '20': {'uz': 'Sariyog 200g', 'en': 'Butter 200g'},
    '21': {'uz': 'Kungaboqar yogi 1l', 'en': 'Sunflower oil 1L'},
    '22': {'uz': 'Bugdoy uni 1kg', 'en': 'Wheat flour 1kg'},
    '23': {'uz': 'Uzun donli guruch', 'en': 'Long grain rice'},
    '24': {'uz': 'Grechka 1kg', 'en': 'Buckwheat 1kg'},
    '25': {'uz': 'Spagetti makaron', 'en': 'Spaghetti pasta'},
    '26': {'uz': 'Kok choy 100g', 'en': 'Green tea 100g'},
    '27': {'uz': 'Qora choy 100g', 'en': 'Black tea 100g'},
    '28': {'uz': 'Maydalangan qahva 250g', 'en': 'Ground coffee 250g'},
    '29': {'uz': 'Eriydigan qahva 100g', 'en': 'Instant coffee 100g'},
    '30': {'uz': 'Tualet sovuni', 'en': 'Toilet soap'},
    '31': {'uz': 'Tish pastasi', 'en': 'Toothpaste'},
    '32': {'uz': 'Idish yuvish vositasi', 'en': 'Dishwashing liquid'},
    '33': {'uz': 'Kir yuvish kukuni 1kg', 'en': 'Laundry powder 1kg'},
    '34': {'uz': 'Ichimlik suvi 1.5l', 'en': 'Drinking water 1.5L'},
    '35': {'uz': 'Gazlangan suv 1l', 'en': 'Sparkling water 1L'},
    '36': {'uz': 'Olma sharbati 1l', 'en': 'Apple juice 1L'},
    '37': {'uz': 'Apelsin sharbati 1l', 'en': 'Orange juice 1L'},
    '38': {'uz': 'Cola 1l', 'en': 'Cola 1L'},
    '39': {'uz': 'Limonad 0.5l', 'en': 'Lemonade 0.5L'},
  };

  String t(String key) {
    final lang = _localizedValues[_lang] ?? _localizedValues['ru']!;
    return lang[key] ?? _localizedValues['ru']![key] ?? key;
  }

  String tr(String key, Map<String, String> values) {
    var result = t(key);
    values.forEach((token, value) {
      result = result.replaceAll('{$token}', value);
    });
    return result;
  }

  String cityName(String cityId) {
    return t('cities.$cityId');
  }

  String categoryName(CategoryModel category) {
    return _categoryNames[category.id]?[_lang] ?? category.name;
  }

  String subcategoryName(SubcategoryModel subcategory) {
    return _subcategoryNames[subcategory.id]?[_lang] ?? subcategory.name;
  }

  String productName(ProductModel product) {
    return _productNames[product.id]?[_lang] ?? product.name;
  }

  String productDescription(ProductModel product) {
    if (_lang == 'ru') return product.description;
    final name = productName(product);
    if (_lang == 'uz') {
      return '$name - yangi va sifatli mahsulot. Kundalik xarid uchun mos.';
    }
    return '$name - fresh quality product, suitable for everyday shopping.';
  }

  String unit(String baseUnit) {
    if (_lang == 'ru') return baseUnit;
    switch (baseUnit) {
      case 'кг':
        return _lang == 'uz' ? 'kg' : 'kg';
      case 'л':
        return _lang == 'uz' ? 'l' : 'L';
      case 'шт':
        return _lang == 'uz' ? 'dona' : 'pcs';
      default:
        return baseUnit;
    }
  }

  String unitWithOne(String baseUnit) {
    final u = unit(baseUnit);
    if (baseUnit == 'кг') return '1 $u';
    return u;
  }

  String quantityLabel(double quantity, String baseUnit) {
    if (baseUnit == 'кг') {
      if (quantity < 1) {
        return '${(quantity * 1000).toInt()} ${_lang == 'ru' ? 'г' : 'g'}';
      }
      final value = quantity.toStringAsFixed(
        quantity == quantity.roundToDouble() ? 0 : 1,
      );
      return '$value ${unit(baseUnit)}';
    }
    return '${quantity.toInt()} ${unit(baseUnit)}';
  }

  String weightLabel(double weightKg) {
    if (weightKg < 1) {
      return '${(weightKg * 1000).round()} ${_lang == 'ru' ? 'г' : 'g'}';
    }
    final rounded = weightKg == weightKg.roundToDouble()
        ? weightKg.toStringAsFixed(0)
        : weightKg.toStringAsFixed(1);
    return '$rounded ${unit('кг')}';
  }

  String itemsWord(int count) {
    if (_lang != 'ru') {
      return count == 1 ? t('itemOne') : t('itemMany');
    }
    if (count % 10 == 1 && count % 100 != 11) return t('itemOne');
    if (count % 10 >= 2 &&
        count % 10 <= 4 &&
        (count % 100 < 10 || count % 100 >= 20)) {
      return t('itemFew');
    }
    return t('itemMany');
  }
}

extension AppStringsX on BuildContext {
  AppStrings get strings => AppStrings(Localizations.localeOf(this));
}
