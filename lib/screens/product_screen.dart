import 'package:banana_challenge/providers/product_provider.dart';
import 'package:banana_challenge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(productProvider.notifier).searchProducts(''));
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter challenge 2023'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar producto',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => ref
                      .read(productProvider.notifier)
                      .searchProducts(_searchController.text),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: productsState.products.isEmpty
                  ? Text(
                      'No se encontraron resultados para ${_searchController.text}')
                  : ListView.builder(
                      itemCount: productsState.products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          productsState,
                          index,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
