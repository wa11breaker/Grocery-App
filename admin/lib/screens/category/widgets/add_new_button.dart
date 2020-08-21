import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;

import 'package:admin/provider/category_provider.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({
    Key key,
  }) : super(key: key);

  @override
  _AddNewCategoryState createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMyDialog(),
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
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: CircleAvatar(
                    child: Icon(
                      Icons.add,
                      color: primaryColor,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Add New Category',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: lightGrey,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
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
          content: CategoryForm(),
        );
      },
    );
  }
}

class CategoryForm extends StatefulWidget {
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final TextEditingController _categoryTitle = TextEditingController();
  final TextEditingController _categoryId = TextEditingController();

  fb.UploadTask _uploadTask;

  String imageUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _categoryId.dispose();
    _categoryTitle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: 'Upload category image',
          waitDuration: Duration(seconds: 1),
          textStyle: TextStyle(fontSize: 10, color: Colors.white),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => uploadImage(),
              child: StreamBuilder<fb.UploadTaskSnapshot>(
                stream: _uploadTask?.onStateChanged,
                builder: (context, snapshot) {
                  final event = snapshot?.data;

                  double progressPercent = event != null
                      ? event.bytesTransferred / event.totalBytes * 100
                      : 0;

                  if (progressPercent == 100) {
                    return CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: primaryColor,
                      child: ClipOval(
                        child: Image.network(
                          imageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else if (progressPercent == 0) {
                    return CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.cloud_upload,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator(
                      value: progressPercent,
                    );
                  }
                },
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
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            FlatButton(
              child: Text('Add', style: TextStyle(color: Colors.green)),
              onPressed: () {
                _upload();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[700]),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    );
  }

  uploadToFirebase(File imageFile) async {
    var imageName = Uuid().v1();
    final filePath = 'images/$imageName.png';

    setState(() {
      _uploadTask = fb
          .storage()
          .refFromURL('gs://capital-supply-6dee7.appspot.com')
          .child(filePath)
          .put(imageFile);
      imageUrl =
          "https://firebasestorage.googleapis.com/v0/b/capital-supply-6dee7.appspot.com/o/images%2F$imageName.png?alt=media";
    });
  }

  uploadImage() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen(
      (changeEvent) {
        final file = uploadInput.files.first;
        final reader = FileReader();

        reader.readAsDataUrl(file);

        reader.onLoadEnd.listen(
          (loadEndEvent) async {
            uploadToFirebase(file);
          },
        );
      },
    );
  }

  _upload() {
    Provider.of<CategoryProvider>(context, listen: false).addNewCategory(
      context: context,
      categoryId: _categoryId.text,
      categoryName: _categoryTitle.text,
      categoryImage: imageUrl,
    );

    _categoryId.clear();
    _categoryTitle.clear();
  }
}
