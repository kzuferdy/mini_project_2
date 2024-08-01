import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  final String id;
  final int version;
  final DateTime date;
  final List<CartItem> products;
  final int userId;

  Cart({
    required this.id,
    required this.version,
    required this.date,
    required this.products,
    required this.userId,
  });

  factory Cart.fromMap(Map<String, dynamic> data) {
    return Cart(
      id: data['id'] as String? ?? '', // Pastikan nilai default jika null
      version: data['__v'] as int? ?? 0,
      date: data['date'] != null ? DateTime.parse(data['date']) : DateTime.now(),
      products: (data['products'] as List<dynamic>?)
              ?.map((item) => CartItem.fromMap(item as Map<String, dynamic>))
              .toList() ?? [],
      userId: data['userId'] as int? ?? 0,
    );
  }

  factory Cart.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw StateError('Missing data for cart');
    }
    return Cart.fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      '__v': version,
      'date': date.toIso8601String(),
      'products': products.map((item) => item.toMap()).toList(),
      'userId': userId,
    };
  }
}

class CartItem {
  final int productId;
  final int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'] as int? ?? 0,
      quantity: map['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}