import 'package:management_product/features/manage_product/models/product_model.dart';
import 'package:management_product/features/home/models/user_model.dart';

class HomeState {
  HomeState(this.user, this.isLoading, this.listProduct);
  UserModel user;
  bool isLoading;
  List<ProductModel> listProduct;
}
