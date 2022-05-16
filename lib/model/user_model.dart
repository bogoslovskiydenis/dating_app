import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<dynamic> imageUrls;
  final List<dynamic> interests;
  final String bio;
  final String jobTitle;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.interests,
    required this.bio,
    required this.jobTitle,
  });

  @override
  List<Object?> get props => [id, name, age, imageUrls, bio];

  static User fromSnapshot(DocumentSnapshot snapshot){
    User user = User(
        id: snapshot['id'],
        name: snapshot['name'],
        age: snapshot['age'],
        imageUrls: snapshot['imageUrls'],
        bio: snapshot['bio'],
        interests:snapshot['interests'],
        jobTitle: snapshot['jobTitle'],
        );
    return user;
  }

  static List<User> users = [
    User(
      id: 1,
      name: 'John',
      age: 25,
      imageUrls: [
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 2,
      name: 'Tamara',
      age: 30,
      imageUrls: [
        'https://picsum.photos/250?image=1',
        'https://picsum.photos/250?image=1',
        'https://picsum.photos/250?image=1',
        'https://picsum.photos/250?image=1',
        'https://picsum.photos/250?image=1',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 3,
      name: 'Marta',
      age: 35,
      imageUrls: [
        'https://picsum.photos/250?image=2',
        'https://picsum.photos/250?image=2',
        'https://picsum.photos/250?image=2',
        'https://picsum.photos/250?image=2',
        'https://picsum.photos/250?image=2',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 4,
      name: 'Sara',
      age: 30,
      imageUrls: [
        'https://picsum.photos/250?image=3',
        'https://picsum.photos/250?image=3',
        'https://picsum.photos/250?image=3',
        'https://picsum.photos/250?image=3',
        'https://picsum.photos/250?image=3',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 5,
      name: 'Anna',
      age: 35,
      imageUrls: [
        'https://picsum.photos/250?image=4',
        'https://picsum.photos/250?image=4',
        'https://picsum.photos/250?image=4',
        'https://picsum.photos/250?image=4',
        'https://picsum.photos/250?image=4',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 6,
      name: 'Lisa',
      age: 35,
      imageUrls: [
        'https://picsum.photos/250?image=5',
        'https://picsum.photos/250?image=5',
        'https://picsum.photos/250?image=5',
        'https://picsum.photos/250?image=5',
        'https://picsum.photos/250?image=5',],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 7,
      name: 'Luisa',
      age: 35,
      imageUrls: [
        'https://picsum.photos/250?image=5',
        'https://picsum.photos/250?image=5',
        'https://picsum.photos/250?image=5',
        'https://picsum.photos/250?image=5',
        'https://picsum.photos/250?image=5',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 8,
      name: 'Sara',
      age: 35,
      imageUrls: [
        'https://picsum.photos/250?image=6',
        'https://picsum.photos/250?image=6',
        'https://picsum.photos/250?image=6',
        'https://picsum.photos/250?image=6',
        'https://picsum.photos/250?image=6',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 9,
      name: 'Andrea',
      age: 35,
      imageUrls: [ 'https://picsum.photos/250?image=7',
        'https://picsum.photos/250?image=7',
        'https://picsum.photos/250?image=7',
        'https://picsum.photos/250?image=7',
        'https://picsum.photos/250?image=7',],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 10,
      name: 'Mary',
      age: 35,
      imageUrls: [
        'https://picsum.photos/250?image=8',
        'https://picsum.photos/250?image=8',
        'https://picsum.photos/250?image=8',
        'https://picsum.photos/250?image=8',
        'https://picsum.photos/250?image=8',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 11,
      name: 'Denise',
      age: 35,
      imageUrls: [
        'https://picsum.photos/250?image=10',
        'https://picsum.photos/250?image=10',
        'https://picsum.photos/250?image=10',
        'https://picsum.photos/250?image=10',
        'https://picsum.photos/250?image=10',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: 12,
      name: 'Elle',
      age: 35,
      imageUrls: [
        'https://picsum.photos/250?image=12',
        'https://picsum.photos/250?image=12',
        'https://picsum.photos/250?image=12',
        'https://picsum.photos/250?image=12',
        'https://picsum.photos/250?image=12',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
  ];
}
