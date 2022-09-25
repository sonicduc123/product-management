import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/manage_product/manage_product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState(ProductModel(file: []))) {
    on<CreateProductEvent>((event, emit) async {
      ProductModel product = ProductModel(
        name: event.name,
        description: event.description,
        number: event.number,
        image: [],
        file: state.product.file,
      );
      product = await ProductRepository.createProduct(product);

      emit(ProductState(product));
    });

    on<UpdateProductEvent>(
      (event, emit) async {
        ProductModel product = ProductModel(
          id: event.id,
          name: event.name,
          description: event.description,
          number: event.number,
          image: event.image,
          file: state.product.file,
        );

        await ProductRepository.updateProduct(product);
        emit(ProductState(product));
      },
    );

    on<DeleteProductEvent>(
      (event, emit) async {
        await ProductRepository.deleteProduct(
            event.productId, event.numberImage);
      },
    );

    on<PickImageEvent>((event, emit) async {
      state.product.file.add(event.file);
      emit(ProductState(state.product));
    });
  }
}
