import 'package:admin/provider/category_provider.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({
    Key key,
  }) : super(key: key);

  @override
  _AddNewCategoryState createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  final TextEditingController _categoryTitle = TextEditingController();
  final TextEditingController _categoryId = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).getCategory();
  }

  @override
  void dispose() {
    super.dispose();
    _categoryId.dispose();
    _categoryTitle.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    color: Colors.white,
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
                  child: GestureDetector(
                    // onTap: () => AddNewCategoryProvider().uploadImage(),
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
                  controller: _categoryTitle,
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                  controller: _categoryId,
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
                child: Text('Add'),
                onPressed: () {
                  _upload();
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  _upload() {
    Provider.of<CategoryProvider>(context, listen: false).addNewCategory(
      categoryId: _categoryId.text,
      categoryName: _categoryTitle.text,
      categoryImage:
          'https://firebasestorage.googleapis.com/v0/b/grocery-d08a2.appspot.com/o/category%2Fmeat.png?alt=media',
    );

    _categoryId.clear();
    _categoryTitle.clear();
  }
}
