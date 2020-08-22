import 'package:admin/provider/screen_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class NavItems extends StatefulWidget {
  final IconData icon;
  final String title;
  final String navLink;
  final int index;
  const NavItems({
    Key key,
    this.icon,
    this.title,
    this.navLink,
    this.index,
  }) : super(key: key);

  @override
  _NavItemsState createState() => _NavItemsState();
}

class _NavItemsState extends State<NavItems> {
  bool isHover = false;
  setActive(value) {
    setState(() {
      isHover = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndex>(
      builder: (context, value, _) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onHover: (value) => setActive(value),
          onTap: () {
            value.setIndex(widget.index);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 28,
                ),
                Row(
                  children: [
                    Icon(
                      widget.icon,
                      size: 20,
                      color: isHover || widget.index == value.index
                          ? Colors.white
                          : Colors.grey,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: isHover || widget.index == value.index
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 28,
                ),
                Divider(
                  height: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
