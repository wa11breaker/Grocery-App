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
        'icon': Icons.list,
        'title': 'ITEMS',
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
    final List<Widget> items = [
      NavItems(
        icon: Icons.chrome_reader_mode,
        title: 'DASHBOARD',
      ),
      NavItems(
        icon: Icons.content_paste,
        title: 'ORDERS',
      ),
      NavItems(
        icon: Icons.category,
        title: 'CATEGORY',
      ),
      NavItems(
        icon: Icons.list,
        title: 'ITEMS',
      ),
      NavItems(
        icon: Icons.view_carousel,
        title: 'BANNER',
      ),
      NavItems(
        icon: Icons.directions_bike,
        title: 'DELIVERY BOYS',
      )
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
            color: Colors.blue,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
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
