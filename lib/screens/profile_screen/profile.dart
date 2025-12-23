import 'package:dating_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:dating_app/bloc/profile/profile_bloc.dart';
import 'package:dating_app/repository/auth/auth_repo.dart';
import 'package:dating_app/screens/home/home_screen.dart';
import 'package:dating_app/screens/login_screen/logn_screen.dart';
import 'package:dating_app/screens/profile_screen/widgets/title_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/profile/profile_state.dart';
import '../../model/models.dart';
import '../home/widget/home.dart';

class ProfileScreen extends StatelessWidget implements PreferredSizeWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return (BlocProvider.of<AuthBloc>(context).state.status ==
              AuthStatus.unauthenticated)
              ? const LoginScreen()
              : const ProfileScreen();
        });
  }

  void _editBio(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Biography'),
        content: TextField(
          controller: TextEditingController(text: user.bio),
          decoration: const InputDecoration(hintText: 'Enter your bio'),
          onChanged: (value) {
            context.read<ProfileBloc>().add(
              UpdateProfile(
                user: user.copyWith(bio: value),
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editLocation(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Location'),
        content: TextField(
          controller: TextEditingController(text: user.location),
          decoration: const InputDecoration(hintText: 'Enter your location'),
          onChanged: (value) {
            context.read<ProfileBloc>().add(
              UpdateProfile(
                user: user.copyWith(location: value),
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editInterests(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Interests'),
        content: Wrap(
          spacing: 8.0,
          children: [
            'Music',
            'Sports',
            'Travel',
            'Reading',
            'Gaming',
            'Cooking',
            'Photography',
            'Art',
            'Movies',
            'Dancing'
          ].map((interest) {
            bool isSelected = user.interests.contains(interest);
            return FilterChip(
              selected: isSelected,
              label: Text(interest),
              onSelected: (selected) {
                List<String> updatedInterests = [...user.interests];
                if (selected) {
                  updatedInterests.add(interest);
                } else {
                  updatedInterests.remove(interest);
                }
                context.read<ProfileBloc>().add(
                  UpdateProfile(
                    user: user.copyWith(interests: updatedInterests),
                  ),
                );
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Future<void> _addImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // ignore: use_build_context_synchronously
      // context.read<ProfileBloc>().add(UpdateUserImages(image: image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: GestureDetector(
          child: const CustomAppBar(
            title: "Profile",
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
          },
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(3, 3),
                              spreadRadius: 3,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                state.user.imageUrls.isNotEmpty
                                    ? state.user.imageUrls[0]
                                    : 'https://via.placeholder.com/150'),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor.withOpacity(0.1),
                              Theme.of(context).primaryColor.withOpacity(0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            state.user.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWithIcon(
                          title: 'Biography',
                          icon: Icons.edit,
                          onPressed: () => _editBio(context, state.user),
                        ),
                        Text(state.user.bio,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(height: 1.5)),
                        TitleWithIcon(
                          title: 'Pictures',
                          icon: Icons.add_a_photo,
                          onPressed: () => _addImage(context),
                        ),
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.user.imageUrls.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            state.user.imageUrls[index]),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        TitleWithIcon(
                          title: 'Location',
                          icon: Icons.edit,
                          onPressed: () => _editLocation(context, state.user),
                        ),
                        Text(state.user.location,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(height: 1.5)),
                        TitleWithIcon(
                          title: 'Interests',
                          icon: Icons.edit,
                          onPressed: () => _editInterests(context, state.user),
                        ),
                        Wrap(
                          children: state.user.interests.map((interest) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Chip(label: Text(interest)),
                            );
                          }).toList(),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(const AuthLogoutRequested());
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                                  (route) => false,
                            );
                          },
                          child: Center(
                            child: Text(
                              'Sign Out',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      final userId = context.read<AuthBloc>().state.user?.uid;
                      if (userId != null) {
                        context
                            .read<ProfileBloc>()
                            .add(LoadProfile(userId: userId));
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}