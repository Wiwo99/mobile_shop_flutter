import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cart_cubit.dart';
import 'cubit/cart_state.dart';
import 'widgets/cart_item_tile.dart';
import 'widgets/empty_cart_view.dart';
import 'widgets/order_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<CartCubit, CartState>(
        listenWhen: (previous, current) {
          return previous.maybeMap(
            loaded: (prevLoaded) => current.maybeMap(
              loaded: (currLoaded) =>
                  currLoaded.items.length < prevLoaded.items.length,
              orElse: () => false,
            ),
            orElse: () => false,
          );
        },
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item removed from cart"),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return state.maybeMap(
              loaded: (loadedState) {
                final cartItems = loadedState.items;
                if (cartItems.isEmpty) return const EmptyCartView();

                return LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 800) {
                      // Desktop/Tablet: Split View
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemCount: cartItems.length,
                              separatorBuilder: (_, i) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) =>
                                  CartItemTile(item: cartItems[index]),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              child: OrderSummary(
                                cartItems: cartItems,
                                total: loadedState.totalAmount,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Mobile: List with Bottom Bar
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemCount: cartItems.length,
                              separatorBuilder: (_, i) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) =>
                                  CartItemTile(item: cartItems[index]),
                            ),
                          ),
                          OrderSummary(
                            cartItems: cartItems,
                            total: loadedState.totalAmount,
                            isMobileBottomInfo: true,
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              orElse: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}
