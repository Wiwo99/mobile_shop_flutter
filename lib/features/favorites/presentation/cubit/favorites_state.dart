import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../home/domain/product.dart';

part 'favorites_state.freezed.dart';

@freezed
sealed class FavoritesState with _$FavoritesState {
  const factory FavoritesState({@Default([]) List<Product> favorites}) =
      _FavoritesState;
}
