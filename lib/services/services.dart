import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/cart_model.dart';
import '../model/product_model.dart';


class ProductService {
  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  final String url = 'https://fakestoreapi.com';
  Future<Cart> fetchCart() async {
    final response = await http.get(Uri.parse('$url/carts/1'));
    if (response.statusCode == 200) {
      return Cart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cart');
    }
  }
}
class ProfileService {
  final http.Client client;
  final String profileUrl = 'https://fakestoreapi.com/users/1';

  ProfileService(this.client);

  Future<String> fetchProfile() async {
    try {
      final response = await client.get(Uri.parse(profileUrl));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }
}