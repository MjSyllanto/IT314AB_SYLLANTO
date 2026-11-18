
import 'package:flutter/material.dart';
import 'student_list_screen.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() =>
      _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final studentIdController = TextEditingController();
  final nameController = TextEditingController();
  final courseController = TextEditingController();
  final yearLevelController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    studentIdController.dispose();
    nameController.dispose();
    courseController.dispose();
    yearLevelController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // ADD AND SAVE STUDENT
  Future<void> addStudent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Student newStudent = Student(
      image: '',
      name: nameController.text.trim(),
      course: courseController.text.trim(),
      yearLevel: yearLevelController.text.trim(),
      age: 0,
      hobby: 'Not specified',
      studentId: studentIdController.text.trim(),
      email: emailController.text.trim(),
      favoriteSubject: 'Not specified',
      active: true,
    );

    students.add(newStudent);

    sortedStudents.add(newStudent);

    sortedStudents.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    // SAVE STUDENTS TO LOCAL STORAGE
    await saveStudents();

    studentIdController.clear();
    nameController.clear();
    courseController.clear();
    yearLevelController.clear();
    emailController.clear();

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Add Student',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(
                Icons.person_add,
                size: 80,
                color: Colors.lightBlue,
              ),

              const SizedBox(height: 15),

              const Text(
                'Enroll New Student',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                ),
              ),

              const SizedBox(height: 25),

              TextFormField(
                controller: studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Student ID';
                  }

                  bool studentExists = students.any(
                    (student) =>
                        student.studentId.toLowerCase() ==
                        value.trim().toLowerCase(),
                  );

                  if (studentExists) {
                    return 'Student ID already exists';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Full Name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Course';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: yearLevelController,
                decoration: const InputDecoration(
                  labelText: 'Year Level',
                  border: OutlineInputBorder(),
                  hintText: 'Example: 1st Year',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Year Level';
                  }

                  final validYearLevels = [
                    '1st Year',
                    '2nd Year',
                    '3rd Year',
                    '4th Year',
                  ];

                  bool isValidYear = validYearLevels.any(
                    (year) =>
                        year.toLowerCase() ==
                        value.trim().toLowerCase(),
                  );

                  if (!isValidYear) {
                    return 'Enter 1st, 2nd, 3rd, or 4th Year';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Email Address';
                  }

                  final emailPattern =
                      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                  if (!emailPattern.hasMatch(value.trim())) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: addStudent,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
