import 'package:banana_challenge/providers/product_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailContent extends ConsumerWidget {
  const ProductDetailContent({
    Key? key,
    required this.productId,
    required this.carouselController,
    required this.currentImageIndex,
    required this.onPageChanged,
  }) : super(key: key);

  final String productId;
  final CarouselController carouselController;
  final int currentImageIndex;
  final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(singleProductProvider(productId));

    if (product == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: product?.images.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.network(
                      i,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  );
                },
              );
            }).toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              height: 200.0,
              onPageChanged: (index, reason) {
                onPageChanged(index);
              },
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: AnimatedSmoothIndicator(
              activeIndex: currentImageIndex,
              count: product.images.length,
              effect: const ScaleEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: Colors.blue,
              ),
              onDotClicked: (index) {
                carouselController.animateToPage(index);
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
    );
  }
}
