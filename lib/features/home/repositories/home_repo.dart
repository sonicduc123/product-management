import 'package:management_product/features/manage_product/models/product_model.dart';
import 'package:management_product/features/home/models/user_model.dart';
import 'package:management_product/features/home/services/home_service.dart';

class HomeRepository {
  static Future<UserModel> getUserInformation() =>
      HomeService.getUserInformation();

  static Future<List<ProductModel>> getListProduct() =>
      HomeService.getListProduct();
}
