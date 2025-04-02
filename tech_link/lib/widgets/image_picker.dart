import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tech_link/providers/user_provider.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickedImage});

  final void Function(File pickedImage) onPickedImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickedImage(_pickedImageFile!);
  }

  void _clearImage() {
    setState(() {
      _pickedImageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            child: CircleAvatar(
              radius: 84,
              backgroundColor: Color.fromARGB(255, 11, 110, 79),
              child: CircleAvatar(
                radius: 78.0,
                backgroundColor: Color.fromARGB(255, 242, 255, 251),
                backgroundImage:
                    context.watch<UserProvider>().profileImage == null
                        ? const AssetImage('assets/icon_bg.png')
                        : Image.file(
                          context.watch<UserProvider>().profileImage!,
                        ).image,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {},
                    child:
                        context.watch<UserProvider>().profileImage == null
                            ? IconButton(
                              onPressed: () {
                                context.read<UserProvider>().captureImage();
                              },
                              icon: const Icon(Icons.add_a_photo_rounded),
                              iconSize: 30,
                              padding: const EdgeInsets.all(10),
                              color: Colors.white,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  Color.fromARGB(255, 11, 110, 79),
                                ),
                              ),
                            )
                            : IconButton(
                              onPressed: () {
                                context.read<UserProvider>().clearImage();
                              },
                              icon: const Icon(Icons.cancel_outlined),
                              iconSize: 30,
                              padding: const EdgeInsets.all(10),
                              color: Colors.white,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  Color.fromARGB(255, 11, 110, 79),
                                ),
                              ),
                            ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
