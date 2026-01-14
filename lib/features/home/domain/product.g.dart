// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  name: json['name'] as String,
  price: json['price'] as String,
  category: json['category'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
  description: json['description'] as String,
  imageAsset: json['imageAsset'] as String,
  gradientColors:
      (json['gradientColors'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  availableColors:
      (json['availableColors'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  specs:
      (json['specs'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  stockCount: (json['stockCount'] as num?)?.toInt() ?? 10,
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'category': instance.category,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'description': instance.description,
  'imageAsset': instance.imageAsset,
  'gradientColors': instance.gradientColors,
  'availableColors': instance.availableColors,
  'features': instance.features,
  'specs': instance.specs,
  'stockCount': instance.stockCount,
};
