import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/widgets/holo_progress_indicator.dart';
import 'cubit/product_cubit.dart';
import 'cubit/product_state.dart';
import 'widgets/category_selector.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/product_card.dart';
import 'widgets/promo_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().loadProducts();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ProductCubit>().loadProducts();
        },
        color: const Color(0xFF003D29),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const HomeAppBar(),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(child: PromoBanner()),
            const SliverToBoxAdapter(child: CategorySelector()),

            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return state.maybeMap(
                  loading: (_) => SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const HoloProgressIndicator(size: 80),
                          const SizedBox(height: 16),
                          Text(
                                "OPTIMIZING ENGINE...",
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              )
                              .animate(onPlay: (c) => c.repeat())
                              .fadeIn(duration: 800.ms)
                              .fadeOut(delay: 800.ms),
                        ],
                      ),
                    ),
                  ),
                  loaded: (state) {
                    final products = state.products;

                    if (products.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "No products found",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              childAspectRatio: 0.70,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return ProductCard(product: products[index])
                              .animate()
                              .fadeIn(duration: 600.ms, delay: (50 * index).ms)
                              .scale(
                                begin: const Offset(0.9, 0.9),
                                end: const Offset(1.0, 1.0),
                                duration: 600.ms,
                                curve: Curves.easeOutBack,
                                delay: (50 * index).ms,
                              );
                        }, childCount: products.length),
                      ),
                    );
                  },
                  orElse: () =>
                      const SliverToBoxAdapter(child: SizedBox.shrink()),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
