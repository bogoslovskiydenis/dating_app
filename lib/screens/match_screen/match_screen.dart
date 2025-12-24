import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../model/match_model.dart';
import '../../model/models.dart';
import '../../repository/database/db_repository.dart';
import '../chat_screen/chat.dart';
import '../home/home_screen.dart';
import '../home/widget/home.dart';
import '../user_screen/widgets/user_small_image.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  const MatchesScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const MatchesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthBloc>().state.user?.uid;
    final databaseRepository = context.read<DatabaseRepository>();

    if (currentUserId == null) {
      return const Scaffold(
        body: Center(child: Text('Not authenticated')),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: GestureDetector(
          child: const CustomAppBar(
            title: "Match",
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: StreamBuilder<List<Match>>(
        stream: databaseRepository.getMatches(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final error = snapshot.error.toString();
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ошибка загрузки матчей',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.contains('permission-denied')
                          ? 'Нет доступа к базе данных. Необходимо настроить правила безопасности Firestore.'
                          : 'Error: $error',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    if (error.contains('permission-denied')) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Как исправить:',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '1. Откройте Firebase Console\n'
                              '2. Перейдите в Firestore Database\n'
                              '3. Откройте вкладку "Rules"\n'
                              '4. Добавьте правила доступа для коллекции "matches"',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Назад'),
                        ),
                        if (error.contains('permission-denied'))
                          const SizedBox(width: 12),
                        if (error.contains('permission-denied'))
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const MatchesScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text('Повторить'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          final matches = snapshot.data ?? [];

          if (matches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Пока нет взаимных симпатий',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Продолжайте свайпать, чтобы найти совпадения!',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Chats',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      final match = matches[index];
                      final otherUserId = match.userId1 == currentUserId
                          ? match.userId2
                          : match.userId1;

                      return StreamBuilder<User>(
                        stream: databaseRepository.getUser(otherUserId),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState == ConnectionState.waiting) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 12),
                                  Text('Загрузка...'),
                                ],
                              ),
                            );
                          }

                          if (userSnapshot.hasError) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.error_outline, color: Colors.red[300]),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Ошибка загрузки пользователя',
                                      style: TextStyle(color: Colors.red[700]),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (!userSnapshot.hasData) {
                            return const SizedBox.shrink();
                          }

                          final matchedUser = userSnapshot.data!;
                          return StreamBuilder<Chat>(
                            stream: databaseRepository.getChat(match.chatId),
                            builder: (context, chatSnapshot) {
                              final chat = chatSnapshot.data;
                              final lastMessage = chat?.lastMessage ?? '';
                              final lastMessageTime = chat?.lastMessageTime;
                              
                              if (chatSnapshot.hasError) {
                                print('Error loading chat: ${chatSnapshot.error}');
                              }

                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    ChatScreen.routeName,
                                    arguments: {
                                      'chatId': match.chatId,
                                      'matchedUser': matchedUser,
                                    },
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      UserImageSmall(
                                        height: 70,
                                        width: 70,
                                        url: matchedUser.imageUrls.isNotEmpty
                                            ? matchedUser.imageUrls[0]
                                            : '',
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              matchedUser.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const SizedBox(height: 4),
                                            if (lastMessage.isNotEmpty)
                                              Text(
                                                lastMessage,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            else
                                              Text(
                                                'Start conversation',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.grey,
                                                    ),
                                              ),
                                            if (lastMessageTime != null)
                                              Text(
                                                DateFormat('jm').format(
                                                  lastMessageTime,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontSize: 10,
                                                      color: Colors.grey[600],
                                                    ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
