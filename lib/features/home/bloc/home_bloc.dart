import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/home/home.dart';
import 'package:management_product/features/manage_product/models/product_model.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(UserModel(), true, [])) {
    on<LoadUserEvent>((event, emit) async {
      UserModel user = await HomeRepository.getUserInformation();

      if (user.name != null) {
        emit(HomeState(user, false, state.listProduct));
      }
    });

    on<LoadProductEvent>((event, emit) async {
      List<ProductModel> listProduct = await HomeRepository.getListProduct();

      log(listProduct.length.toString());

      if (listProduct.isNotEmpty) {
        emit(HomeState(state.user, state.isLoading, listProduct));
      }
    });

    on<AddProductEvent>(
      (event, emit) async {
        state.listProduct.add(event.product);
        emit(HomeState(state.user, state.isLoading, state.listProduct));
      },
    );

    on<HomeRemoveProductEvent>((event, emit) {
      state.listProduct.removeAt(event.index);
      emit(HomeState(state.user, state.isLoading, state.listProduct));
    });

    on<HomeEditProductEvent>((event, emit) {
      state.listProduct[event.index] = event.product;
      emit(HomeState(state.user, state.isLoading, state.listProduct));
    });
  }
}
