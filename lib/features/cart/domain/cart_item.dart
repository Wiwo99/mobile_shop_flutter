import 'package:freezed_annotation/freezed_annotation.dart';

import '../../home/domain/product.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
abstract class CartItem with _$CartItem {
  @JsonSerializable(explicitToJson: true)
  const factory CartItem({
    required Product product,
    required int quantity,
    required int color,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}
