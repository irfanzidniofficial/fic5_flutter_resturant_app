// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../data/models/responses/add_product_response_model.dart';

class RestaurantCardWidget extends StatelessWidget {
  const RestaurantCardWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Restaurant data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data.attributes.name),
        subtitle: Text(data.attributes.description),
        leading: CircleAvatar(
          radius: 16,
          child: Image.network(
            data.attributes.photo ?? 'https://picsum.photos/200/300',
          ),
        ),
      ),
    );
  }
}
