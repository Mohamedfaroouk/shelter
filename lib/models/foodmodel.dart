class FoodModel {
  Map<String, dynamic> allfood = {};
  List keys = [];
  FoodData? food;
  FoodModel.fromJson(Json) {
    Json.forEach((elemnt) {
      keys.add(elemnt.keys.first);

      allfood[keys.last] = elemnt.values.first;
    });
  }
}

class FoodData {
  List<ItemsModel> pasta = [];
  List<ItemsModel> tasa = [];
  List<ItemsModel> meals = [];
  List<ItemsModel> cickSandwich = [];
  List<ItemsModel> beafSandwich = [];

  FoodData.fromJson(Json) {
    Json["Pasta"].forEach((elemnt) {
      pasta.add(ItemsModel.fromJson(elemnt));
    });
    Json["Meals"].forEach((elemnt) {
      meals.add(ItemsModel.fromJson(elemnt));
    });
    Json["Chease Tasa"].forEach((elemnt) {
      tasa.add(ItemsModel.fromJson(elemnt));
    });
    Json["Beaf Sandwich"].forEach((elemnt) {
      cickSandwich.add(ItemsModel.fromJson(elemnt));
    });
    Json["Chicken Sandwich"].forEach((elemnt) {
      beafSandwich.add(ItemsModel.fromJson(elemnt));
    });
  }
}

class ItemsModel {
  String? name;
  String? type;
  String? cont;
  dynamic price;
  bool? incart;

  ItemsModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    type = json["type"];
    cont = json["cont"];
    price = json["price"];
    incart = false;
  }
}
