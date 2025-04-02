import 'package:flutter/material.dart';
import 'package:tech_link/model/user.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tech_link/providers/user_provider.dart';

class EditProfileDialog extends StatefulWidget {
  final User? user;
  final String aboutText;
  final Function(String username, String email, String phone, String about)
  onUpdate;

  const EditProfileDialog({
    Key? key,
    required this.user,
    this.aboutText = "",
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String? _usernameError;
  String? _phoneError;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: widget.user?.username ?? "",
    );
    _phoneController = TextEditingController(
      text: widget.user?.contactNumber ?? "",
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _validateUsername() {
    if (_usernameController.text.trim().isEmpty) {
      setState(() {
        _usernameError = 'Username cannot be empty';
      });
      return false;
    } else if (_usernameController.text.trim().length < 3) {
      setState(() {
        _usernameError = 'Username must be at least 3 characters';
      });
      return false;
    } else {
      setState(() {
        _usernameError = null;
      });
      return true;
    }
  }

  bool _validatePhone() {
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (_phoneController.text.trim().isEmpty) {
      setState(() {
        _phoneError = 'Phone number cannot be empty';
      });
      return false;
    } else if (!phoneRegex.hasMatch(_phoneController.text.trim())) {
      setState(() {
        _phoneError = 'Enter a valid 10-digit phone number';
      });
      return false;
    } else {
      setState(() {
        _phoneError = null;
      });
      return true;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Select Image Source"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    child: CircleAvatar(
                      radius: 84,
                      backgroundColor: Color.fromARGB(255, 7, 59, 58),
                      child: CircleAvatar(
                        radius: 78.0,
                        backgroundImage:
                            _imageFile != null
                                ? FileImage(_imageFile!) as ImageProvider
                                : (context
                                                .watch<UserProvider>()
                                                .user
                                                ?.profilePictureURL !=
                                            "" &&
                                        context
                                                .watch<UserProvider>()
                                                .user
                                                ?.profilePictureURL !=
                                            null
                                    ? NetworkImage(
                                      context
                                          .watch<UserProvider>()
                                          .user!
                                          .profilePictureURL,
                                    )
                                    : const AssetImage('assets/logo_bg.png')),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (_imageFile == null)
                                IconButton(
                                  onPressed: _showImageSourceDialog,
                                  icon: const Icon(Icons.add_a_photo_rounded),
                                  iconSize: 30,
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.white,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 7, 59, 58),
                                        ),
                                  ),
                                ),
                              if (_imageFile != null)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _imageFile = null;
                                    });
                                    context.read<UserProvider>().clearImage();
                                  },
                                  icon: const Icon(Icons.cancel_outlined),
                                  iconSize: 30,
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.white,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 7, 59, 58),
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText: _usernameError,
              ),
              onChanged: (_) {
                if (_usernameError != null) {
                  _validateUsername();
                }
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText: _phoneError,
                hintText: '10-digit number',
              ),
              keyboardType: TextInputType.phone,
              onChanged: (_) {
                if (_phoneError != null) {
                  _validatePhone();
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Color.fromARGB(255, 7, 59, 58)),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final isUsernameValid = _validateUsername();
            final isPhoneValid = _validatePhone();

            if (isUsernameValid && isPhoneValid) {
              FocusScope.of(context).unfocus();
              await context.read<UserProvider>().updateUserDetails(
                username: _usernameController.text.trim(),
                contactNumber: _phoneController.text.trim(),
                newProfileImage: _imageFile,
              );
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                context.watch<UserProvider>().isLoading
                    ? Colors.grey
                    : Color.fromARGB(255, 7, 59, 58),
            foregroundColor: Colors.white,
          ),
          child:
              context.watch<UserProvider>().isLoading
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                  : Text('Update Profile'),
        ),
      ],
    );
  }
}
