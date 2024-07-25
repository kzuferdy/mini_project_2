import 'package:flutter/material.dart';
import '../../model/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.network(product.image),
          const SizedBox(height: 6),
          Text(
            product.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${product.price}',
            style: const TextStyle(fontSize: 20, color: Colors.green),
          ),
          const SizedBox(height: 16),
          Text(
            product.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16), // Tambahkan jarak sebelum tombol
          ElevatedButton(
            onPressed: () {
              // Tambahkan logika untuk menambahkan produk ke keranjang
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}