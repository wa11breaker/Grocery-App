import 'package:flutter/material.dart';
import 'package:grocery/utilities/color.dart';

class ItemDetailes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: height / 2.5,
              width: double.infinity,
              decoration: BoxDecoration(color: lightGrey),
              child: Icon(Icons.ac_unit),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height / 2.5,
                  ),
                  Container(
                    height: (height -
                        MediaQuery.of(context).padding.top -
                        height / 2.5),
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'JBL C50HI Wired Headset  (Blue, Wired in the ear)',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '₹498',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: primaryColor),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Say hello to an enhanced music experience with the JBL C50HI Wired Headset with Mic. With features, such as True Bass, Voice-assistant support, stylish looks and JBL Signature Sound, you will never want to be without these earphones.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(height: 1.7),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Spacer(),
                        SizedBox(
                          height: 55,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Buy Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
