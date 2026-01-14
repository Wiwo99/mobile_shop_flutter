import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/widgets/common_widgets.dart';
import '../../cart/presentation/cubit/cart_cubit.dart';
import '../../favorites/presentation/cubit/favorites_cubit.dart';
import '../../favorites/presentation/cubit/favorites_state.dart';
import '../../home/domain/product.dart';
import '../../home/presentation/cubit/product_cubit.dart';
import '../../home/presentation/cubit/product_state.dart';
import 'cubit/product_detail_cubit.dart';
import 'cubit/product_detail_state.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailCubit(),
      child: BlocListener<ProductDetailCubit, ProductDetailState>(
        listenWhen: (previous, current) => current.maybeMap(
          addedToCart: (_) => true,
          failure: (_) => true,
          orElse: () => false,
        ),
        listener: (context, state) {
          state.mapOrNull(
            addedToCart: (addedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.name} added to cart!"),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: const Color(0xFF003D29),
                ),
              );
            },
            failure: (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Failed to add to cart"),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          );
        },
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, productState) {
            // Get the live product data if available for real-time stock
            final liveProduct = productState.maybeMap(
              loaded: (s) => s.products.firstWhere(
                (p) => p.id == product.id,
                orElse: () => product,
              ),
              orElse: () => product,
            );
            return _ProductDetailView(product: liveProduct);
          },
        ),
      ),
    );
  }
}

class _ProductDetailView extends StatelessWidget {
  final Product product;

  const _ProductDetailView({required this.product});

  List<int> get availableColors => product.availableColors;

  void _addToCart(BuildContext context) {
    if (product.stockCount == 0) return;
    context.read<ProductDetailCubit>().addToCart(
      product,
      context.read<CartCubit>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return _buildDesktopLayout(context);
          }
          return _buildMobileLayout(context);
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Price",
                    style: TextStyle(color: Colors.grey),
                  ),
                  BlocBuilder<ProductDetailCubit, ProductDetailState>(
                    builder: (context, state) {
                      return Text(
                        "\$${(double.parse(product.price.replaceAll('\$', '')) * state.quantity).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: product.stockCount > 0
                    ? () => _addToCart(context)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: product.stockCount > 0
                      ? (isDark ? theme.colorScheme.primary : Colors.black)
                      : Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      product.stockCount > 0 ? "Add to Cart" : "Out of Stock",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    // Desktop layout remains largely the same but with theme support and Hero
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            left: 40,
            right: 40,
            bottom: 40,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Hero(
                          tag: 'product-img-${product.id}',
                          child: Image.asset(product.imageAsset, height: 400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildInfoSection(context)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          backgroundColor: theme.scaffoldBackgroundColor,
          leading: BackButton(color: isDark ? Colors.white : Colors.black),
          actions: [
            BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFavorite = context.read<FavoritesCubit>().isFavorite(
                  product,
                );
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? Colors.red
                        : (isDark ? Colors.white : Colors.black),
                  ),
                  onPressed: () =>
                      context.read<FavoritesCubit>().toggleFavorite(product),
                );
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: isDark
                  ? theme.colorScheme.surface
                  : const Color(0xFFF5F5F7),
              child: Stack(
                children: [
                  Center(
                    child: Hero(
                      tag: 'product-img-${product.id}',
                      child:
                          Image.asset(
                            product.imageAsset,
                            fit: BoxFit.contain,
                            height: 300,
                          ).animate().scale(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: _LiveStockLabel(count: product.stockCount),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: _buildInfoSection(context),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            Text(
              product.price,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF003D29),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: "Color"),
        BlocBuilder<ProductDetailCubit, ProductDetailState>(
          buildWhen: (previous, current) =>
              previous.selectedColorIndex != current.selectedColorIndex,
          builder: (context, state) {
            return ColorSelector(
              colors: availableColors,
              selectedIndex: state.selectedColorIndex,
              onSelect: (idx) =>
                  context.read<ProductDetailCubit>().selectColor(idx),
            );
          },
        ),
        const SizedBox(height: 32),
        const SectionHeader(title: "Description"),
        Text(
          product.description,
          style: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        if (product.features.isNotEmpty) ...[
          const SectionHeader(title: "Key Features"),
          ...product.features.map((f) => FeatureItem(text: f)),
        ],
        const SizedBox(height: 100),
      ],
    );
  }
}

class _LiveStockLabel extends StatelessWidget {
  final int count;
  const _LiveStockLabel({required this.count});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: count > 0
            ? (isDark ? Colors.green[900] : Colors.green[50])
            : Colors.red[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: count > 0 ? Colors.green : Colors.red,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: count > 0 ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.5, 1.5),
                duration: 800.ms,
              )
              .fadeOut(),
          const SizedBox(width: 8),
          Text(
            count > 0 ? "LIVE: $count in stock" : "OUT OF STOCK",
            style: TextStyle(
              color: count > 0
                  ? (isDark ? Colors.green[100] : Colors.green[800])
                  : Colors.red[800],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
