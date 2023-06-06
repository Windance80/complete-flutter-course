import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/test_products.dart';
import '../domain/product.dart';

class FakeProductRepository {
  // static FakeProductRepository instance = FakeProductRepository._();

  // FakeProductRepository._();

  final List<Product> _products = kTestProducts;

  List<Product> getProductList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductRepository>((ref) {
  return FakeProductRepository();
});
