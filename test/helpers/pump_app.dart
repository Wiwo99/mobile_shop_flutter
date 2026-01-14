import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_shop_flutter/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:mobile_shop_flutter/features/home/presentation/cubit/product_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockProductCubit extends Mock implements ProductCubit {}

class MockCartCubit extends Mock implements CartCubit {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    ProductCubit? productCubit,
    CartCubit? cartCubit,
    GoRouter? router,
  }) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: productCubit ?? MockProductCubit()),
          BlocProvider.value(value: cartCubit ?? MockCartCubit()),
        ],
        child: MaterialApp(
          // Use MaterialApp instead of Router for simple widget tests unless router is needed
          home: router == null ? widget : null,
          builder: router != null
              ? (context, child) => MaterialApp.router(routerConfig: router)
              : null,
        ),
      ),
    );
  }

  Future<void> pumpRouterApp(
    GoRouter router, {
    ProductCubit? productCubit,
    CartCubit? cartCubit,
  }) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: productCubit ?? MockProductCubit()),
          BlocProvider.value(value: cartCubit ?? MockCartCubit()),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
  }
}
