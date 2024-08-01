import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_2/logic/cart/cart_bloc.dart';
import 'package:mini_project_2/logic/cart/cart_event.dart';
import 'package:mini_project_2/logic/cart/cart_state.dart';
import 'package:mini_project_2/services/services.dart';

import 'cart_detail.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String filter = '';

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CartBloc(CartService())..add(LoadAllCarts()),
        child: Column(
          children: [
            Container(
              color: Colors.green,
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                          hintText: 'Cari berdasarkan ID Keranjang',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                        ),
                        onChanged: (value) {
                          setState(() {
                            filter = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 24), // Space between search field and icon
                  
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AllCartsLoaded) {
                    final filteredCarts = state.carts
                        .where((cart) => cart.id.contains(filter))
                        .toList();

                    if (filteredCarts.isEmpty) {
                      return Center(child: Text('Tidak ada keranjang yang cocok'));
                    }

                    return ListView.builder(
                      itemCount: filteredCarts.length,
                      itemBuilder: (context, index) {
                        final cart = filteredCarts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: Icon(Icons.shopping_cart, color: Colors.green),
                            title: Text('Cart ID: ${cart.id}', style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Jumlah Produk: ${cart.products.length}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartDetailPage(cartId: cart.id),
                                ),
                              );
                            },
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
          ],
        ),
      ),
    );
  }
}

class CartSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(LoadCart(query)); // Gunakan ID yang dimasukkan sebagai filter

    return BlocBuilder<CartBloc, CartState>(
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

// class CartPage extends StatelessWidget {
//   final String cartId;

//   CartPage({required this.cartId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Keranjang'),
//       ),
//       body: BlocProvider(
//         create: (context) => CartBloc(CartService())..add(LoadCart(cartId)),
//         child: BlocBuilder<CartBloc, CartState>(
//           builder: (context, state) {
//             if (state is CartLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is CartLoaded) {
//               return ListView.builder(
//                 itemCount: state.cart.products.length,
//                 itemBuilder: (context, index) {
//                   final item = state.cart.products[index];
//                   return ListTile(
//                     title: Text('Product ID: ${item.productId}'),
//                     subtitle: Text('Quantity: ${item.quantity}'),
//                   );
//                 },
//               );
//             } else if (state is CartError) {
//               return Center(child: Text(state.message));
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }