import 'package:admin/provider/item_provider.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import 'package:uuid/uuid.dart';

class AddNewItems extends StatefulWidget {
  const AddNewItems({
    Key key,
  }) : super(key: key);

  @override
  _AddNewItemsState createState() => _AddNewItemsState();
}

class _AddNewItemsState extends State<AddNewItems> {
  @override
  Widget build(BuildContext context) {
    Future<Widget> _showMyDialog() async {
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return _AddItemsAlterDiloge();
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
                  'Add New Item',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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

class _AddItemsAlterDiloge extends StatefulWidget {
  @override
  AddItemsAlterDilogeState createState() => AddItemsAlterDilogeState();
}

class AddItemsAlterDilogeState extends State<_AddItemsAlterDiloge> {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController unit = TextEditingController();
  bool instock = false;
  bool isFeatured = false;

  fb.UploadTask _uploadTask;
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: 'Upload image',
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
              controller: title,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 1,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Item name',
                hintStyle: TextStyle(fontSize: 12),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: price,
                  keyboardType: TextInputType.number,
                  cursorColor: primaryColor,
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Price',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: unit,
                  keyboardType: TextInputType.number,
                  cursorColor: primaryColor,
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Unit',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
            ],
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
            child: Scrollbar(
              child: TextField(
                controller: description,
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                cursorColor: primaryColor,
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text('In Stock'),
              Switch(
                value: instock,
                onChanged: (value) {
                  setState(() {
                    instock = value;
                  });
                },
                activeTrackColor: Colors.grey,
                activeColor: primaryColor,
              ),
            ],
          ),
          Row(
            children: [
              Text('Add to featured product'),
              Switch(
                value: isFeatured,
                onChanged: (value) {
                  setState(() {
                    isFeatured = value;
                  });
                },
                activeTrackColor: Colors.grey,
                activeColor: primaryColor,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              FlatButton(
                child: Text('Add', style: TextStyle(color: Colors.green)),
                onPressed: () {
                  if (imageUrl == null) {
                    Fluttertoast.showToast(
                      msg: "Error",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    Provider.of<ItemProvider>(context, listen: false)
                        .addNewItem(
                      name: title.text,
                      description: description.text,
                      price: price.text,
                      unit: unit.text,
                      inStock: instock,
                      isFeatured: isFeatured,
                      image: imageUrl,
                      context: context,
                    );
                  }
                },
              ),
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  uploadToFirebase(File imageFile) async {
    var imageName = Uuid().v1();
    final filePath = 'products/$imageName.png';

    setState(() {
      _uploadTask = fb
          .storage()
          .refFromURL('gs://capital-supply-6dee7.appspot.com')
          .child(filePath)
          .put(imageFile);
      imageUrl =
          "https://firebasestorage.googleapis.com/v0/b/capital-supply-6dee7.appspot.com/o/products%2F$imageName.png?alt=media";
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
}
