import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/product.dart';

part 'product_state.freezed.dart';

@freezed
sealed class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded({
    required List<Product> products,
    @Default('All') String selectedCategory,
    @Default('') String searchQuery,
  }) = _Loaded;
  const factory ProductState.error(String message) = _Error;
}
