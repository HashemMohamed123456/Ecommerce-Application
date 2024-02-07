import '../Home Model/home_model.dart';

class CategoryProductsDetails {
  bool? status;
  String? message;
  Data? data;

  CategoryProductsDetails({this.status, this.message, this.data});

  CategoryProductsDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}
class Data {
List<Products>?products;
  Data.fromJson(Map<String, dynamic> json) {
      if (json['data'] != null) {
        products = <Products>[];
        json['data'].forEach((v) {
          products!.add(Products.fromJson(v));
        });
      }
}


}