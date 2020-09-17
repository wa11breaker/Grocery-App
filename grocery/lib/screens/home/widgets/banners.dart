import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery/providers/get_banners.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width / 2;
    return Consumer<GetBanners>(
      builder: (context, model, child) => CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          pauseAutoPlayOnTouch: true,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          enableInfiniteScroll: false,
          autoPlayInterval: Duration(seconds: 5),
        ),
        items: model.loading
            ? [
                Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.white,
                  child: bannerWidget(
                    height: height,
                    width: width,
                  ),
                )
              ]
            : model.banners
                .map(
                  (banner) => bannerWidget(
                    height: height,
                    width: width,
                    banner: banner,
                  ),
                )
                .toList(),
      ),
    );
  }

  Padding bannerWidget({double height, double width, String banner}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  blurRadius: 8,
                  spreadRadius: 4,
                )
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              height: height,
              width: width,
              color: Colors.grey[50],
              child: banner != null
                  ? CachedNetworkImage(
                      imageUrl: banner,
                      fit: BoxFit.cover,
                    )
                  : SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
