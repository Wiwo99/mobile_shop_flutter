import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_shop_flutter/features/cart/presentation/cart_screen.dart';
import 'package:mobile_shop_flutter/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:mobile_shop_flutter/features/cart/domain/cart_item.dart';
import 'package:mobile_shop_flutter/features/home/domain/product.dart';
import 'package:go_router/go_router.dart';
import '../../helpers/mock_asset_bundle.dart';

void main() {
  group('CartScreen Integration Test', () {
    late CartCubit cartCubit;

    setUp(() {
      cartCubit = CartCubit();
    });

    tearDown(() {
      cartCubit.close();
    });

    testWidgets('shows empty cart message initially', (tester) async {
      await tester.pumpWidget(
        BlocProvider.value(
          value: cartCubit,
          child: DefaultAssetBundle(
            bundle: MockAssetBundle(),
            child: const MaterialApp(home: CartScreen()),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('shows items when cart is not empty', (tester) async {
      final product = Product(
        id: '1',
        name: 'Headphone',
        price: '\$50',
        imageAsset: 'assets/images/headphone.png', // Mock
        description: 'Desc',
        rating: 4.5,
        reviewCount: 10,
        gradientColors: [0xFF000000],
        features: [],
        specs: {},
        availableColors: [0xFF000000],
        category: 'Headphone',
      );

      final item = CartItem(product: product, quantity: 2, color: 0xFF000000);

      cartCubit.addToCart(item);

      await tester.pumpWidget(
        BlocProvider.value(
          value: cartCubit,
          child: DefaultAssetBundle(
            bundle: MockAssetBundle(),
            child: const MaterialApp(home: CartScreen()),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Headphone'), findsOneWidget);
      expect(find.text('x2'), findsOneWidget); // Checks quantity display
      expect(find.text('\$100.00'), findsOneWidget); // Total Amount
    });

    testWidgets('checkout clears cart', (tester) async {
      final product = Product(
        id: '1',
        name: 'Headphone',
        price: '\$50',
        imageAsset: 'assets/images/headphone.png', // Mock
        description: 'Desc',
        rating: 4.5,
        reviewCount: 10,
        gradientColors: [0xFF000000],
        features: [],
        specs: {},
        availableColors: [0xFF000000],
        category: 'Headphone',
      );
      final item = CartItem(product: product, quantity: 1, color: 0xFF000000);
      cartCubit.addToCart(item);

      final router = GoRouter(
        initialLocation: '/cart',
        routes: [
          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(body: Text('Home')),
          ),
        ],
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: cartCubit,
          child: DefaultAssetBundle(
            bundle: MockAssetBundle(),
            child: MaterialApp.router(routerConfig: router),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find checkout button
      final checkoutBtn = find.text('Checkout');
      await tester.tap(checkoutBtn);
      await tester.pumpAndSettle();

      // Dialog appears
      expect(find.text('Payment Successful!'), findsOneWidget);

      // Tap Close/Done
      await tester.tap(find.text('Continue Shopping'));
      await tester.pumpAndSettle();

      // Should be at Home
      expect(find.text('Home'), findsOneWidget);

      // Use dynamic access to bypass potential analyzer issues with freezed mixin visibility in tests
      final dynamic state = cartCubit.state;
      // We expect Loaded state, which has 'items'
      expect((state.items as List).isEmpty, isTrue);
    });
  });
}
