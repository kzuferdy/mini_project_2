// product_bloc.dart
import 'package:bloc/bloc.dart';
import '../../services/services.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc(this.productService) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productService.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to fetch products'));
      }
    });

    on<SearchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productService.fetchProducts();
        final filteredProducts = products.where((product) {
          final titleLower = product.title.toLowerCase();
          final searchLower = event.query.toLowerCase();
          return titleLower.contains(searchLower);
        }).toList();
        emit(ProductLoaded(filteredProducts));
      } catch (e) {
        emit(ProductError('Failed to fetch products'));
      }
    });
  }
}