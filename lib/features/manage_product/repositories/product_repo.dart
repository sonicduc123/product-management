import 'package:management_product/features/manage_product/models/product_model.dart';
import 'package:management_product/features/manage_product/services/product_service.dart';

class ProductRepository {
  static createProduct(ProductModel product) =>
      ProductService.createProduct(product);

  static updateProduct(ProductModel newProduct) =>
      ProductService.updateProduct(newProduct);

  static deleteProduct(String productId, int numberImage) =>
      ProductService.deleteProduct(productId, numberImage);
}
