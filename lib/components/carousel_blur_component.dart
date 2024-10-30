// lib/components/carousel_with_indicator.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselBlurWithIndicator extends StatefulWidget {
  final List<String> images;
  final double? heightCarousel;
  final bool? enlargeCarousel;
  final bool autoPlayCarousel;
  final double ratioCarousel;
  final bool enableInfiniteScrollCarousel;
  final double viewportFractionCarousel;

  CarouselBlurWithIndicator({
    super.key,
    required this.images,
    this.heightCarousel = 280,
    this.enlargeCarousel = true,
    this.autoPlayCarousel = false,
    this.ratioCarousel = 3 / 4,
    this.enableInfiniteScrollCarousel = false,
    this.viewportFractionCarousel = 0.55,
  });

  @override
  createState() => _CarouselBlurWithIndicatorState();
}

class _CarouselBlurWithIndicatorState extends State<CarouselBlurWithIndicator> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            bool isBlur = index == currentIndex;
            // print(index);
            print(currentIndex);
            return Stack(
              children: [
                if (isBlur)
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Opacity(
                      opacity: 0.6,
                      child: Container(
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          image: DecorationImage(
                            image: NetworkImage(widget.images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            height: widget.heightCarousel,
            enlargeCenterPage: widget.enlargeCarousel,
            autoPlay: widget.autoPlayCarousel,
            aspectRatio: widget.ratioCarousel,
            enableInfiniteScroll: widget.enableInfiniteScrollCarousel,
            viewportFraction: widget.viewportFractionCarousel,
            enlargeFactor: 0.28,
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
          count: widget.images.length,
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
  }
}
