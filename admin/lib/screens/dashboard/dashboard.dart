// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                print(snapshot.data);
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
    );
  }

 /*  uploadToFirebase(File imageFile) async {
    // final filePath = 'category/${DateTime.now()}.png';
// File file = await FilePicker.getFile();
    // print(file.relativePath);
    // setState(() {
    //   _uploadTask = fb
    //       .storage()
    //       .refFromURL('gs://grocery-d08a2.appspot.com')
    //       .child(filePath)
    //       .put(imageFile);

    // });
  } */

  uploadImage() async {
    try {
      final html.InputElement input = html.document.createElement('input');
      input
        ..type = 'file'
        ..accept = 'image/*';

      input.onChange.listen((e) {
        if (input.files.isEmpty) return;
        final reader = html.FileReader();
        reader.readAsDataUrl(input.files[0]);
        reader.onError.listen((err) => setState(() {
              print(err.toString());
            }));
        reader.onLoad.first.then((res) {
          final encoded = reader.result as String;
          // remove data:image/*;base64 preambule
          final stripped =
              encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
          print(input.files[0].relativePath);
          /*  setState(() {
        backgroundBytes = base64.decode(stripped);
        backgroundImage = input.files[0];
        metaDataBackground = input.files[0].type;
      }); */
        });
      });

      input.click();
    } catch (e) {
      print('Error background image');
    }

    // InputElement uploadInput = FileUploadInputElement();
    // uploadInput.click();
    // uploadInput.onChange.listen(
    //   (changeEvent) {
    //     final file = uploadInput.files.first;
    //     final reader = FileReader();

    //     reader.readAsDataUrl(file);

    //     reader.onLoadEnd.listen(
    //       (loadEndEvent) async {
    //         uploadToFirebase(file);
    //       },
    //     );
    //   },
    // );
  }
}
