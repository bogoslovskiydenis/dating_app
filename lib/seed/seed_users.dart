import 'package:dating_app/model/models.dart';
import 'package:dating_app/repository/database/db_repository.dart';

/// Тестовые пользователи для Firestore (только документы, без Auth).
/// Вызов [run] создаёт 10 женщин и 10 мужчин в коллекции users.
class SeedUsers {
  static const _bio =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
  static const _interests = ['Music', 'Travel', 'Sports', 'Movies', 'Reading'];

  static List<User> get testUsers => [
        ..._females,
        ..._males,
      ];

  static final List<User> _females = [
    _user('seed_f_1', 'Anna', 24, 'Female', 'Kiev', [
      'https://picsum.photos/seed/f1a/400/400',
      'https://picsum.photos/seed/f1b/400/400',
    ]),
    _user('seed_f_2', 'Maria', 26, 'Female', 'Lviv', [
      'https://picsum.photos/seed/f2a/400/400',
      'https://picsum.photos/seed/f2b/400/400',
    ]),
    _user('seed_f_3', 'Olga', 23, 'Female', 'Odessa', [
      'https://picsum.photos/seed/f3a/400/400',
    ]),
    _user('seed_f_4', 'Kateryna', 28, 'Female', 'Kharkiv', [
      'https://picsum.photos/seed/f4a/400/400',
      'https://picsum.photos/seed/f4b/400/400',
    ]),
    _user('seed_f_5', 'Yulia', 25, 'Female', 'Dnipro', [
      'https://picsum.photos/seed/f5a/400/400',
    ]),
    _user('seed_f_6', 'Natalia', 27, 'Female', 'Kiev', [
      'https://picsum.photos/seed/f6a/400/400',
      'https://picsum.photos/seed/f6b/400/400',
    ]),
    _user('seed_f_7', 'Iryna', 22, 'Female', 'Lviv', [
      'https://picsum.photos/seed/f7a/400/400',
    ]),
    _user('seed_f_8', 'Tetiana', 29, 'Female', 'Odessa', [
      'https://picsum.photos/seed/f8a/400/400',
      'https://picsum.photos/seed/f8b/400/400',
    ]),
    _user('seed_f_9', 'Sofia', 24, 'Female', 'Kiev', [
      'https://picsum.photos/seed/f9a/400/400',
    ]),
    _user('seed_f_10', 'Daria', 26, 'Female', 'Kharkiv', [
      'https://picsum.photos/seed/f10a/400/400',
      'https://picsum.photos/seed/f10b/400/400',
    ]),
  ];

  static final List<User> _males = [
    _user('seed_m_1', 'Oleh', 25, 'Male', 'Kiev', [
      'https://picsum.photos/seed/m1a/400/400',
      'https://picsum.photos/seed/m1b/400/400',
    ]),
    _user('seed_m_2', 'Andrii', 27, 'Male', 'Lviv', [
      'https://picsum.photos/seed/m2a/400/400',
    ]),
    _user('seed_m_3', 'Dmytro', 24, 'Male', 'Odessa', [
      'https://picsum.photos/seed/m3a/400/400',
      'https://picsum.photos/seed/m3b/400/400',
    ]),
    _user('seed_m_4', 'Serhii', 28, 'Male', 'Kharkiv', [
      'https://picsum.photos/seed/m4a/400/400',
    ]),
    _user('seed_m_5', 'Vitalii', 26, 'Male', 'Dnipro', [
      'https://picsum.photos/seed/m5a/400/400',
      'https://picsum.photos/seed/m5b/400/400',
    ]),
    _user('seed_m_6', 'Ivan', 23, 'Male', 'Kiev', [
      'https://picsum.photos/seed/m6a/400/400',
    ]),
    _user('seed_m_7', 'Mykyta', 25, 'Male', 'Lviv', [
      'https://picsum.photos/seed/m7a/400/400',
      'https://picsum.photos/seed/m7b/400/400',
    ]),
    _user('seed_m_8', 'Yurii', 29, 'Male', 'Odessa', [
      'https://picsum.photos/seed/m8a/400/400',
    ]),
    _user('seed_m_9', 'Pavlo', 24, 'Male', 'Kiev', [
      'https://picsum.photos/seed/m9a/400/400',
      'https://picsum.photos/seed/m9b/400/400',
    ]),
    _user('seed_m_10', 'Bohdan', 27, 'Male', 'Kharkiv', [
      'https://picsum.photos/seed/m10a/400/400',
    ]),
  ];

  static User _user(
    String id,
    String name,
    int age,
    String gender,
    String location,
    List<String> imageUrls,
  ) {
    return User(
      id: id,
      name: name,
      age: age,
      gender: gender,
      location: location,
      imageUrls: imageUrls,
      interests: _interests,
      bio: _bio,
      jobTitle: 'Developer',
    );
  }

  /// Создаёт 20 тестовых пользователей в Firestore.
  /// Дубликаты по id перезапишут документ (set).
  static Future<void> run(DatabaseRepository repo) async {
    for (final user in testUsers) {
      await repo.createUser(user);
    }
  }
}
