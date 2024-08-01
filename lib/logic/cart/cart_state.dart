import '../../model/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;

  CartLoaded({required this.cart});
}

class AllCartsLoaded extends CartState {
  final List<Cart> carts;

  AllCartsLoaded({required this.carts});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}




// // State
// import 'package:equatable/equatable.dart';

// import '../../model/cart_model.dart';

// abstract class CartState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class CartLoading extends CartState {}

// class CartLoaded extends CartState {
//   final Cart cart;

//   CartLoaded(this.cart);

//   @override
//   List<Object> get props => [cart];
// }

// class CartError extends CartState {
//   final String message;

//   CartError(this.message);

//   @override
//   List<Object> get props => [message];
// }
