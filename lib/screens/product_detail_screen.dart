import 'package:banana_challenge/providers/product_provider.dart';
import 'package:banana_challenge/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen(this.productId, {super.key});
  final String productId;

  @override
  ConsumerState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final CarouselController _carouselController = CarouselController();
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(singleProductProvider(widget.productId).notifier)
        .getProductById(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(singleProductProvider(widget.productId));

    return Scaffold(
      appBar: AppBar(
        title: product != null
            ? Text(product.title,
                style: Theme.of(context).textTheme.headlineSmall)
            : null,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).push('/products'),
        ),
      ),
      body: product != null
          ? ProductDetailContent(
              productId: widget.productId,
              carouselController: _carouselController,
              currentImageIndex: _currentImageIndex,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton(
            isExtended: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Producto agregado al carrito')),
              );
            },
            child: const Text('Agregar al carrito'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
