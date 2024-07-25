import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/cart/cart_bloc.dart';
import '../../services/services.dart';
import 'cart_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: appBar(context),
      bottomNavigationBar: bottomBar(context),
      body: BlocProvider(
        create: (context) => CartBloc(
          apiService: ProductService(),
        )..add(
            FetchCart(),
          ),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is CartLoaded) {
              return CartList(
                cartItems: state.cart.items,
                products: state.products,
                selectedItems: state.selectedItems,
                favoriteItems: state.favoriteItems,
                quantities: state.quantities,
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Keranjang',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.favorite_border_outlined,
            color: Colors.black.withOpacity(0.5),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.menu,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      elevation: 4,
      shadowColor: Colors.grey.shade100,
    );
  }
}

BottomAppBar bottomBar(BuildContext context) {
  return BottomAppBar(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (value) {},
              side: const BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            const Text('Semua')
          ],
        ),
        Row(
          children: [
            const Column(
              children: [
                Text('Total'),
                Text('-'),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'Beli',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}