import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tattoo_social_app/data/models/enums/user_type.dart';
import 'package:tattoo_social_app/data/models/user_model.dart';
import 'package:tattoo_social_app/data/providers/user_provider.dart';
import 'package:tattoo_social_app/presentation/screens/create_post_screen.dart';
import 'package:tattoo_social_app/presentation/screens/create_tattoo_screen.dart'; // Import for creating tattoos
import 'package:tattoo_social_app/presentation/screens/edit_profile_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final UserModel user = userProvider.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: user.profileImageUrl != null
                    ? NetworkImage(user.profileImageUrl!)
                    : null,
                child: user.profileImageUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.username,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              user.userType.toString().split('.').last,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildInfoTile('Email', user.email),
            _buildInfoTile('Bio', user.bio ?? 'No bio provided'),
            _buildInfoTile('Phone', user.phoneNumber ?? 'Not provided'),
            _buildInfoTile('Address', user.postalAddress ?? 'Not provided'),
            _buildInfoTile('City', user.city ?? 'Not provided'),
            _buildInfoTile('Country', user.country ?? 'Not provided'),
            _buildInfoTile('Language', user.language),
            _buildInfoTile('Subscription',
                user.subscriptionType.toString().split('.').last),
            if (user.userType == UserType.tattooArtist) ...[
              const SizedBox(height: 16),
              Text('Specialties',
                  style: Theme.of(context).textTheme.titleLarge),
              Wrap(
                spacing: 8,
                children: user.specialties
                        ?.map((specialty) => Chip(label: Text(specialty)))
                        .toList() ??
                    [],
              ),
            ],
            if (user.userType != UserType.client) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePostPage(),
                    ),
                  );
                },
                child: const Text('Create Post'),
              ),
            ],
            if (user.userType == UserType.tattooArtist) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateTattooScreen(),
                    ),
                  );
                },
                child: const Text('Add Tattoo'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
