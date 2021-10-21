import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:policepatil/src/utils/styles.dart';

getFileName(String path) {
  return basename(path);
}

Future<File> getImageFromCamera() async {
  final picker = ImagePicker();
  File? _file;
  final pickedImage = await picker.pickImage(source: ImageSource.camera);

  if (pickedImage != null) {
    _file = File(pickedImage.path);
  } else {
    debugPrint('No image selected.');
  }
  return _file!;
}

Future<File> getImageFromGallery() async {
  final picker = ImagePicker();
  File? _file;
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    _file = File(pickedImage.path);
  } else {
    debugPrint('No image selected.');
  }
  return _file!;
}

Future<File> getFileFromGallery() async {
  File? _file;
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    _file = File(result.files.single.path!);
  } else {
    debugPrint('No file selected.');
  }
  return _file!;
}

Future<File?> getFileFromDevice(BuildContext context) async {
  File? _file;
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'फोटो काढा अथवा गॅलरी मधून निवडा',
            style: Styles.titleTextStyle(),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  _file = await getImageFromCamera();
                  Navigator.pop(context);
                },
                child: Text(
                  'कॅमेरा',
                  style: Styles.primaryTextStyle(),
                )),
            TextButton(
                onPressed: () async {
                  _file = await getImageFromGallery();
                  Navigator.pop(context);
                },
                child: Text(
                  'गॅलरी',
                  style: Styles.primaryTextStyle(),
                ))
          ],
        );
      });
  return _file;
}
