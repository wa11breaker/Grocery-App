import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery/providers/get_banners.dart';
import 'package:provider/provider.dart';

class Offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<GetBanners>(
      builder: (context, value, child) => value.banners.length == 0 ||
              value.banners == null
          ? SizedBox.shrink()
          : Column(
              children: <Widget>[
                SizedBox(
                  height: size.height / 4,
                  width: double.infinity,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      pauseAutoPlayOnTouch: true,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                    ),
                    items: value.banners.map(
                      (e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SizedBox(
                              height: size.height / 4.5,
                              child: Image.network(
                                e,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
