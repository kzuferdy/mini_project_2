import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  int id;
  int userId;
  DateTime date;
  List<CartItem> items;
  int v;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.items,
    required this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        items: List<CartItem>.from(
            json["products"].map((x) => CartItem.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(items.map((x) => x.toJson())),
        "__v": v,
      };
}

class CartItem {
  int productId;
  int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}
