import 'package:dating_app/model/user_match.dart';
import 'package:dating_app/screens/home/widget/custom_app_bar.dart';
import 'package:dating_app/screens/home/widget/user_small_image.dart';
import 'package:flutter/material.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  const MatchesScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => MatchesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();
    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Likes', style: Theme.of(context).textTheme.headline4),
              SizedBox(
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: inactiveMatches.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          UserImageSmall(
                            url:
                                inactiveMatches[index].matchedUser.imageUrls[0],
                          ),
                          Text(
                            inactiveMatches[index].matchedUser.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      );
                    }),
              ),
              Text(
                'Your Chats',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: activeMatches.length,
                    itemBuilder: (context, index) {
                      return InkWell( onTap: (){
                        Navigator.pushNamed(context,'/chat' ,arguments: activeMatches[index]);
                      },
                        child: Row(
                          children: [
                            UserImageSmall(
                              height: 70,
                              width: 70,
                              url: activeMatches[index].matchedUser.imageUrls[0],
                            ),
                            Column(
                              children: [
                                Text(activeMatches[index].matchedUser.name),
                                Text(activeMatches[index].chat![0].messages![0].message),
                                Text(activeMatches[index].chat![0].messages![0].timeString),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
