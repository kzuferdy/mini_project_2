import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cart/cart_bloc.dart';
import '../../model/product_model.dart'; // Pastikan path-nya sesuai

class CartDetailPage extends StatelessWidget {
  const CartDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final products = state.products; // Mendapatkan daftar produk
            return ListView.builder(
              itemCount: state.cart.items.length,
              itemBuilder: (context, index) {
                final cartItem = state.cart.items[index];
                final product = products.firstWhere(
                  (product) => product.id == cartItem.productId,
                  orElse: () => Product(id: 0, title: 'Unknown', price: 0.0, image: '', description: '', category: ''),
                );
                return ListTile(
                  leading: Image.network(product.image),
                  title: Text(product.title),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: Text('\$${product.price * cartItem.quantity}'),
                );
              },
            );
          } else {
            return Center(child: Text('Cart is empty'));
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${_calculateTotalPrice(context)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement checkout logic here
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateTotalPrice(BuildContext context) {
    final state = context.read<CartBloc>().state;
    if (state is CartLoaded) {
      return state.cart.items.fold(0.0, (total, cartItem) {
        final product = state.products.firstWhere(
          (product) => product.id == cartItem.productId,
          orElse: () => Product(id: 0, title: 'Unknown', price: 0.0, image: '', description: '', category: ''),
        );
        return total + (product.price * cartItem.quantity);
      });
    }
    return 0.0;
  }
}
