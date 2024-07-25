part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

//state awal ketika cart belum dimuat
final class CartInitial extends CartState {}

// State ketika proses pengambilan data Cart sedang berlangsung
class CartLoading extends CartState {}

// State ketika data Cart berhasil dimuat
class CartLoaded extends CartState {
  final Map<int, bool> selectedItems;
  final Map<int, bool> favoriteItems;
  final Map<int, int> quantities;
  final Cart cart;
  final List<Product> products;

  const CartLoaded({
    required this.selectedItems,
    required this.favoriteItems,
    required this.quantities,
    required this.cart,
    required this.products,
  });

// Method untuk menyalin objek CartLoaded dengan data baru
  CartLoaded copyWith({
    Map<int, bool>? selectedItems,
    Map<int, bool>? favoriteItems,
    Map<int, int>? quantities,
    Cart? cart,
    List<Product>? products,
  }) {
    return CartLoaded(
      selectedItems: selectedItems ?? this.selectedItems,
      favoriteItems: favoriteItems ?? this.favoriteItems,
      quantities: quantities ?? this.quantities,
      cart: cart ?? this.cart,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props =>
      [cart, products, selectedItems, favoriteItems, quantities];
}

// State ketika terjadi error saat mengambil data Cart
class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object> get props => [message];
}
