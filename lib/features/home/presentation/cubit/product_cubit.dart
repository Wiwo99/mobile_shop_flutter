import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/product.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  Timer? _inventoryTimer;

  ProductCubit() : super(const ProductState.initial());

  @override
  Future<void> close() {
    _inventoryTimer?.cancel();
    return super.close();
  }

  /// Returns all products for use in favorites restoration.
  static List<Product> getAllProducts() => _initialProducts;

  // Mock Data - Shopcart Theme
  static const _initialProducts = [
    Product(
      id: '1',
      name: 'Pro Wireless Headset',
      price: '\$89.00',
      category: 'Headphone',
      rating: 4.8,
      reviewCount: 121,
      description:
          'Experience immersive sound with our Pro Wireless Headset. Designed for audiophiles, these headphones feature active noise cancellation to block out distractions and let you focus on what matters.',
      imageAsset: 'assets/images/headphones_green.png',
      gradientColors: [0xFFE0F2F1, 0xFFB2DFDB],
      availableColors: [0xFF2E7D32, 0xFF000000, 0xFFFFFFFF],
      features: [
        'Active Noise Cancellation',
        '30-Hour Battery Life',
        'Transparency Mode',
        'Spatial Audio Support',
      ],
      specs: {
        'Weight': '250g',
        'Connectivity': 'Bluetooth 5.2',
        'Battery': '30h Playback',
        'Driver': '40mm Dynamic',
      },
      stockCount: 15,
    ),
    Product(
      id: '2',
      name: 'Studio Max Noise Cancel',
      price: '\$559.00',
      category: 'Headphone',
      rating: 4.9,
      reviewCount: 450,
      description:
          'The ultimate listening experience. Studio Max combines high-fidelity audio with industry-leading noise cancellation. The breathable knit mesh canopy and memory foam ear cushions provide exceptional comfort.',
      imageAsset: 'assets/images/headphones_black.png',
      gradientColors: [0xFFECEFF1, 0xFFCFD8DC],
      availableColors: [0xFF212121, 0xFFCFD8DC, 0xFF5C6BC0],
      features: [
        'Digital Crown Control',
        'Adaptive EQ',
        'Personalized Spatial Audio',
        'MagSafe Charging Case',
      ],
      specs: {
        'Weight': '384g',
        'Connectivity': 'Bluetooth 5.0',
        'Battery': '20h Playback',
        'Driver': 'Apple H1 Chip',
      },
      stockCount: 5,
    ),
    Product(
      id: '3',
      name: 'Series 7 Smartwatch',
      price: '\$289.00',
      category: 'Wearable',
      rating: 4.6,
      reviewCount: 89,
      description:
          'Stay connected and active. The Series 7 features a larger, more advanced display, faster charging, and powerful health innovations like blood oxygen monitoring.',
      imageAsset: 'assets/images/smart_watch_blue.png',
      gradientColors: [0xFFE3F2FD, 0xFFBBDEFB],
      availableColors: [0xFF1565C0, 0xFF000000],
      features: [
        'Always-On Retina Display',
        'Blood Oxygen Sensor',
        'ECG App',
        'Swimproof (WR50)',
      ],
      specs: {
        'Case': '45mm Aluminum',
        'Display': 'OLED',
        'Battery': '18h All-Day',
        'Water Resistant': '50 meters',
      },
      stockCount: 22,
    ),
    Product(
      id: '4',
      name: 'Ultra Slim Laptop',
      price: '\$1299.00',
      category: 'Laptop',
      rating: 4.7,
      reviewCount: 200,
      description:
          'Power meets portability. The Ultra Slim Laptop features a stunning Retina display, all-day battery life, and the blazing fast M-Series chip for pro-level performance.',
      imageAsset: 'assets/images/laptop_silver.png',
      gradientColors: [0xFFF5F5F5, 0xFFEEEEEE],
      availableColors: [0xFFBDBDBD],
      features: [
        'M2 Chip Performance',
        'Liquid Retina XDR',
        '1080p FaceTime Camera',
        'Touch ID Magic Keyboard',
      ],
      specs: {
        'Processor': '8-Core CPU',
        'Memory': '16GB Unified',
        'Storage': '512GB SSD',
        'Weight': '1.24 kg',
      },
      stockCount: 8,
    ),
    Product(
      id: '5',
      name: 'VIVEFOX Headphones',
      price: '\$39.00',
      category: 'Headphone',
      rating: 4.2,
      reviewCount: 140,
      description: 'Reliable wired headset for daily commute.',
      imageAsset: 'assets/images/headphones_green.png', // Reuse
      gradientColors: [0xFFFFEBEE, 0xFFFFCDD2],
      availableColors: [0xFFD32F2F],
      features: [
        'Tangle-Free Cord',
        'Built-in Microphone',
        'Bass Boost',
        'Lightweight Design',
      ],
      specs: {
        'Type': 'Wired 3.5mm',
        'Cable Length': '1.2m',
        'Weight': '180g',
        'Driver': '32mm',
      },
      stockCount: 0, // Out of stock demo
    ),
    Product(
      id: '6',
      name: 'Smart Band 5',
      price: '\$49.00',
      category: 'Wearable',
      rating: 4.5,
      reviewCount: 304,
      description: 'Lightweight fitness tracker with OLED screen.',
      imageAsset: 'assets/images/smart_watch_blue.png', // Reuse
      gradientColors: [0xFFE0F7FA, 0xFF4DD0E1],
      availableColors: [0xFF00ACC1],
      features: [
        'Heart Rate Monitor',
        'Sleep Tracking',
        '14-Day Battery',
        'Music Control',
      ],
      specs: {
        'Display': '1.1" AMOLED',
        'Weight': '11.9g',
        'Water Resistant': '5 ATM',
        'Connectivity': 'Bluetooth 5.0',
      },
      stockCount: 50,
    ),
  ];

  Future<void> loadProducts() async {
    emit(const ProductState.loading());
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate API delay
    emit(
      const ProductState.loaded(
        products: _initialProducts,
        selectedCategory: 'All',
      ),
    );
    _startInventorySimulation();
  }

  void _startInventorySimulation() {
    _inventoryTimer?.cancel();
    _inventoryTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      state.maybeMap(
        loaded: (loadedState) {
          final updatedProducts = loadedState.products.map((p) {
            // Randomly decrease stock for some products to simulate real-time sales
            if (p.stockCount > 0 && p.id.hashCode % 3 == 0) {
              return p.copyWith(stockCount: p.stockCount - 1);
            }
            return p;
          }).toList();

          emit(loadedState.copyWith(products: updatedProducts));
        },
        orElse: () {},
      );
    });
  }

  void filterByCategory(String category) {
    // If the same category is clicked or "All" is selected
    if (category == 'All') {
      emit(
        ProductState.loaded(
          products: _initialProducts,
          selectedCategory: 'All',
        ),
      );
      return;
    }

    final filtered = _initialProducts
        .where((p) => p.category.toLowerCase() == category.toLowerCase())
        .toList();

    emit(ProductState.loaded(products: filtered, selectedCategory: category));
  }

  void searchProducts(String query) {
    state.maybeMap(
      loaded: (loadedState) {
        final category = loadedState.selectedCategory;

        // Start with all products or filtered by category
        List<Product> baseProducts = _initialProducts;
        if (category != 'All') {
          baseProducts = _initialProducts
              .where((p) => p.category.toLowerCase() == category.toLowerCase())
              .toList();
        }

        // Apply search filter
        if (query.isEmpty) {
          emit(
            ProductState.loaded(
              products: baseProducts,
              selectedCategory: category,
              searchQuery: '',
            ),
          );
          return;
        }

        final filtered = baseProducts.where((p) {
          final searchLower = query.toLowerCase();
          return p.name.toLowerCase().contains(searchLower) ||
              p.description.toLowerCase().contains(searchLower) ||
              p.category.toLowerCase().contains(searchLower);
        }).toList();

        emit(
          ProductState.loaded(
            products: filtered,
            selectedCategory: category,
            searchQuery: query,
          ),
        );
      },
      orElse: () {},
    );
  }
}
