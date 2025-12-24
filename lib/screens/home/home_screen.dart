import 'package:dating_app/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:dating_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:dating_app/screens/home/widget/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_model.dart';
import '../user_screen/widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState.status == AuthStatus.authenticated && authState.user != null) {
        context.read<SwipeBloc>().add(
          LoadUsers(currentUserId: authState.user!.uid),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'DATING',
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState.status == AuthStatus.authenticated && authState.user != null) {
            context.read<SwipeBloc>().add(
              LoadUsers(currentUserId: authState.user!.uid),
            );
          }
        },
        child: BlocListener<SwipeBloc, SwipeState>(
          listener: (context, state) {
            if (state is SwipeMatchCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Это взаимная симпатия! 🎉'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'Посмотреть',
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/matches');
                    },
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<SwipeBloc, SwipeState>(
          builder: (context, state) {
            if (state is SwipeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SwipeLoaded || state is SwipeMatchCreated) {
              final users = state is SwipeLoaded
                  ? state.users
                  : (state as SwipeMatchCreated).users;
              // Добавляем проверку на пустой список
              if (users.isEmpty) {
                return Center(
                  child: Text(
                    'No more users to show!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Navigator.pushNamed(
                          context,
                          '/users',
                          arguments: users[0],
                        );
                      },
                      child: Draggable<User>(
                        child: UserCard(user: users[0]),
                        feedback: UserCard(user: users[0]),
                        childWhenDragging: users.length > 1
                            ? UserCard(user: users[1])
                            : Container(),
                        onDragEnd: (drag) {
                          final authBloc = context.read<AuthBloc>();
                          final currentUserId = authBloc.state.user?.uid;
                          
                          if (drag.velocity.pixelsPerSecond.dx < 0) {
                            context
                                .read<SwipeBloc>()
                                .add(SwipeLeftEvent(user: users[0]));
                          } else {
                            context
                                .read<SwipeBloc>()
                                .add(SwipeRightEvent(
                                  user: users[0],
                                  currentUserId: currentUserId,
                                ));
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 50,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context
                                  .read<SwipeBloc>()
                                  .add(SwipeLeftEvent(user: users[0]));
                            },
                            child: ChoiceButton(
                              color: Theme.of(context).colorScheme.secondary,
                              icon: Icons.clear_rounded,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final swipeBloc = context.read<SwipeBloc>();
                              final authBloc = context.read<AuthBloc>();
                              final currentUserId = authBloc.state.user?.uid;
                              
                              if (currentUserId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please login first'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              
                              swipeBloc.add(SwipeRightEvent(
                                user: users[0],
                                currentUserId: currentUserId,
                              ));
                            },
                            child: ChoiceButton(
                              color: Theme.of(context).colorScheme.secondary,
                              icon: Icons.favorite,
                            ),
                          ),
                          ChoiceButton(
                            color: Theme.of(context).colorScheme.secondary,
                            icon: Icons.watch_later_outlined,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SwipeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Something went wrong!'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final authState = context.read<AuthBloc>().state;
                        if (authState.status == AuthStatus.authenticated && authState.user != null) {
                          context.read<SwipeBloc>().add(
                            LoadUsers(currentUserId: authState.user!.uid),
                          );
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong!'));
            }
          },
        ),
      )
    ),
    );
  }
}
