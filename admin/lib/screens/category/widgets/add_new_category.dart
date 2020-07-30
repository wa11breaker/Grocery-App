import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tooltip(
                  message: 'Upload category image',
                  waitDuration: Duration(seconds: 1),
                  textStyle: TextStyle(fontSize: 10, color: Colors.white),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: CircleAvatar(
                      minRadius: 50,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.cloud_upload,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: primaryColor,
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Category name',
                        hintStyle: TextStyle(fontSize: 12),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: primaryColor,
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Category ID',
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return GestureDetector(
      onTap: _showMyDialog,
          child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                spreadRadius: 5,
                blurRadius: 10,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Add New Category',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
