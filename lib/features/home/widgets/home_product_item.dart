import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/home/home.dart';
import 'package:management_product/features/manage_product/manage_product.dart';

class HomeProductItem extends StatelessWidget {
  const HomeProductItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  state.listProduct[index].image != null &&
                          state.listProduct[index].image!.isNotEmpty
                      ? Image.network(
                          state.listProduct[index].image![0],
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.network(
                            'https://inboundmarketing.vn/wp-content/uploads/2020/06/khai-niem-ve-san-pham-product-va-nhung-cach-phan-loai-chung.jpg',
                            width: 100,
                            height: 100,
                          ),
                        )
                      : Image.network(
                          'https://inboundmarketing.vn/wp-content/uploads/2020/06/khai-niem-ve-san-pham-product-va-nhung-cach-phan-loai-chung.jpg',
                          width: 100,
                          height: 100,
                        ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.listProduct[index].name}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${state.listProduct[index].description}'),
                      Text('Number: ${state.listProduct[index].number}'),
                    ],
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              if (state.user.role == "manager")
                BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, stateProduct) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          ProductModel? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                product: state.listProduct[index],
                                readOnly: false,
                              ),
                            ),
                          );
                          if (result != null) {
                            context
                                .read<HomeBloc>()
                                .add(HomeEditProductEvent(index, result));
                          }
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          String? choice = await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  'Do you want to delete this product?'),
                              content: const Text('This action can not undo!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Delete'),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                          if (choice == 'Delete') {
                            context.read<ProductBloc>().add(
                                  DeleteProductEvent(
                                      state.listProduct[index].id!,
                                      state.listProduct[index].image!.length),
                                );
                            context
                                .read<HomeBloc>()
                                .add(HomeRemoveProductEvent(index));
                          }
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                })
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(
                product: state.listProduct[index],
                readOnly: state.user.role == "customer",
              ),
            ),
          );
        },
      );
    });
  }
}
