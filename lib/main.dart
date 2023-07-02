import 'package:fic5_flutter_restaurant_app/bloc/detail_product/detail_product_bloc.dart';
import 'package:fic5_flutter_restaurant_app/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:fic5_flutter_restaurant_app/data/local_datasources/auth_local_datasource.dart';
import 'package:fic5_flutter_restaurant_app/data/remote_datasources/restaurant_datasource.dart';
import 'package:fic5_flutter_restaurant_app/presentation/pages/detail_restaurant_page.dart';

import 'package:fic5_flutter_restaurant_app/presentation/pages/home_page.dart';
import 'package:fic5_flutter_restaurant_app/presentation/pages/login_page.dart';
import 'package:fic5_flutter_restaurant_app/presentation/pages/my_restaurant_page.dart';
import 'package:fic5_flutter_restaurant_app/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetAllProductBloc(
            RestaurantDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => DetailProductBloc(RestaurantDatasource()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: GoRouter(
          initialLocation: HomePage.routeName,
          routes: [
            GoRoute(
              path: LoginPage.routeName,
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              path: RegisterPage.routeName,
              builder: (context, state) => const RegisterPage(),
            ),
            GoRoute(
              path: HomePage.routeName,
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: MyRestaurantPage.routeName,
              builder: (context, state) => const MyRestaurantPage(),
              redirect: (context, state) async {
                final isLogin = await AuthLocalDatasource().isLogin();
                if (isLogin) {
                  return null;
                } else {
                  return LoginPage.routeName;
                }
              },
            ),
            GoRoute(
              path: '${DetailRestaurantPage.routeName}/:restaurantId',
              builder: (context, state) => DetailRestaurantPage(
                id: int.parse(state.pathParameters['restaurantId']!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
