import 'package:management_product/features/manage_product/models/product_model.dart';

abstract class HomeEvent {}

class LoadUserEvent extends HomeEvent {
  LoadUserEvent();
}

class LoadProductEvent extends HomeEvent {
  LoadProductEvent();
}

class AddProductEvent extends HomeEvent {
  AddProductEvent(this.product);

  ProductModel product;
}

class HomeRemoveProductEvent extends HomeEvent {
  HomeRemoveProductEvent(this.index);

  int index;
}

class HomeEditProductEvent extends HomeEvent {
  HomeEditProductEvent(this.index, this.product);

  int index;
  ProductModel product;
}
