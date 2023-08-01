import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/add_product/add_product_bloc.dart';
import '../../bloc/get_all_product/get_all_product_bloc.dart';
import '../../data/local_datasources/auth_local_datasource.dart';
import '../../data/models/requests/add_product_request_model.dart';

class AddRestaurantPage extends StatefulWidget {
  static const routeName = '/add-restaurant';
  const AddRestaurantPage({super.key});

  @override
  State<AddRestaurantPage> createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {
  TextEditingController? nameController;
  TextEditingController? descriptionController;
  TextEditingController? addressController;

  XFile? picture;

  List<XFile>? multiplePicture;

  void takePicture(XFile file) {
    picture = file;
    setState(() {});
  }

  void takeMultiplePicture(List<XFile> files) {
    multiplePicture = files;
    setState(() {});
  }

  @override
  void initState() {
    nameController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      picture = photo;
      setState(() {});
    }
  }

  Future<void> getMultipleImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> photo = await picker.pickMultiImage();

    multiplePicture = photo;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Restaurant"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            // picture != null
            //     ? SizedBox(
            //         height: 200,
            //         width: 200,
            //         child: Image.file(File(picture!.path)))
            //     : Container(
            //         height: 200,
            //         width: 200,
            //         decoration: BoxDecoration(border: Border.all()),
            //       ),
            // const SizedBox(
            //   height: 8,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(),
            //       onPressed: () {
            //         getImage(ImageSource.gallery);
            //         // getMultipleImage();
            //       },
            //       child: const Text(
            //         "Galery",
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
              maxLines: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            BlocListener<AddProductBloc, AddProductState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (data) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Error: $data')));
                  },
                  success: (model) {
                    context
                        .read<GetAllProductBloc>()
                        .add(const GetAllProductEvent.getByUserId());
                    context.pop();
                  },
                );
              },
              child: BlocBuilder<AddProductBloc, AddProductState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () async {
                          final userId =
                              await AuthLocalDatasource().getUserId();
                          final model = AddProductRequestModel(
                              data: Data(
                            name: nameController!.text,
                            description: descriptionController!.text,
                            latitude: '0',
                            longitude: '0',
                            photo: 'https://picsum.photos/200/300',
                            address: addressController!.text,
                            userId: userId,
                          ));
                          context
                              .read<AddProductBloc>()
                              .add(AddProductEvent.add(model, picture!));
                        },
                        style: ElevatedButton.styleFrom(),
                        child: const Text('Submit'),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
