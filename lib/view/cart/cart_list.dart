import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/cart/cart_bloc.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';

class CartList extends StatelessWidget {
  const CartList({
    super.key,
    required this.cartItems,
    required this.products,
    required this.selectedItems,
    required this.favoriteItems,
    required this.quantities,
  });

  final List<CartItem> cartItems;
  final List<Product> products;
  final Map<int, bool> selectedItems;
  final Map<int, bool> favoriteItems;
  final Map<int, int> quantities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        final product =
            products.firstWhere((product) => product.id == item.productId);

        final isSelected = selectedItems[product.id] ?? false;
        final isFavorite = favoriteItems[product.id] ?? false;
        final quantity = quantities[product.id] ?? item.quantity;

        return Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
              right: 12,
            ),
            child: Column(
              children: [
                // row nama brand + checkbox
                Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        context
                            .read<CartBloc>()
                            .add(ToggleItemSelection(product.id, value!));
                      },
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    Text(
                      'nama brand',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Image.asset('assets/images/cod.png', width: 60),
                  ],
                ),
                Container(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // checkbox
                      Column(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              context
                                  .read<CartBloc>()
                                  .add(ToggleItemSelection(product.id, value!));
                            },
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                        ],
                      ),
                      // image
                      Container(
                        height: double.infinity,
                        width: 70,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(product.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      // text column title dan price
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                product.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              Text(
                                'Rp ${product.price}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // row category dan qty
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.category,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    'Qty: ${item.quantity}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // row edit dan delete
                              Row(
                                children: [
                                  const Icon(
                                    Icons.edit_note,
                                    size: 24.0,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      context.read<CartBloc>().add(
                                            ToggleFavorite(product.id),
                                          );
                                    },
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color:
                                          isFavorite ? Colors.red : Colors.grey,
                                      size: 24.0,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 116,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.1),
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove,
                                          ),
                                          onPressed: () {
                                            if (quantity > 1) {
                                              context.read<CartBloc>().add(
                                                  UpdateQuantity(product.id,
                                                      quantity - 1));
                                            }
                                          },
                                        ),
                                        Text('$quantity'),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                          ),
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                                UpdateQuantity(
                                                    product.id, quantity + 1));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}