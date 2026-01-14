import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/cart_item.dart';

part 'cart_state.freezed.dart';

@freezed
sealed class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.loading() = _Loading;
  const factory CartState.loaded({
    required List<CartItem> items,
    required double totalAmount,
  }) = _Loaded;
  const factory CartState.error(String message) = _Error;
}
