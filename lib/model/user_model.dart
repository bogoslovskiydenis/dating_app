import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final int age;
  final List<dynamic> imageUrls;
  final List<dynamic> interests;
  final String bio;
  final String jobTitle;
  final String gender;
  final String location;

  const User({
    required this.gender,
    required this.location,
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.interests,
    required this.bio,
    required this.jobTitle,
  });

  @override
  List<Object?> get props =>
      [id, name, age, imageUrls, bio, gender, location, interests, jobTitle];

  static User fromDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    User user = User(
      id: snapshot.id,
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      gender: data['gender'] ?? '',
      location: data['location'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      bio: data['bio'] ?? '',
      interests: List<String>.from(data['interests'] ?? []),
      jobTitle: data['jobTitle'] ?? '',
    );
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'imageUrls': imageUrls,
      'interests': interests,
      'location': location,
      'bio': bio,
      'jobTitle': jobTitle,
    };
  }

  User copyWith({
    String? name,
    String? id,
    int? age,
    List<dynamic>? imageUrls,
    List<dynamic>? interests,
    String? bio,
    String? jobTitle,
    String? gender,
    String? location,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      imageUrls: imageUrls ?? this.imageUrls,
      interests: interests ?? this.interests,
      bio: bio ?? this.bio,
      jobTitle: jobTitle ?? this.jobTitle,
      location: location ?? this.location,
    );
  }

  static List<User> users = [
    const User(
      id: '1',
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
      gender: 'Male',
      location: 'Ukraine',
    ),
    const User(
      id: '2',
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
      location: 'Ukraine',
      gender: 'Famel',
    ),
    const User(
      id: '3',
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
      location: 'Ukraine',
      gender: 'Famel',
    ),
    const User(
      id: '4',
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
      location: 'Ukraine',
      gender: 'Famel',
    ),
    const User(
      id: '5',
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
      gender: 'Famel',
      location: 'Ukraine',
    ),
    const User(
      id: '6',
      name: 'Lisa',
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
      location: 'Ukraine',
      gender: 'Famel',
    ),
    const User(
      id: '7',
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
      gender: 'Famel',
      location: 'Ukraine',
    ),
    const User(
      id: '8',
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
      gender: 'Famel',
      location: 'Ukraine',
    ),
    const User(
      id: '9',
      name: 'Andrea',
      age: 35,
      imageUrls: [
        'https://picsum.photos/250?image=7',
        'https://picsum.photos/250?image=7',
        'https://picsum.photos/250?image=7',
        'https://picsum.photos/250?image=7',
        'https://picsum.photos/250?image=7',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
      gender: 'Famel',
      location: 'Ukraine',
    ),
    const User(
      id: '10',
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
      location: 'Ukraine',
      gender: 'Famel',
    ),
    const User(
      id: '11',
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
      gender: 'Famel',
      location: 'Ukraine',
    ),
    const User(
      id: ' 12',
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
      gender: 'Famel',
      location: 'Ukraine',
    ),
  ];
}
