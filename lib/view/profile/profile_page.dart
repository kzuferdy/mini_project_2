import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../logic/profile/profile_bloc.dart';
import '../../services/services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc(ProfileService(http.Client()))..add(LoadProfileEvent()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoadedState) {
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  // Profile Picture Section
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.account_circle_rounded, size: 100, color: Colors.yellow[700]),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        // Handle the on tap event here
                      },
                      child: Text('Ubah Foto Profil', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Profile Info Section
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
                                child: SelectableText('${state.profile.name.firstname.toUpperCase()} ${state.profile.name.lastname.toUpperCase()}'),
                              ),
                              IconButton(
                                icon: Icon(Icons.navigate_next_rounded),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('Username      ', style: TextStyle(color: Colors.grey)),
                              Expanded(
                                child: SelectableText('${state.profile.username}'),
                              ),
                              IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: state.profile.username));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Username copied to clipboard')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Personal Info Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              const Text('Info Pribadi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(Icons.info_outline),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('E-mail              ', style: TextStyle(color: Colors.grey)),
                              Expanded(
                                child: SelectableText('${state.profile.email}'),
                              ),
                              IconButton(
                                icon: Icon(Icons.navigate_next_rounded),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('Nomor HP      ', style: TextStyle(color: Colors.grey)),
                              Expanded(
                                child: SelectableText('${state.profile.phone}'),
                              ),
                              IconButton(
                                icon: Icon(Icons.navigate_next_rounded),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('Alamat            ', style: TextStyle(color: Colors.grey)),
                              Expanded(
                                child: SelectableText('${state.profile.address.city}, ${state.profile.address.street}, ${state.profile.address.number}, ${state.profile.address.zipcode}'),
                              ),
                              IconButton(
                                icon: Icon(Icons.navigate_next_rounded),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Action Buttons Section
                  Center(
                    child: InkWell(
                      onTap: () {
                        // Handle the on tap event here
                      },
                      child: Text('Tutup Akun', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              );
            } else if (state is ProfileErrorState) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: Text('No profile data available or FetchProfile event has not been dispatched.'));
            }
          },
        ),
      ),
    );
  }
}
