
import 'package:flutter/material.dart';
import 'student_list_screen.dart';
import 'student_details_screen.dart';
import 'add_student_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student List',
      initialRoute: '/student-list',
      routes: {
        '/student-list': (context) => const StudentListScreen(),
        '/add-student': (context) => const AddStudentScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/student-details') {
          final arguments =
              settings.arguments as Map<String, dynamic>;

          return MaterialPageRoute(
            builder: (context) => StudentDetailsScreen(
              image: arguments['image'],
              name: arguments['name'],
              course: arguments['course'],
              yearLevel: arguments['yearLevel'],
              age: arguments['age'],
              hobby: arguments['hobby'],
              studentId: arguments['studentId'],
              email: arguments['email'],
              favoriteSubject: arguments['favoriteSubject'],
              active: arguments['active'],
              isFavorite: arguments['isFavorite'],
              isPressed: arguments['isPressed'],
              onSave: arguments['onSave'] as Function(
                String,
                String,
                String,
                String,
                int,
                String,
                String,
                String,
              ),
            ),
          );
        }

        return null;
      },
    );
  }
}
