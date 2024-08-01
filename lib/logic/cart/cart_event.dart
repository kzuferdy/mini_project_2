abstract class CartEvent {}

class LoadCart extends CartEvent {
  final String cartId;

  LoadCart(this.cartId);
}

class LoadAllCarts extends CartEvent {}




// // Event
// import 'package:equatable/equatable.dart';

// abstract class CartEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class LoadCart extends CartEvent {
//   final String cartId;

//   LoadCart(this.cartId);

//   @override
//   List<Object> get props => [cartId];
// }
