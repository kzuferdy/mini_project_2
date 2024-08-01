import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_2/logic/cart/cart_bloc.dart';
import 'package:mini_project_2/logic/cart/cart_event.dart';
import 'package:mini_project_2/logic/cart/cart_state.dart';
import 'package:mini_project_2/services/services.dart';

class CartDetailPage extends StatelessWidget {
  final String cartId;

  const CartDetailPage({Key? key, required this.cartId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Keranjang'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => CartBloc(CartService())..add(LoadCart(cartId)),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              return ListView.builder(
                itemCount: state.cart.products.length,
                itemBuilder: (context, index) {
                  final item = state.cart.products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: Icon(Icons.shopping_bag, color: Colors.green),
                      title: Text('Product ID: ${item.productId}', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Quantity: ${item.quantity}'),
                    ),
                  );
                },
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
