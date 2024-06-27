import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tattoo_social_app/app/theme/app_colors.dart';
import 'package:tattoo_social_app/data/models/post_model.dart';
import 'package:tattoo_social_app/data/providers/user_provider.dart';
import 'package:tattoo_social_app/services/post_service.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  List<XFile>? _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImages() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _selectedImages = pickedImages;
      });
    }
  }

  Future<void> _createPost() async {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final postService = Provider.of<PostService>(context, listen: false);
      final user = userProvider.currentUser!;

      final post = PostModel(
        id: '', // Post ID will be generated by Firebase
        userId: user.id!,
        content: _contentController.text,
        mediaUrls: _selectedImages?.map((image) => image.path).toList() ?? [],
        mediaTypes: _selectedImages?.map((image) => 'image').toList() ?? [],
        createdAt: DateTime.now(),
        likes: [],
        comments: [],
        user: user,
        reference: FirebaseFirestore.instance
            .collection('posts')
            .doc(), // Generate a new document reference
      );

      await postService.createPost(
        user: user, // Pass the user object
        content: _contentController.text, // Pass the content
        mediaUrls: post.mediaUrls, // Pass the media URLs
        mediaTypes: post.mediaTypes, // Pass the media types
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: _createPost,
            child: const Text(
              'Post',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Write your post',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectImages,
                child: const Text('Select Images'),
              ),
              const SizedBox(height: 16),
              if (_selectedImages != null && _selectedImages!.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages!.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        // Use the path to load the image
                        File(_selectedImages![index].path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
