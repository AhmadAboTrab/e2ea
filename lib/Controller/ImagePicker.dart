import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class imagepicker extends StatefulWidget {
  imagepicker({Key key}) : super(key: key);

  @override
  _imagepickerState createState() => _imagepickerState();
}

class _imagepickerState extends State<imagepicker> {
  String MedUrl = '';
  File _pickedImage;
  String downloadUrl;
  FirebaseAuth auth = FirebaseAuth.instance;
  AcceptImage(int type) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    if (type == 0) {
      await Permission.camera.request();
      var permissionSttatuse = await Permission.camera.status;
      if (true) {
        // ignore: deprecated_member_use
        image = await _picker.getImage(source: ImageSource.camera,imageQuality: 80);
      }
    }
    if (type == 1) {
      await Permission.photos.request();
      var permissionSttatuse = await Permission.photos.status;
      if (permissionSttatuse.isGranted) {
        // ignore: deprecated_member_use
        image = await _picker.getImage(source: ImageSource.gallery);
      }
    }
    var file = File(image.path);
    if (image != null) {
      var sn = await _storage
          .ref()
          .child("MedicineImage")
          .child('Bromonaz Fort.png')
          .putFile(file);
      var downUrl = await sn.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('medicins')
          .doc('2p9sxvgydAsXkSinZacz')
          .update({'urlImage':downUrl});

      setState(() {
        _pickedImage = file;
        downloadUrl = downUrl;
      });
    } else {
      print(" null image ");
    }
  }

  String geturl() {
    return downloadUrl;
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Medicine Image"),
              content: new Text("Please choose one "),
              actions: <Widget>[
                FlatButton(
                  child: Text('Files'),
                  onPressed: () {
                    AcceptImage(1);
                    // uploadImage();
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Camera'),
                  onPressed: () {
                    // dImage();
                    AcceptImage(0);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return _showMaterialDialog();
  }
}
