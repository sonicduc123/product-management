import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class ProductEvent {}

class CreateProductEvent extends ProductEvent {
  CreateProductEvent(this.name, this.description, this.number, this.context);

  String name;
  String description;
  int number;
  BuildContext context;
}

class UpdateProductEvent extends ProductEvent {
  UpdateProductEvent(this.id, this.name, this.description, this.number,
      this.context, this.image);

  String id;
  String name;
  String description;
  int number;
  List<String>? image;
  BuildContext context;
}

class DeleteProductEvent extends ProductEvent {
  DeleteProductEvent(this.productId, this.numberImage);

  String productId;
  int numberImage;
}

class PickImageEvent extends ProductEvent {
  PickImageEvent(this.file);

  File file;
}
