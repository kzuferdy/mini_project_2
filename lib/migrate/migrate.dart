// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../model/cart_model.dart';


// class CartMigrationService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String apiUrl = 'https://fakestoreapi.com/carts'; // URL API cart

//   Future<void> migrateCartData() async {
//     try {
//       // Ambil data dari API
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         // Parse response
//         final List<dynamic> cartListJson = json.decode(response.body);

//         // Referensi ke koleksi cart di Firestore
//         CollectionReference cartsCollection = _firestore.collection('carts');

//         // Hapus koleksi yang ada (Opsional, jika kamu ingin memulai dengan data bersih)
//         // await cartsCollection.get().then((snapshot) {
//         //   for (var doc in snapshot.docs) {
//         //     doc.reference.delete();
//         //   }
//         // });

//         // Tambahkan data cart ke Firestore
//         for (var cartJson in cartListJson) {
//           final cart = Cart.fromJson(cartJson);

//           await cartsCollection.doc(cart.id.toString()).set({
//             'id': cart.id.toString(),  // Konversi ID ke string
//             'userId': cart.userId,
//             'date': cart.date.toIso8601String(),
//             'products': cart.items.map((item) => item.toJson()).toList(),
//             '__v': cart.v,
//           });
//         }

//         print("Cart data berhasil dipindahkan ke Firestore.");
//       } else {
//         throw Exception('Gagal mengambil data cart dari API');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }