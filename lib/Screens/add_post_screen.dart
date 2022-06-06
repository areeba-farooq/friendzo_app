import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:friendzo_app/Models/user_model.dart';
import 'package:friendzo_app/Providers/user_provider.dart';
import 'package:friendzo_app/Resources/firestore_methods.dart';
import 'package:friendzo_app/Utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancle'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  postImage(
    String uid,
    String username,
    String profileImg,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, uid, _file!, username, profileImg);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showsnackbar('Posted!', context);
      } else {
        setState(() {
          _isLoading = true;
        });
        showsnackbar(res, context);
      }
    } catch (e) {
      showsnackbar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final UserModel user = Provider.of<UserProvider>(context).getUser;
    UserModel userMod = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () => _selectImage(context),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: const Text('Post to'),
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              actions: [
                TextButton(
                    onPressed: () => postImage(
                        userMod.uid, userMod.username, userMod.photoUrl),
                    child: const Text(
                      'Post',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            body: Column(
              children: [
                _isLoading ? const LinearProgressIndicator() : Container(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: userMod.photoUrl == null
                          ? const NetworkImage(
                              'https://www.nicepng.com/png/detail/933-9332131_profile-picture-default-png.png')
                          : NetworkImage(userMod.photoUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter),
                          ),
                        ),
                      ),
                    ),
                    const Divider()
                  ],
                ),
              ],
            ),
          );
  }
}
