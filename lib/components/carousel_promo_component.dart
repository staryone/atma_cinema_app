// lib/components/carousel_with_indicator.dart
import 'package:atma_cinema/models/promo_model.dart';
import 'package:atma_cinema/providers/promo_provider.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselPromo extends ConsumerStatefulWidget {
  final double? heightCarousel;
  final bool? enlargeCarousel;
  final bool autoPlayCarousel;
  final double ratioCarousel;
  final bool enableInfiniteScrollCarousel;
  final double viewportFractionCarousel;
  final FutureProvider<List<PromoModel>> provider;

  CarouselPromo({
    super.key,
    this.heightCarousel = 120,
    this.enlargeCarousel = false,
    this.autoPlayCarousel = true,
    this.ratioCarousel = 16 / 9,
    this.enableInfiniteScrollCarousel = true,
    this.viewportFractionCarousel = 0.8,
    required this.provider,
  });

  @override
  ConsumerState<CarouselPromo> createState() => _CarouselPromoState();
}

class _CarouselPromoState extends ConsumerState<CarouselPromo> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final promosAsyncValue = ref.watch(widget.provider);

    return promosAsyncValue.when(
      loading: () => Skeletonizer(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                );
              },
              options: CarouselOptions(
                height: widget.heightCarousel,
                enlargeCenterPage: widget.enlargeCarousel,
                aspectRatio: widget.ratioCarousel,
                viewportFraction: widget.viewportFractionCarousel,
              ),
            ),
            const SizedBox(height: 20),
            Skeletonizer(
              child: AnimatedSmoothIndicator(
                activeIndex: 0,
                count: 5,
                effect: ExpandingDotsEffect(
                  expansionFactor: 2,
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: const Color(0xfff264968),
                  dotColor: Colors.grey.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (promos) {
        if (promos.isEmpty) {
          return Center(child: Text("No promo available"));
        }
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: promos.length,
              itemBuilder: (context, index, realIndex) {
                final promo = promos[index];
                final imageUrl = promo.pathImage ?? '';

                return GestureDetector(
                  onTap: () => {},
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: widget.heightCarousel,
                enlargeCenterPage: widget.enlargeCarousel,
                autoPlay: widget.autoPlayCarousel,
                aspectRatio: widget.ratioCarousel,
                enableInfiniteScroll: widget.enableInfiniteScrollCarousel,
                viewportFraction: widget.viewportFractionCarousel,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: promos.length,
              effect: ExpandingDotsEffect(
                expansionFactor: 2,
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Color(0xfff264968),
                dotColor: Colors.grey.shade400,
              ),
            ),
          ],
        );
      },
    );
  }
}
