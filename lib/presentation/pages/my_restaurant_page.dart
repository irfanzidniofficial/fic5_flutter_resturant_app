import 'package:fic5_flutter_restaurant_app/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:fic5_flutter_restaurant_app/data/local_datasources/auth_local_datasource.dart';
import 'package:fic5_flutter_restaurant_app/presentation/pages/home_page.dart';
import 'package:fic5_flutter_restaurant_app/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/restaurant_card_widget.dart';

class MyRestaurantPage extends StatefulWidget {
  static const routeName = '/my-restaurant';
  const MyRestaurantPage({super.key});

  @override
  State<MyRestaurantPage> createState() => _MyRestaurantPageState();
}

class _MyRestaurantPageState extends State<MyRestaurantPage> {
  @override
  void initState() {
    context
        .read<GetAllProductBloc>()
        .add(const GetAllProductEvent.getByUserId());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Restuarant",
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthLocalDatasource().removeAuthData();
              context.go(LoginPage.routeName);
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
            builder: (context, state) {
              debugPrint("Get All Product");
              return state.when(
                initial: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: () => const Text(
                  "ERROR",
                ),
                success: (data) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return RestaurantCardWidget(
                        data: data.data[index],
                      );
                    },
                    itemCount: data.data.length,
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (value) {
          if (value == 0) {
            context.push(HomePage.routeName);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.restaurant,
            ),
            label: "All Restaurant",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "My Account",
          ),
        ],
      ),
    );
  }
}
