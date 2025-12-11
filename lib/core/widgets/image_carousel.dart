import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final double height;

  const ImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) return const SizedBox();

    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        viewportFraction: 1.0,
        autoPlay: true,
      ),
      items: imageUrls.map((url) => Builder(
          builder: (BuildContext context) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                memCacheHeight: 600,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.white),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
        )).toList(),
    );
  }
}
