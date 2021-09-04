import 'package:shelter/models/foodmodel.dart';

class OrderModel {
  List<ItemsModel>? orders = [];
  List<int>? qunitity = [];
  String? email;
  double? total;
  double? subtotal;
  int? tax;
  String? uid;
  String? adress;
  String? phone;
  String? date;
  bool? isconfirmed;
  bool? onway;
  bool? deliverd;
  OrderModel(
      {this.adress,
      this.deliverd,
      this.date,
      this.email,
      this.qunitity,
      this.orders,
      this.phone,
      this.uid,
      this.subtotal,
      this.tax,
      this.total,
      this.isconfirmed,
      this.onway});
  OrderModel.fromJson(Map<String, dynamic> json) {
    orders = json["orders"];
    email = json["email"];
    uid = json["uid"];
    isconfirmed = json["isconfirmed"];
    adress = json["adress"];
    phone = json["phone"];
    deliverd = json["deliverd"];
    onway = json["onway"];
    subtotal = json["subtotal"];
    tax = json["tax"];
    total = json["total"];
  }
}
