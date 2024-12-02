import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../application/profile_bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false; // Track whether in edit mode or not
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc()..add(GetProfileEvent()),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is EditProfile) {
              BlocProvider.of<ProfileBloc>(context)
                  .add(GetProfileEvent());
              setState(() {
                isEditing = false;
              });
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Profile Updated');
            } else if (state is ProfileFailed) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.message.toString());
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                nameController.text = state.model.user!.name ?? "";
                final email = state.model.user!.email ?? "";

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            'assets/avatar.png'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: nameController,
                        enabled: isEditing,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: TextEditingController(text: email),
                        enabled: false, // Email is not editable
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (isEditing) {
                            final newName = nameController.text.trim();
                            if (newName.isNotEmpty) {
                              context
                                  .read<ProfileBloc>()
                                  .add(EditProfileEvent(name: newName));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Name cannot be empty!")),
                              );
                            }
                          } else {
                            setState(() {
                              isEditing = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(isEditing ? "Save" : "Edit Profile"),
                      ),
                    ],
                  ),
                );
              } else if (state is ProfileFailed) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text("Something went wrong!"));
              }
            },
          ),
        ),
      ),
    );
  }
}
