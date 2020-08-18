import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;

class Uploadimg extends StatefulWidget {
  @override
  _UploadimgState createState() => _UploadimgState();
}

class _UploadimgState extends State<Uploadimg> {
  fb.UploadTask _uploadTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () => uploadImage(),
            child: Text('upload image'),
          ),
          StreamBuilder<fb.UploadTaskSnapshot>(
            stream: _uploadTask?.onStateChanged,
            builder: (context, snapshot) {
              final event = snapshot?.data;

              double progressPercent = event != null
                  ? event.bytesTransferred / event.totalBytes * 100
                  : 0;

              if (progressPercent == 100) {
                return Text('Successfully uploaded ${snapshot.data}');
              } else if (progressPercent == 0) {
                return SizedBox();
              } else {
                return LinearProgressIndicator(
                  value: progressPercent,
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: Colors.tealAccent[400],
        hoverElevation: 0,
        label: Row(
          children: <Widget>[
            Icon(Icons.file_upload),
            SizedBox(width: 10),
            Text('Upload Image')
          ],
        ),
        onPressed: () => uploadImage(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  uploadToFirebase(File imageFile) async {
    final filePath = 'images/${DateTime.now()}.png';
    setState(() {
      _uploadTask = fb
          .storage()
          .refFromURL('gs://groccerysupply.appspot.com/images')
          .child(filePath)
          .put(imageFile);
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
