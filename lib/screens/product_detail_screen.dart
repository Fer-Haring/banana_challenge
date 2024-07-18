import 'package:banana_challenge/providers/product_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: product.images.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.network(i));
                        },
                      );
                    }).toList(),
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: 200.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: _currentImageIndex,
                      count: product.images.length,
                      effect: const ScaleEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: Colors.blue,
                      ),
                      onDotClicked: (index) {
                        _carouselController.animateToPage(index);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(product.description),
                  const SizedBox(height: 16),
                  Text('USD ${product.price}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
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
