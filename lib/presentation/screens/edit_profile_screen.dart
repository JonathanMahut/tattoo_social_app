import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tattoo_social_app/data/models/user_model.dart';
import 'package:tattoo_social_app/data/providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;

  File? _imageFile;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final UserModel? user = userProvider.currentUser;

    if (user != null) {
      _usernameController = TextEditingController(text: user.username);
      _bioController = TextEditingController(text: user.bio ?? '');
      _phoneController = TextEditingController(text: user.phoneNumber ?? '');
      _addressController =
          TextEditingController(text: user.postalAddress ?? '');
      _cityController = TextEditingController(text: user.city ?? '');
      _countryController = TextEditingController(text: user.country ?? '');
      _profileImageUrl = user.profileImageUrl;
    } else {
      // Initialiser avec des valeurs par défaut si l'utilisateur n'est pas disponible
      _usernameController = TextEditingController();
      _bioController = TextEditingController();
      _phoneController = TextEditingController();
      _addressController = TextEditingController();
      _cityController = TextEditingController();
      _countryController = TextEditingController();
    }

    // Si vous voulez charger les données de l'utilisateur de manière asynchrone :
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      await userProvider
          .refreshUser(); // Assurez-vous que cette méthode existe dans votre UserProvider
      final UserModel? user = userProvider.currentUser;
      if (user != null) {
        setState(() {
          _usernameController.text = user.username;
          _bioController.text = user.bio ?? '';
          _phoneController.text = user.phoneNumber ?? '';
          _addressController.text = user.postalAddress ?? '';
          _cityController.text = user.city ?? '';
          _countryController.text = user.country ?? '';
          _profileImageUrl = user.profileImageUrl;
        });
      }
    } catch (e) {
      print('Erreur lors du chargement des données utilisateur: $e');
      // Gérer l'erreur (par exemple, afficher un message à l'utilisateur)
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File? croppedFile = await _cropImage(File(image.path));
      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
        });
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recadrer l\'image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        IOSUiSettings(
          title: 'Recadrer l\'image',
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    try {
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      final UploadTask uploadTask = storageRef.putFile(_imageFile!);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (_profileImageUrl != null
                        ? NetworkImage(_profileImageUrl!)
                        : null) as ImageProvider?,
                child: _imageFile == null && _profileImageUrl == null
                    ? const Icon(Icons.add_a_photo, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: 'Bio'),
              maxLines: 3,
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(labelText: 'Country'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    String? imageUrl = _profileImageUrl;
    if (_imageFile != null) {
      imageUrl = await _uploadImage();
    }

    final updatedUser = userProvider.currentUser!.copyWith(
      username: _usernameController.text,
      bio: _bioController.text,
      phoneNumber: _phoneController.text,
      postalAddress: _addressController.text,
      city: _cityController.text,
      country: _countryController.text,
      profileImageUrl: imageUrl,
    );

    await userProvider.updateUser(updatedUser);

    Navigator.pop(context);
  }
}
