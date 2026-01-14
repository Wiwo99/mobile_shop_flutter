import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/storage_service.dart';
import '../../domain/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState.initial()) {
    _loadFromStorage();
  }

  void _loadFromStorage() {
    final savedCart = StorageService.instance.getCart();
    if (savedCart.isEmpty) {
      emit(const CartState.loaded(items: [], totalAmount: 0));
    } else {
      final items = savedCart.map((e) => CartItem.fromJson(e)).toList();
      emit(CartState.loaded(items: items, totalAmount: _calculateTotal(items)));
    }
  }

  void _saveToStorage(List<CartItem> items) {
    final jsonList = items.map((e) => e.toJson()).toList();
    StorageService.instance.saveCart(jsonList);
  }

  void addToCart(CartItem newItem) {
    // Safely extract current items using map
    final currentItems = state.maybeMap(
      loaded: (s) => s.items,
      orElse: () => <CartItem>[],
    );

    // Logic to add item
    List<CartItem> newItems;
    if (currentItems.any(
      (item) =>
          item.product.id == newItem.product.id && item.color == newItem.color,
    )) {
      // Increment
      newItems = currentItems.map((item) {
        if (item.product.id == newItem.product.id &&
            item.color == newItem.color) {
          return item.copyWith(quantity: item.quantity + newItem.quantity);
        }
        return item;
      }).toList();
    } else {
      // Add
      newItems = [...currentItems, newItem];
    }

    _saveToStorage(newItems);
    emit(
      CartState.loaded(items: newItems, totalAmount: _calculateTotal(newItems)),
    );
  }

  void removeFromCart(CartItem itemToRemove) {
    state.mapOrNull(
      loaded: (loadedState) {
        final newItems = loadedState.items
            .where((item) => item != itemToRemove)
            .toList();
        emit(
          CartState.loaded(
            items: newItems,
            totalAmount: _calculateTotal(newItems),
          ),
        );
      },
    );
  }

  void clearCart() {
    StorageService.instance.clearCart();
    emit(const CartState.loaded(items: [], totalAmount: 0));
  }

  void incrementQuantity(CartItem item) {
    state.mapOrNull(
      loaded: (loadedState) {
        final newItems = loadedState.items.map((i) {
          if (i.product.id == item.product.id && i.color == item.color) {
            return i.copyWith(quantity: i.quantity + 1);
          }
          return i;
        }).toList();
        emit(
          CartState.loaded(
            items: newItems,
            totalAmount: _calculateTotal(newItems),
          ),
        );
      },
    );
  }

  void decrementQuantity(CartItem item) {
    state.mapOrNull(
      loaded: (loadedState) {
        if (item.quantity <= 1) {
          // Remove item if quantity would become 0
          removeFromCart(item);
          return;
        }
        final newItems = loadedState.items.map((i) {
          if (i.product.id == item.product.id && i.color == item.color) {
            return i.copyWith(quantity: i.quantity - 1);
          }
          return i;
        }).toList();
        emit(
          CartState.loaded(
            items: newItems,
            totalAmount: _calculateTotal(newItems),
          ),
        );
      },
    );
  }

  // Helper to calculate total
  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (total, item) {
      final price =
          double.tryParse(item.product.price.replaceAll('\$', '')) ?? 0;
      return total + (price * item.quantity);
    });
  }
}
