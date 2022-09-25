import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/manage_product/manage_product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key, required this.product, required this.readOnly}) : super(key: key);

  final ProductModel product;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: ProductLayout(
        product: product,
        readOnly: readOnly,
      ),
    );
  }
}
