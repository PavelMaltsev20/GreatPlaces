import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  Function _function;

  ImageInput(this._function);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy("${appDir.path}/$fileName");
    widget._function(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).primaryColor),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "No image selected",
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              icon: Icon(Icons.camera),
              label: Text("Take Picture"),
              onPressed: _takePicture,
            ),
          ),
        )
      ],
    );
  }
}
