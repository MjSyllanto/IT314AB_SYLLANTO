import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My First Flutter Project',
      home: const ProfilePage(),
    );
  }
}

// PROFILE DATA
class Profile {
  final String image;
  final String? name;
  final String? courseSection;
  final int? age;
  final String? hobby;

  const Profile({
    required this.image,
    this.name,
    this.courseSection,
    this.age,
    this.hobby,
  });
}

// FIVE DIFFERENT PROFILES
const List<Profile> profiles = [
  // PROFILE 1 - COMPLETE DATA
  Profile(
    image: 'assets/emji.jpg',
    name: 'Emji Silento',
    courseSection: 'BSIT-3',
    age: 20,
    hobby: 'Drinking Secret',
  ),

  // PROFILE 2 - EMPTY HOBBY
  Profile(
    image: 'assets/marianne.jpg',
    name: 'Maryan Gridwan',
    courseSection: 'BSIT-3',
    age: 21,
    hobby: '',
  ),

  // PROFILE 3 - NULL COURSE
  Profile(
    image: 'assets/mav1.jpg',
    name: 'Mav Sumalangitka',
    courseSection: null,
    age: 19,
    hobby: 'Dancing',
  ),

  // PROFILE 4 - NOT PROVIDED
  Profile(
    image: 'assets/chim.PNG',
    name: 'Chim Boop',
    courseSection: 'Not provided',
    age: 20,
    hobby: 'Hobby Tanan',
  ),

  // PROFILE 5 - MISSING HOBBY
  Profile(
    image: 'assets/krylle.PNG',
    name: 'Karylle Buta',
    courseSection: 'BSIS-3',
    age: 21,
    hobby: null,
  ),
];

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My First Flutter Project'),
        centerTitle: true,
      ),

      // SCROLLING WIDGET
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];

          return ProfileCard(profile: profile);
        },
      ),
    );
  }
}

// SAME DESIGN FOR ALL PROFILES
class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 20),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // IMAGE
            Image.asset(
              profile.image,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 15),

            // NAME
            Text(
              profile.name ?? 'Name: Not specified',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // COURSE & SECTION
            Text(
              profile.courseSection ?? 'Course & Section: Not specified',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // AGE
            Text(
              profile.age?.toString() ?? "Age: Not specified",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 8),

            // HOBBY
            Text(
              profile.hobby ?? "Hobby: Not specified",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}