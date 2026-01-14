import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/storage_service.dart';
import '../../../home/domain/product.dart';
import '../../../home/presentation/cubit/product_cubit.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState()) {
    _loadFromStorage();
  }

  void _loadFromStorage() {
    final savedIds = StorageService.instance.getFavorites();
    if (savedIds.isEmpty) return;

    // We need to get products from ProductCubit's static list
    final allProducts = ProductCubit.getAllProducts();
    final favorites = allProducts
        .where((p) => savedIds.contains(p.id))
        .toList();

    emit(state.copyWith(favorites: favorites));
  }

  void _saveToStorage() {
    final ids = state.favorites.map((p) => p.id).toList();
    StorageService.instance.saveFavorites(ids);
  }

  void toggleFavorite(Product product) {
    final currentFavorites = List<Product>.from(state.favorites);

    if (isFavorite(product)) {
      currentFavorites.removeWhere((p) => p.id == product.id);
    } else {
      currentFavorites.add(product);
    }

    emit(state.copyWith(favorites: currentFavorites));
    _saveToStorage();
  }

  bool isFavorite(Product product) {
    return state.favorites.any((p) => p.id == product.id);
  }

  void removeFromFavorites(Product product) {
    final currentFavorites = List<Product>.from(state.favorites);
    currentFavorites.removeWhere((p) => p.id == product.id);
    emit(state.copyWith(favorites: currentFavorites));
    _saveToStorage();
  }
}
