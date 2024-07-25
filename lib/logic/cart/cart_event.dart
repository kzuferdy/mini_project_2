part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

// Event untuk mengambil data Cart dan Products
class FetchCart extends CartEvent {}

// Event untuk mengubah status checkbox dari item di Cart
class ToggleItemSelection extends CartEvent {
  final int productId;
  final bool isSelected;

  const ToggleItemSelection(this.productId, this.isSelected);

  @override
  List<Object> get props => [productId, isSelected];
}

// Event untuk mengubah status favorit dari item di Cart
class ToggleFavorite extends CartEvent {
  final int productId;

  const ToggleFavorite(this.productId);

  @override
  List<Object> get props => [productId];
}

// Event untuk mengubah jumlah item di Cart
class UpdateQuantity extends CartEvent {
  final int productId;
  final int quantity;

  const UpdateQuantity(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}
