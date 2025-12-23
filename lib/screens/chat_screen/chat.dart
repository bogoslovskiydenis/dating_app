import 'package:flutter/material.dart';
import '../../model/user_match.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.userMatch}) : super(key: key);
  static const String routeName = '/chat';
  final UserMatch userMatch;

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
        builder: (context) => ChatScreen(userMatch: userMatch),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          title: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage(userMatch.matchedUser.imageUrls[0]),
                ),
                Text(
                  userMatch.matchedUser.name,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: userMatch.chat != null
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: userMatch.chat![0].messages!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: userMatch.chat![0].messages![index].senderId == 1
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .dialogBackgroundColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8.0))),
                                        child: Text(
                                          userMatch.chat![0]
                                              .messages![index].message,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        )),
                                  )
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              userMatch.matchedUser
                                                  .imageUrls[0]),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(
                                                            8.0)),
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Text(
                                              userMatch.chat![0]
                                                  .messages![index].message,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors.white),
                                            )),
                                      ],
                                    ),
                                  ),
                          );
                        })
                    : const SizedBox(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send),color: Colors.blue,),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Write message here',
                          contentPadding: EdgeInsets.only(
                              left: 20, bottom: 5, right: 5, top: 5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(8.0),),
                          ), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0),),),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
