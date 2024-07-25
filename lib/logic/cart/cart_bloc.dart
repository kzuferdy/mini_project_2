import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../../services/services.dart';

part 'cart_event.dart';
part 'cart_state.dart';

// Bloc yang menangani event-event yang terjadi pada Cart dan mengubah state yang sesuai
class CartBloc extends Bloc<CartEvent, CartState> {
  final ProductService apiService;

  CartBloc({required this.apiService}) : super(CartInitial()) {
    // Event handler untuk FetchCart
    on<FetchCart>((event, emit) async {
      emit(CartLoading());
      try {
        final cart =
            await apiService.fetchCart(); // Mengambil data cart dari API
        final products = await apiService
            .fetchProducts(); // Mengambil data products dari API
        emit(CartLoaded(
          selectedItems: {},
          favoriteItems: {},
          quantities: {},
          cart: cart,
          products: products,
        )); // Emit state CartLoaded saat data berhasil diambil
      } catch (e) {
        emit(CartError(
            message: e.toString())); // Emit state CartError saat terjadi error
      }
    });

    // Event handler untuk ToggleItemSelection
    on<ToggleItemSelection>((event, emit) {
      if (state is CartLoaded) {
        final loadedState = state as CartLoaded;
        final updatedSelectedItems =
            Map<int, bool>.from(loadedState.selectedItems);
        updatedSelectedItems[event.productId] = event.isSelected;
        emit(loadedState.copyWith(
            selectedItems: updatedSelectedItems)); // Update selectedItems
      }
    });

    // Event handler untuk ToggleFavorite
    on<ToggleFavorite>((event, emit) {
      if (state is CartLoaded) {
        final loadedState = state as CartLoaded;
        final updatedFavoriteItems =
            Map<int, bool>.from(loadedState.favoriteItems);
        updatedFavoriteItems[event.productId] =
            !(updatedFavoriteItems[event.productId] ?? false);
        emit(loadedState.copyWith(
            favoriteItems: updatedFavoriteItems)); // Update favoriteItems
      }
    });

    // Event handler untuk UpdateQuantity
    on<UpdateQuantity>((event, emit) {
      if (state is CartLoaded) {
        final loadedState = state as CartLoaded;
        final updatedQuantities = Map<int, int>.from(loadedState.quantities);
        updatedQuantities[event.productId] = event.quantity;
        emit(loadedState.copyWith(
            quantities: updatedQuantities)); // Update quantities
      }
    });
  }
}
