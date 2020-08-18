// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import 'package:admin/provider/banners.dart';
import 'package:admin/utilities/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Banners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<BannerProvider>(context, listen: false).getBannerList();
    uploadToFirebase(File imageFile) async {
      var imageName = Uuid().v1();
      final filePath = 'banners/$imageName.png';
      fb
          .storage()
          .refFromURL('gs://capital-supply-6dee7.appspot.com')
          .child(filePath)
          .put(imageFile);
      String imageUrl =
          "https://firebasestorage.googleapis.com/v0/b/capital-supply-6dee7.appspot.com/o/banners%2F$imageName.png?alt=media";
      Provider.of<BannerProvider>(context, listen: false)
          .addNewBanner(imageUrl);
    }

    uploadImage() {
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

    return Column(
      children: [
        Consumer<BannerProvider>(
          builder: (context, value, _) => Padding(
            padding: const EdgeInsets.all(32),
            child: Wrap(
              runSpacing: 32,
              spacing: 32,
              children: [
                GestureDetector(
                  onTap: () => uploadImage(),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      height: 150,
                      width: 300,
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              'Add New Banner image',
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
                ),
                for (String img in value.bannerList)
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          spreadRadius: 5,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 300,
                            child: Image.network(
                              img,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: lightGrey,
                                ),
                                onPressed: () => value.removeBanner(img),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
