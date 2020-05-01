import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';

class AppZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {

  @override
  Future<String> pickImage(ImageSource source) async{
    final file = await ImagePicker.pickImage(source: source);
    String newPath = '/storage/emulated/0/Android/data/com.dannichitenco.notes_app/files/Pictures/${path.basename(file.path)}';
    if(file.path != newPath)
      {
        final newImage = await file.copy(newPath);
        return newImage.uri.toString();
      }
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