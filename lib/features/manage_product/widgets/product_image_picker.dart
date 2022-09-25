import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:management_product/features/manage_product/manage_product.dart';

class ProductImagePicker extends StatefulWidget {
  const ProductImagePicker(
      {Key? key, required this.imageUrl, required this.readOnly})
      : super(key: key);

  final List<String>? imageUrl;
  final bool readOnly;

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<File?> listPhoto = [];
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Image'),
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
              return !widget.readOnly
                  ? Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.image,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            List<XFile>? images =
                                await _picker.pickMultiImage();

                            setState(() {
                              if (images != null) {
                                for (int i = 0; i < images.length; i++) {
                                  File photo = File(images[i].path);
                                  listPhoto.add(photo);
                                  context
                                      .read<ProductBloc>()
                                      .add(PickImageEvent(photo));
                                }
                              } else {
                                log('No image selected.');
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            final pickedFile = await _picker.pickImage(
                                source: ImageSource.camera);

                            setState(() {
                              if (pickedFile != null) {
                                File photo = File(pickedFile.path);
                                listPhoto.add(photo);
                                context
                                    .read<ProductBloc>()
                                    .add(PickImageEvent(photo));
                                //uploadFile();
                              } else {
                                log('No image selected.');
                              }
                            });
                          },
                        ),
                      ],
                    )
                  : const SizedBox();
            }),
          ],
        ),
        const SizedBox(height: 10),
        if (listPhoto.isNotEmpty)
          Wrap(
            children: List.generate(
              listPhoto.length,
              (index) => Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 18),
                    child: Image.file(
                      listPhoto[index]!,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  if (!widget.readOnly)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          listPhoto.removeAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.dangerous_rounded,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
        if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
          Wrap(
            children: List.generate(
              widget.imageUrl!.length,
              (index) => Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 18),
                    child: Image.network(
                      widget.imageUrl![index],
                      height: 100,
                      width: 100,
                    ),
                  ),
                  if (!widget.readOnly)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.imageUrl!.removeAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.dangerous_rounded,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
        if (listPhoto.isEmpty &&
            (widget.imageUrl == null || widget.imageUrl!.isEmpty))
          const Center(
            child: Text(
              'There is no image',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
      ],
    );
  }
}
