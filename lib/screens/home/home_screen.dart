import 'package:dating_app/bloc/swipe_bloc/swipe_bloc.dart';
import 'package:dating_app/screens/home/widget/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_model.dart';
import '../user_screen/widgets/user_card.dart';

class HomeScreen extends StatelessWidget with PreferredSizeWidget{
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'DATING',
      ),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onDoubleTap: () {
                      Navigator.pushNamed(context, '/users',
                          arguments: state.users[0]);
                    },
                    child: Draggable<User>(
                      child: UserCard(
                        user: state.users[0],
                      ),
                      feedback: UserCard(
                        user: state.users[0],
                      ),
                      childWhenDragging: UserCard(
                        user: state.users[1],
                      ),
                      onDragEnd: (drag) {
                        if (drag.velocity.pixelsPerSecond.dx < 0) {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeLeftEvent(user: state.users[0]));
                          print('left');
                        } else {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeRightEvent(user: state.users[0]));
                          print('right');
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<SwipeBloc>()
                                .add(SwipeLeftEvent(user: state.users[0]));
                            print('left');
                          },
                          child: ChoiceButton(
                            color: Theme.of(context).colorScheme.secondary,
                            icon: Icons.clear_rounded,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              context
                                  .read<SwipeBloc>()
                                  .add(SwipeLeftEvent(user: state.users[0]));
                              print('right');
                            },
                            child: ChoiceButton(
                              color: Theme.of(context).colorScheme.secondary,
                              icon: Icons.favorite,
                            )),
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
          } else {
            return const Text('Error');
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
