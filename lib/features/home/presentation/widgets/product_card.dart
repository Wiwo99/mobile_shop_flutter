import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_shop_flutter/features/cart/domain/cart_item.dart';
import 'package:mobile_shop_flutter/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:mobile_shop_flutter/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:mobile_shop_flutter/features/favorites/presentation/cubit/favorites_state.dart';

import '../../domain/product.dart';
import 'product_card_painter.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () =>
          context.push('/product/${widget.product.id}', extra: widget.product),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: ProductCardPainter(
              primaryColor: Color(
                widget.product.gradientColors.isNotEmpty
                    ? widget.product.gradientColors.first
                    : 0xFF003D29,
              ),
              secondaryColor: Color(
                widget.product.gradientColors.length > 1
                    ? widget.product.gradientColors[1]
                    : 0xFFD4A373,
              ),
              animationValue: _controller.value,
            ),
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    // Main Image with Hero
                    Center(
                      child: Hero(
                        tag: 'product-img-${widget.product.id}',
                        child: Image.asset(
                          widget.product.imageAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // Favorite Button
                    Positioned(
                      top: 0,
                      right: 0,
                      child: BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFavorite = context
                              .read<FavoritesCubit>()
                              .isFavorite(widget.product);
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              context.read<FavoritesCubit>().toggleFavorite(
                                widget.product,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.black26 : Colors.white70,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18,
                                color: isFavorite
                                    ? Colors.red
                                    : (isDark
                                          ? Colors.white70
                                          : Colors.black54),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Stock Badge (Real-time update demo)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: _StockBadge(count: widget.product.stockCount),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  ...List.generate(
                    5,
                    (index) => Icon(
                      index < widget.product.rating.round()
                          ? Icons.star
                          : Icons.star_border,
                      size: 14,
                      color: const Color(0xFF00C569),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "(${widget.product.reviewCount})",
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.price,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  _AddToCartButton(product: widget.product),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StockBadge extends StatelessWidget {
  final int count;
  const _StockBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    final isLowStock = count > 0 && count <= 5;
    final isOutOfStock = count == 0;

    if (!isLowStock && !isOutOfStock) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isOutOfStock ? Colors.red : Colors.orange,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isOutOfStock ? "Out of Stock" : "Only $count left",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final Product product;
  const _AddToCartButton({required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (product.stockCount == 0) return;

        final cartItem = CartItem(
          product: product,
          quantity: 1,
          color: product.availableColors.first,
        );
        context.read<CartCubit>().addToCart(cartItem);
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: product.stockCount == 0
              ? Colors.grey.withValues(alpha: 0.3)
              : (isDark ? Colors.white10 : Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.add,
          size: 18,
          color: product.stockCount == 0 ? Colors.grey : Colors.white,
        ),
      ),
    );
  }
}
