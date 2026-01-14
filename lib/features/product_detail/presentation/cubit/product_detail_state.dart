import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_state.freezed.dart';

@freezed
sealed class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.initial({
    @Default(1) int quantity,
    @Default(0) int selectedColorIndex,
  }) = _Initial;

  const factory ProductDetailState.addingToCart({
    required int quantity,
    required int selectedColorIndex,
  }) = _AddingToCart;

  const factory ProductDetailState.addedToCart({
    required int quantity,
    required int selectedColorIndex,
  }) = _AddedToCart;

  const factory ProductDetailState.failure({
    required int quantity,
    required int selectedColorIndex,
  }) = _Failure;
}
