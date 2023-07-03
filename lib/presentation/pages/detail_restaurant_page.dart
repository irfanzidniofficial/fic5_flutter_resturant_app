// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic5_flutter_restaurant_app/bloc/detail_product/detail_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../bloc/bloc/gmap_bloc.dart';

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
    context.read<GmapBloc>().add(const GmapEvent.getCurrentLocation());
    super.initState();
  }

  final Set<Marker> markers = {};

  LatLng? position;

  void createMarker(double lat, double lng, String address) {
    final marker = Marker(
        markerId: const MarkerId('currentPosition'),
        infoWindow: InfoWindow(title: address),
        position: LatLng(lat, lng));

    markers.add(marker);
  }

  Future<bool> _getPermission(Location location) async {
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  LatLng? positionDestination;

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
                final lat = double.parse(model.data.attributes.latitude);
                final lng = double.parse(model.data.attributes.longitude);
                positionDestination = LatLng(lat, lng);
                print('latlng: $lat, $lng');
                position = LatLng(lat, lng);
                createMarker(lat, lng, model.data.attributes.address);
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
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        markers: markers,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            lat,
                            lng,
                          ),
                          zoom: 15,
                        ),
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
