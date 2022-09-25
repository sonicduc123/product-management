import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/home/bloc/home_bloc.dart';
import 'package:management_product/features/home/screens/home_layout.dart';
import 'package:management_product/features/manage_product/blocs/product_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ProductBloc())
      ],
      child: const HomeLayout(),
    );
  }
}
