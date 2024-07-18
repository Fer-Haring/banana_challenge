import 'dart:convert';

import 'package:banana_challenge/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final productProvider = StateNotifierProvider<ProductNotifier, Products>((ref) {
  return ProductNotifier();
});

class ProductNotifier extends StateNotifier<Products> {
  ProductNotifier()
      : super(Products(products: [], total: 0, skip: 0, limit: 0));

  void searchProducts(String query) async {
    final uri = Uri.parse('https://dummyjson.com/products/search?q=$query');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      state = Products.fromJson(data);
    } else {
      state = Products(products: [], total: 0, skip: 0, limit: 0);
    }
  }
}

final singleProductProvider =
    StateNotifierProvider.family<SingleProductNotifier, Product?, String>(
        (ref, productId) {
  return SingleProductNotifier(productId);
});

class SingleProductNotifier extends StateNotifier<Product?> {
  SingleProductNotifier(this.productId) : super(null) {
    getProductById(productId);
  }

  final String productId;

  void getProductById(String id) async {
    final uri = Uri.parse('https://dummyjson.com/products/$id');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data is Map<String, dynamic>) {
          state = Product.fromJson(data);
        } else {
          state = null;
        }
      } else {
        state = null;
      }
    } catch (e) {
      const SnackBar(content: Text('Error Obteniendo Producto'));
      state = null;
    }
  }
}
