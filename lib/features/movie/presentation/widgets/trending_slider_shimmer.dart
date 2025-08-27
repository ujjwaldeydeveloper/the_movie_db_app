import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class TrendingSliderShimmer extends StatelessWidget {
  const TrendingSliderShimmer({
    super.key,
    this.height = 300,
    this.itemWidth = 200,
    this.viewportFraction = 0.55,
    this.enlargeCenterPage = true,
    this.itemCount = 5,
  });

  final double height;
  final double itemWidth;
  final double viewportFraction;
  final bool enlargeCenterPage;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: itemCount,
        options: CarouselOptions(
          height: height,
          autoPlay: false,
          viewportFraction: viewportFraction,
          enlargeCenterPage: enlargeCenterPage,
          pageSnapping: true,
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: height,
              width: itemWidth,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
