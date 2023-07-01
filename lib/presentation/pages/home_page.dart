import 'package:fic5_flutter_restaurant_app/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:fic5_flutter_restaurant_app/presentation/pages/my_restaurant_page.dart';
import 'package:fic5_flutter_restaurant_app/presentation/widgets/restaurant_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<GetAllProductBloc>().add(const GetAllProductEvent.get());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Restaurant",
        ),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (value) {
          if (value == 1) {
            context.push(MyRestaurantPage.routeName);
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
