import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/profile/profile_bloc.dart';
import '../../services/services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return Scaffold(
        body: Center(child: Text('Please log in to view your profile')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc(ProfileService(FirebaseFirestore.instance))
          ..add(LoadProfileEvent(userId)),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: state.profile['imageUrl'] != null 
                        ? NetworkImage(state.profile['imageUrl']) 
                        : null,
                      backgroundColor: Colors.transparent,
                      child: state.profile['imageUrl'] == null
                          ? Icon(Icons.account_circle_rounded, size: 100, color: Colors.yellow[700])
                          : null,
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          final file = File(pickedFile.path); // Pastikan path file valid
                          try {
                            final storageRef = FirebaseStorage.instance.ref().child('profile_images/$userId');
                            final uploadTask = storageRef.putFile(file);
                            final snapshot = await uploadTask;
                            final imageUrl = await snapshot.ref.getDownloadURL();

                            context.read<ProfileBloc>().add(UpdateProfileImageEvent(userId, imageUrl));
                          } catch (e) {
                            print('Error uploading image: $e');
                          }
                        }
                      },
                      child: const Text('Ubah Foto Profil', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              const Text('Info Profil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(Icons.info_outline),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('Nama             ', style: TextStyle(color: Colors.grey)),
                              Expanded(
                                child: SelectableText('${state.profile['name']['firstName']} ${state.profile['name']['lastName']}'),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  final newName = await showDialog<String>(
                                    context: context,
                                    builder: (context) => NameInputDialog(
                                      initialName: '${state.profile['name']['firstName']} ${state.profile['name']['lastName']}',
                                    ),
                                  );
                                  if (newName != null && newName.isNotEmpty) {
                                    context.read<ProfileBloc>().add(UpdateProfileEvent(userId, newName));
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No profile data available.'));
            }
          },
        ),
      ),
    );
  }
}

class NameInputDialog extends StatelessWidget {
  final String initialName;

  NameInputDialog({required this.initialName});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(text: initialName);

    return AlertDialog(
      title: const Text('Update Name'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: "Enter new name"),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Update'),
          onPressed: () {
            Navigator.of(context).pop(_controller.text);
          },
        ),
      ],
    );
  }
}


