// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic5_flutter_restaurant_app/bloc/detail_product/detail_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/detail';

  const DetailRestaurantPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  @override
  void initState() {
    context.read<DetailProductBloc>().add(
          DetailProductEvent.get(widget.id),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Restaurant",
        ),
      ),
      body: BlocBuilder<DetailProductBloc, DetailProductState>(
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => const Text("No Detail"),
              success: (model) {
                return ListView(
                  children: [
                    Image.network(
                      model.data.attributes.photo!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      model.data.attributes.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      model.data.attributes.address,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
