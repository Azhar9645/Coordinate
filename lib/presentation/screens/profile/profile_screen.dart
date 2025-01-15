import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final String? profilePictureUrl;

  ProfileScreen({Key? key, this.profilePictureUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture Section
            GestureDetector(
              onTap: () {
                // Add logic to change the profile picture
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage: profilePictureUrl != null
                    ? NetworkImage(profilePictureUrl!)
                    : null,
                child: profilePictureUrl == null
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            // Name Text Field
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
            const SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Add save functionality here
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
