
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

  Future<void> showEditDialog(BuildContext context) async {
    final bool? saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return _EditStudentDialog(
          name: name,
          studentId: studentId,
          course: course,
          yearLevel: yearLevel,
          age: age,
          hobby: hobby,
          email: email,
          favoriteSubject: favoriteSubject,
          onSave: onSave,
        );
      },
    );

    if (saved == true && context.mounted) {
      Navigator.pop(context, true);
    }
  }

  Widget buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.grey[300],
              child: image.isEmpty
                  ? const Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.white,
                    )
                  : ClipOval(
                      child: Image.asset(
                        image,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Divider(),

            buildDetail('Student ID:', studentId),
            buildDetail('Course:', course),
            buildDetail('Year Level:', yearLevel),
            buildDetail('Age:', age.toString()),
            buildDetail('Hobby:', hobby),
            buildDetail('Email:', email),
            buildDetail('Favorite Subject:', favoriteSubject),
            buildDetail('Status:', active ? 'Active' : 'Inactive'),
            buildDetail(
              'Favorite:',
              isFavorite ? 'Yes' : 'No',
            ),
            buildDetail(
              'Button Status:',
              isPressed ? 'Pressed' : 'Not Pressed',
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  showEditDialog(context);
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Student'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Edit Student Dialog

class _EditStudentDialog extends StatefulWidget {
  final String name;
  final String studentId;
  final String course;
  final String yearLevel;
  final int age;
  final String hobby;
  final String email;
  final String favoriteSubject;

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

  const _EditStudentDialog({
    required this.name,
    required this.studentId,
    required this.course,
    required this.yearLevel,
    required this.age,
    required this.hobby,
    required this.email,
    required this.favoriteSubject,
    required this.onSave,
  });

  @override
  State<_EditStudentDialog> createState() =>
      _EditStudentDialogState();
}

class _EditStudentDialogState extends State<_EditStudentDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController studentIdController;
  late final TextEditingController courseController;
  late final TextEditingController yearLevelController;
  late final TextEditingController ageController;
  late final TextEditingController hobbyController;
  late final TextEditingController emailController;
  late final TextEditingController favoriteSubjectController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.name);
    studentIdController =
        TextEditingController(text: widget.studentId);
    courseController = TextEditingController(text: widget.course);
    yearLevelController =
        TextEditingController(text: widget.yearLevel);
    ageController =
        TextEditingController(text: widget.age.toString());
    hobbyController = TextEditingController(text: widget.hobby);
    emailController = TextEditingController(text: widget.email);
    favoriteSubjectController =
        TextEditingController(text: widget.favoriteSubject);
  }

  @override
  void dispose() {
    nameController.dispose();
    studentIdController.dispose();
    courseController.dispose();
    yearLevelController.dispose();
    ageController.dispose();
    hobbyController.dispose();
    emailController.dispose();
    favoriteSubjectController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Student Information'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the student name';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the student ID';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the course';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: yearLevelController,
                decoration: const InputDecoration(
                  labelText: 'Year Level',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the year level';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      int.tryParse(value.trim()) == null) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: hobbyController,
                decoration: const InputDecoration(
                  labelText: 'Hobby',
                ),
              ),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an email address';
                  }

                  if (!RegExp(
                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                  ).hasMatch(value.trim())) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
              ),

              TextFormField(
                controller: favoriteSubjectController,
                decoration: const InputDecoration(
                  labelText: 'Favorite Subject',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave(
                nameController.text.trim(),
                studentIdController.text.trim(),
                courseController.text.trim(),
                yearLevelController.text.trim(),
                int.parse(ageController.text.trim()),
                hobbyController.text.trim(),
                emailController.text.trim(),
                favoriteSubjectController.text.trim(),
              );

              Navigator.pop(context, true);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
