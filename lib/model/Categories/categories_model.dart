class CategoriesModel {
  bool? status;
  String? message;
  Data? data;

  CategoriesModel({this.status, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {

  List<MyData>? myData;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      myData = <MyData>[];
      json['data'].forEach((v) {
        myData!.add(MyData.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class MyData {
  int? id;
  String? name;
  String? image;

  MyData({this.id, this.name, this.image});

  MyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}