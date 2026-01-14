import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String price,
    required String category,
    required double rating,
    required int reviewCount,
    required String description,
    required String imageAsset, // Local Asset Path
    @Default([]) List<int> gradientColors, // Optional bg
    @Default([]) List<int> availableColors, // Variants
    @Default([]) List<String> features, // Bullet points
    @Default({}) Map<String, String> specs, // Table data
    @Default(10) int stockCount, // Real-time inventory demo
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
