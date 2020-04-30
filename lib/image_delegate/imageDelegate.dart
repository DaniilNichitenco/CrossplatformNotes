import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';

class AppZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {

  @override
  Future<String> pickImage(ImageSource source) async{
    final file = await ImagePicker.pickImage(source: source);
    if(file == null)
      return null;
    return file.uri.toString();
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    if(key.startsWith('assets://')) {
      final asset = AssetImage(key.replaceFirst('asset://', ''));
      return Image(image: asset);
    } else {
      final file = File.fromUri(Uri.parse(key));
      final image = FileImage(file);
      return Image(image: image,);
    }
  }

  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;
}