import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MoviesSliderShimmer extends StatelessWidget {
  const MoviesSliderShimmer({
    super.key,
    this.height = 200,
    this.itemWidth = 150,
    this.itemSpacing = 8.0,
    this.borderRadius = 8.0,
    this.itemCount = 8,
  });

  final double height;
  final double itemWidth;
  final double itemSpacing;
  final double borderRadius;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(itemSpacing),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: SizedBox(
                height: height,
                width: itemWidth,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
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
