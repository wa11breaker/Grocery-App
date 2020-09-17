import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery/models/product.dart';
import 'package:grocery/screens/product_detailes/item_detailes.dart';
import 'package:grocery/utilities/color.dart';
import 'package:shimmer/shimmer.dart';

class ProductCell extends StatelessWidget {
  final Product item;
  const ProductCell({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (item.inStock) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailes(item: item),
              ),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 3.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.25),
                      blurRadius: 8,
                    )
                  ],
                ),
                child: Hero(
                  tag: item.imgUrl + item.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          // if product is out of stock convert the image
                          // to grayscale
                          child: ColorFiltered(
                            colorFilter: item.inStock
                                ? ColorFilter.mode(
                                    Colors.transparent,
                                    BlendMode.multiply,
                                  )
                                : ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.saturation,
                                  ),
                            child: CachedNetworkImage(
                              imageUrl: item.imgUrl,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        // if product is out of stock show outofstock label
                        if (!item.inStock)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 32,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'OUT OF STOCK',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      '₹' + item.price.toString(),
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: primaryColor,
                            fontSize: 16,
                          ),
                    ),
                    Text(
                      ' / ' + item.unit,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            // color: primaryColor,
                            fontSize: 14,
                          ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProductPlaceHolder extends StatelessWidget {
  const ProductPlaceHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.25),
                    blurRadius: 8,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 5,
                width: 100,
                color: Colors.grey,
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                height: 5,
                width: 60,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }
}
