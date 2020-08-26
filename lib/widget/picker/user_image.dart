import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagepickerFn);
  final void Function(File pickedImage) imagepickerFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final filepicked =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50,maxWidth: 150,);
    setState(() {
      _pickedImage = File(filepicked.path);
    });
    widget.imagepickerFn(File(filepicked.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('add image'),
        ),
      ],
    );
  }
}
