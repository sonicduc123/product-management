import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/home/home.dart';
import 'package:management_product/features/manage_product/models/product_model.dart';
import 'package:management_product/features/manage_product/screens/product_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadUserEvent());
    context.read<HomeBloc>().add(LoadProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home page'),
          ),
          body: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Hello, ${state.user.role}',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Expanded(child: HomeListProduct()),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Sign out'),
                    ),
                  ],
                ),
          floatingActionButton: state.user.role == "manager"
              ? FloatingActionButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          product: ProductModel(file: []),
                          readOnly: false,
                        ),
                      ),
                    );
                    if (result != null) {
                      context.read<HomeBloc>().add(AddProductEvent(result));
                    }
                  },
                  child: const Icon(Icons.add),
                )
              : const SizedBox(),
        );
      },
    );
  }
}
