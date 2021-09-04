class UserModel {
  String? name;
  String? email;
  String? uid;
  int? id;
  String? adress;
  String? phone;
  List? incart;
  UserModel(
      {this.adress,
      this.id,
      this.incart,
      this.email,
      this.name,
      this.phone,
      this.uid});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    uid = json["uid"];
    id = json["id"];
    adress = json["adress"];
    phone = json["phone"];
    incart = json["incart"];
  }
}
