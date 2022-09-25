import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/manage_product/manage_product.dart';

class ProductLayout extends StatefulWidget {
  const ProductLayout({Key? key, required this.product, required this.readOnly})
      : super(key: key);

  final ProductModel product;
  final bool readOnly;

  @override
  State<ProductLayout> createState() => _ProductLayoutState();
}

class _ProductLayoutState extends State<ProductLayout> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.product.name ?? '';
    descriptionController.text = widget.product.description ?? '';
    numberController.text =
        widget.product.number != null ? widget.product.number.toString() : '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
      if (state.product.id != null) {
        Navigator.pop(context, state.product);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Success'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Product')),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  readOnly: widget.readOnly,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  readOnly: widget.readOnly,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: numberController,
                  decoration: const InputDecoration(
                    label: Text('Number'),
                  ),
                  keyboardType: TextInputType.number,
                  readOnly: widget.readOnly,
                ),
                const SizedBox(height: 10),
                ProductImagePicker(
                  imageUrl: widget.product.image,
                  readOnly: widget.readOnly,
                ),
                const SizedBox(height: 10),
                if (!widget.readOnly)
                  ElevatedButton(
                    onPressed: () {
                      widget.product.id != null
                          ? context.read<ProductBloc>().add(
                                UpdateProductEvent(
                                    widget.product.id!,
                                    nameController.text,
                                    descriptionController.text,
                                    int.parse(numberController.text),
                                    context,
                                    widget.product.image),
                              )
                          : context.read<ProductBloc>().add(
                                CreateProductEvent(
                                  nameController.text,
                                  descriptionController.text,
                                  int.parse(numberController.text),
                                  context,
                                ),
                              );
                    },
                    child: const Text('Save'),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
