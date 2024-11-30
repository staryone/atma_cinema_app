// lib/components/carousel_with_indicator.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<String> images;
  final double? heightCarousel;
  final bool? enlargeCarousel;
  final bool autoPlayCarousel;
  final double ratioCarousel;
  final bool enableInfiniteScrollCarousel;
  final double viewportFractionCarousel;
  final GestureTapCallback? onTap;

  CarouselWithIndicator({
    super.key,
    required this.images,
    this.heightCarousel = 280,
    this.enlargeCarousel = true,
    this.autoPlayCarousel = false,
    this.ratioCarousel = 3 / 4,
    this.enableInfiniteScrollCarousel = false,
    this.viewportFractionCarousel = 0.55,
    this.onTap,
  });

  @override
  createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.images.map((imageUrl) {
            return GestureDetector(
              onTap: widget.onTap,
              child: Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  image: DecorationImage(
                    image: imageUrl.contains('http')
                        ? NetworkImage(imageUrl)
                        : AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
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
