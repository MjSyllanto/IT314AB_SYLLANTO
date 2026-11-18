
import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatelessWidget {
  final String image;
  final String name;
  final String course;
  final String yearLevel;
  final int age;
  final String hobby;
  final String studentId;
  final String email;
  final String favoriteSubject;
  final bool active;
  final bool isFavorite;
  final bool isPressed;

  final Function(
    String,
    String,
    String,
    String,
    int,
    String,
    String,
    String,
  ) onSave;

  const StudentDetailsScreen({
    super.key,
    required this.image,
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.age,
    required this.hobby,
    required this.studentId,
    required this.email,
    required this.favoriteSubject,
    required this.active,
    required this.isFavorite,
    required this.isPressed,
    required this.onSave,
  });

  void showEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final studentIdController =
        TextEditingController(text: studentId);
    final courseController = TextEditingController(text: course);
    final yearLevelController =
        TextEditingController(text: yearLevel);
    final ageController =
        TextEditingController(text: age.toString());
    final hobbyController = TextEditingController(text: hobby);
    final emailController = TextEditingController(text: email);
    final favoriteSubjectController =
        TextEditingController(text: favoriteSubject);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Edit Student $name'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: studentIdController,
                  decoration: const InputDecoration(
                    labelText: 'Student ID',
                  ),
                ),
                TextField(
                  controller: courseController,
                  decoration: const InputDecoration(
                    labelText: 'Course',
                  ),
                ),
                TextField(
                  controller: yearLevelController,
                  decoration: const InputDecoration(
                    labelText: 'Year Level',
                  ),
                ),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                TextField(
                  controller: hobbyController,
                  decoration: const InputDecoration(
                    labelText: 'Hobby',
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: favoriteSubjectController,
                  decoration: const InputDecoration(
                    labelText: 'Favorite Subject',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty ||
                    ageController.text.trim().isEmpty ||
                    int.tryParse(ageController.text) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please enter a valid name and age.',
                      ),
                    ),
                  );
                  return;
                }

                onSave(
                  nameController.text,
                  studentIdController.text,
                  courseController.text,
                  yearLevelController.text,
                  int.parse(ageController.text),
                  hobbyController.text,
                  emailController.text,
                  favoriteSubjectController.text,
                );

                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    ).then((_) {
      nameController.dispose();
      studentIdController.dispose();
      courseController.dispose();
      yearLevelController.dispose();
      ageController.dispose();
      hobbyController.dispose();
      emailController.dispose();
      favoriteSubjectController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Student Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(image, width: 130),
                const SizedBox(height: 20),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                ),
                const SizedBox(height: 20),
                Text('Student ID: $studentId'),
                const SizedBox(height: 10),
                Text('Course: $course'),
                const SizedBox(height: 10),
                Text('Year Level: $yearLevel'),
                const SizedBox(height: 10),
                Text('Age: $age'),
                const SizedBox(height: 10),
                Text('Hobby: $hobby'),
                const SizedBox(height: 10),
                Text('Email: $email'),
                const SizedBox(height: 10),
                Text('Favorite Subject: $favoriteSubject'),
                const SizedBox(height: 10),
                Text('Status: ${active ? 'Active' : 'Inactive'}'),
                const SizedBox(height: 10),
                Text('Favorite: ${isFavorite ? 'Yes' : 'No'}'),
                const SizedBox(height: 10),
                Text(
                  isPressed
                      ? 'Button Status: Button Pressed'
                      : 'Button Status: Not Pressed',
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    showEditDialog(context);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
