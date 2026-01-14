import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_shop_flutter/features/cart/domain/cart_item.dart';
import 'package:mobile_shop_flutter/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:mobile_shop_flutter/features/home/domain/product.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailState.initial());

  void incrementQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void selectColor(int index) {
    emit(state.copyWith(selectedColorIndex: index));
  }

  void addToCart(Product product, CartCubit cartCubit) {
    final currentQuantity = state.quantity;
    final currentColorIndex = state.selectedColorIndex;

    emit(
      ProductDetailState.addingToCart(
        quantity: currentQuantity,
        selectedColorIndex: currentColorIndex,
      ),
    );

    try {
      final cartItem = CartItem(
        product: product,
        quantity: currentQuantity,
        color: product.availableColors[currentColorIndex],
      );
      cartCubit.addToCart(cartItem);

      emit(
        ProductDetailState.addedToCart(
          quantity: currentQuantity,
          selectedColorIndex: currentColorIndex,
        ),
      );

      // Reset to initial state (idle) but keep values
      emit(
        ProductDetailState.initial(
          quantity: currentQuantity,
          selectedColorIndex: currentColorIndex,
        ),
      );
    } catch (e) {
      emit(
        ProductDetailState.failure(
          quantity: currentQuantity,
          selectedColorIndex: currentColorIndex,
        ),
      );
    }
  }
}
