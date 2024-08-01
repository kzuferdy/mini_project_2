import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:mini_project_2/model/profile_model.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';


class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchProducts() async {
    try {
      // Mengambil data dari koleksi 'products' di Firestore
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      List<Product> products = snapshot.docs
          .map((doc) {
            print('Document Data: ${doc.data()}'); // Tambahkan logging
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            print('Document ID: ${data['id']}'); // Tambahkan logging
            return Product.fromJson(data);
          })
          .toList();
      return products;
    } catch (e) {
      print('Error: ${e.toString()}'); // Tambahkan logging
      throw Exception('Failed to load products: ${e.toString()}');
    }
  }
}

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Cart> getCart(String cartId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('carts').doc(cartId).get();
      return Cart.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to load cart: $e');
    }
  }

  Future<List<Cart>> getAllCarts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('carts').get();
      return snapshot.docs.map((doc) => Cart.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to load carts: $e');
    }
  }
}

class ProfileService {
  final FirebaseFirestore _firestore;

  ProfileService(this._firestore);

  Future<void> createUser(String userId, String firstName, String lastName) async {
    await _firestore.collection('users').doc(userId).set({
      'name': {
        'firstName': firstName,
        'lastName': lastName,
      },
      'imageUrl': '', // Initialize with an empty string or a default URL
    });
  }

  Future<void> updateProfileImage(String userId, String imageUrl) async {
    await _firestore.collection('users').doc(userId).update({
      'imageUrl': imageUrl,
    });
  }

  Future<void> updateProfileName(String userId, String newName) async {
    final names = newName.split(' ');
    await _firestore.collection('users').doc(userId).update({
      'name': {
        'firstName': names[0],
        'lastName': names.length > 1 ? names[1] : '',
      },
    });
  }

  Future<Map<String, dynamic>> getProfile(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data() ?? {};
  }
}
