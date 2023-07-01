import 'package:flutter/material.dart';

class MyRestaurantPage extends StatefulWidget {
  static const routeName = '/my-restaurant';
  const MyRestaurantPage({super.key});

  @override
  State<MyRestaurantPage> createState() => _MyRestaurantPageState();
}

class _MyRestaurantPageState extends State<MyRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          children: const [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("Home Page"),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
