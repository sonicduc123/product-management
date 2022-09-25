import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/home/home.dart';

class HomeListProduct extends StatelessWidget {
  const HomeListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('List products: '),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: List.generate(
                state.listProduct.length,
                (index) => HomeProductItem(index: index),
              ),
            ),
          )
        ],
      );
    });
  }
}
