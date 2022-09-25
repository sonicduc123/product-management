import 'dart:io';

class ProductModel {
  String? id;
  String? name;
  List<String>? image;
  String? description;
  int? number;
  List<File> file = [];

  ProductModel({this.id, this.name, this.image, this.description, this.number, required this.file});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['image'] != null && json['image'] is! String) {
      image = json['image'].cast<String>();
    }
    description = json['description'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['number'] = number;
    return data;
  }
}
