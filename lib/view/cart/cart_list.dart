// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../logic/cart/cart_bloc.dart';
// import '../../model/cart_model.dart';
// import '../../model/product_model.dart';

// class CartList extends StatelessWidget {
//   const CartList({
//     super.key,
//     required this.cartItems,
//     required this.products,
//     required this.selectedItems,
//     required this.favoriteItems,
//     required this.quantities,
//   });

//   final List<CartItem> cartItems;
//   final List<Product> products;
//   final Map<int, bool> selectedItems;
//   final Map<int, bool> favoriteItems;
//   final Map<int, int> quantities;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: cartItems.length,
//       itemBuilder: (context, index) {
//         final item = cartItems[index];
//         final product =
//             products.firstWhere((product) => product.id == item.productId);

//         final isSelected = selectedItems[product.id] ?? false;
//         final isFavorite = favoriteItems[product.id] ?? false;
//         final quantity = quantities[product.id] ?? item.quantity;

//         return Card(
//           elevation: 0,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.zero,
//           ),
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.only(
//               top: 8,
//               bottom: 8,
//               right: 12,
//             ),
//             child: Column(
//               children: [
//                 // row nama brand + checkbox
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: isSelected,
//                       onChanged: (value) {
//                         context
//                             .read<CartBloc>()
//                             .add(ToggleItemSelection(product.id, value!));
//                       },
//                       side: const BorderSide(
//                         color: Colors.grey,
//                         width: 2,
//                       ),
//                     ),
//                     Text(
//                       'nama brand',
//                       style: GoogleFonts.roboto(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const Spacer(),
//                     Image.asset('assets/images/cod.png', width: 60),
//                   ],
//                 ),
//                 Container(
//                   height: 140,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       // checkbox
//                       Column(
//                         children: [
//                           Checkbox(
//                             value: isSelected,
//                             onChanged: (value) {
//                               context
//                                   .read<CartBloc>()
//                                   .add(ToggleItemSelection(product.id, value!));
//                             },
//                             side: const BorderSide(
//                               color: Colors.grey,
//                               width: 2,
//                             ),
//                           ),
//                         ],
//                       ),
//                       // image
//                       Container(
//                         height: double.infinity,
//                         width: 70,
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 70,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage(product.image),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // detail item
//                       Container(
//                         width: 200,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 product.title,
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 product.description,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               Text(
//                                 'Rp ${product.price.toStringAsFixed(0)}',
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   // add
//                                   IconButton(
//                                     onPressed: () {
//                                       context.read<CartBloc>().add(
//                                         UpdateQuantity(
//                                           product.id,
//                                           quantity + 1,
//                                         ),
//                                       );
//                                     },
//                                     icon: const Icon(Icons.add),
//                                   ),
//                                   Text(
//                                     quantity.toString(),
//                                     style: GoogleFonts.roboto(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   // subtract
//                                   IconButton(
//                                     onPressed: () {
//                                       if (quantity > 1) {
//                                         context.read<CartBloc>().add(
//                                           UpdateQuantity(
//                                             product.id,
//                                             quantity - 1,
//                                           ),
//                                         );
//                                       }
//                                     },
//                                     icon: const Icon(Icons.remove),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       // favorite
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               context
//                                   .read<CartBloc>()
//                                   .add(ToggleFavorite(product.id));
//                             },
//                             icon: Icon(
//                               isFavorite
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
