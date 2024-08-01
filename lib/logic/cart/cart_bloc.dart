import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_2/logic/cart/cart_state.dart';
import 'package:mini_project_2/services/services.dart';
import 'cart_event.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_2/logic/cart/cart_event.dart';
import 'package:mini_project_2/logic/cart/cart_state.dart';
import 'package:mini_project_2/services/services.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;

  CartBloc(this.cartService) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<LoadAllCarts>(_onLoadAllCarts);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await cartService.getCart(event.cartId);
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onLoadAllCarts(LoadAllCarts event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final carts = await cartService.getAllCarts();
      emit(AllCartsLoaded(carts: carts));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}


// // Bloc
// class CartBloc extends Bloc<CartEvent, CartState> {
//   final CartService _cartService;

//   CartBloc(this._cartService) : super(CartLoading()) {
//     on<LoadCart>(_onLoadCart);
//   }

//   void _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
//     emit(CartLoading());
//     try {
//       final cart = await _cartService.getCart(event.cartId);
//       emit(CartLoaded(cart));
//     } catch (e) {
//       emit(CartError('Failed to load cart: $e'));
//     }
//   }
// }
