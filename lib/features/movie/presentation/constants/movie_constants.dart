import 'package:flutter/material.dart';

class MovieConstants {
  // Spacing
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double largeSpacing = 24.0;
  static const double extraLargeSpacing = 32.0;

  // Dimensions
  static const double posterHeight = 200.0;
  static const double posterWidth = 150.0;
  static const double trendingHeight = 300.0;
  static const double trendingWidth = 200.0;
  static const double cardHeight = 120.0;
  static const double backButtonSize = 70.0;

  // Border Radius
  static const double smallRadius = 8.0;
  static const double mediumRadius = 12.0;
  static const double largeRadius = 24.0;

  // Padding
  static const EdgeInsets defaultPadding = EdgeInsets.all(12.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(8.0);
  static const EdgeInsets listPadding = EdgeInsets.symmetric(
    horizontal: 8.0,
    vertical: 4.0,
  );

  // Margins
  static const EdgeInsets backButtonMargin = EdgeInsets.only(
    top: 16.0,
    left: 16.0,
  );

  // Durations
  static const Duration carouselAnimationDuration = Duration(seconds: 1);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);

  // Carousel Options
  static const double defaultViewportFraction = 0.55;
  static const bool defaultEnlargeCenterPage = true;
  static const bool defaultAutoPlay = true;
}
