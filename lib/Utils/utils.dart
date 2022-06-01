import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// //ImageSource = Specifies the source where the picked image should come from.
// pickImage(ImageSource source) async {
//   //we have instantiated and got the instance of the ImgaePicker
//   final ImagePicker _imagePicker = ImagePicker();

//   XFile? _file = await _imagePicker.pickImage(source: source);

//   if (_file != null) {
//     //Synchronously read the entire file contents as a list of bytes.
//     return await _file.readAsBytes();

//     print("No Image selected!");
//   }
// }

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

showsnackbar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
