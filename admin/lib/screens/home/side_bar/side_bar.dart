import 'package:admin/utilities/color.dart';
import 'package:admin/widgets/nav_item.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List data = [
      {
        'icon': Icons.chrome_reader_mode,
        'title': 'DASHBOARD',
      },
      {
        'icon': Icons.content_paste,
        'title': 'ORDERS',
      },
      {
        'icon': Icons.category,
        'title': 'CATEGORY',
      },
      {
        'icon': Icons.view_carousel,
        'title': 'BANNER',
      },
      {
        'icon': Icons.directions_bike,
        'title': 'DELIVERY BOYS',
      }
    ];

    return Container(
      width: 200,
      height: double.infinity,
      color: primaryColor,
      child: Column(
        children: [
          Container(
            width: 200,
            height: 100,
            color: primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FlutterLogo(),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return NavItems(
                icon: data[index]['icon'],
                title: data[index]['title'],
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }
}
