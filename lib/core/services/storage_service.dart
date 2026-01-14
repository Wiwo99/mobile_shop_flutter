import 'package:hive_flutter/hive_flutter.dart';

/// Storage service for persisting app data locally using Hive.
class StorageService {
  static const String _cartBoxName = 'cart';
  static const String _favoritesBoxName = 'favorites';
  static const String _cartKey = 'cart_items';
  static const String _favoritesKey = 'favorite_ids';

  static StorageService? _instance;
  static StorageService get instance => _instance!;

  late Box<dynamic> _cartBox;
  late Box<dynamic> _favoritesBox;

  StorageService._();

  /// Initializes Hive and opens required boxes.
  static Future<void> init() async {
    await Hive.initFlutter();
    _instance = StorageService._();
    await _instance!._openBoxes();
  }

  Future<void> _openBoxes() async {
    _cartBox = await Hive.openBox(_cartBoxName);
    _favoritesBox = await Hive.openBox(_favoritesBoxName);
  }

  // ===== Cart Operations =====

  /// Saves cart items as a list of maps.
  Future<void> saveCart(List<Map<String, dynamic>> cartItems) async {
    await _cartBox.put(_cartKey, cartItems);
  }

  /// Gets saved cart items.
  List<Map<String, dynamic>> getCart() {
    final data = _cartBox.get(_cartKey);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(
      (data as List).map((e) => Map<String, dynamic>.from(e)),
    );
  }

  /// Clears the cart.
  Future<void> clearCart() async {
    await _cartBox.delete(_cartKey);
  }

  // ===== Favorites Operations =====

  /// Saves favorite product IDs.
  Future<void> saveFavorites(List<String> productIds) async {
    await _favoritesBox.put(_favoritesKey, productIds);
  }

  /// Gets saved favorite product IDs.
  List<String> getFavorites() {
    final data = _favoritesBox.get(_favoritesKey);
    if (data == null) return [];
    return List<String>.from(data);
  }

  /// Clears favorites.
  Future<void> clearFavorites() async {
    await _favoritesBox.delete(_favoritesKey);
  }
}
