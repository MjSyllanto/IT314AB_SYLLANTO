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
      title: 'Student List',
      home: const StudentListPage(),
    );
  }
}

class Student {
  final String image;
  final String name;
  final String course;
  final String yearLevel;
  final int age;
  final String hobby;
  final String studentId;
  final String email;
  final String favoriteSubject;
  bool isPressed = false;
  bool isFavorite = false;

  Student({
    required this.image,
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.age,
    required this.hobby,
    required this.studentId,
    required this.email,
    required this.favoriteSubject,
  });
}

List<Student> students = [
  Student(
    image: 'assets/dog.webp',
    name: 'Mary Jocelyn Syllanto',
    course: 'BSIT',
    yearLevel: '3rd Year',
    age: 20,
    hobby: 'Drinking Secret',
    studentId: '202300123',
    email: 'mary.syllanto@school.edu',
    favoriteSubject: 'Math',
  ),
  Student(
    image: 'assets/marianne.JPG',
    name: 'Maryan Gridwan',
    course: 'BSIT',
    yearLevel: '3rd Year',
    age: 21,
    hobby: 'Playing Mobile Legends',
    studentId: '202300124',
    email: 'maryan.gridwan@school.edu',
    favoriteSubject: 'Networking',
  ),
  Student(
    image: 'assets/mav1.JPG',
    name: 'Mav Sumalangitka',
    course: 'BSCS',
    yearLevel: '1st Year',
    age: 19,
    hobby: 'Dancing',
    studentId: '202300125',
    email: 'mav.sumalangitka@school.edu',
    favoriteSubject: 'Recess',
  ),
  Student(
    image: 'assets/chim.PNG',
    name: 'Chim Boop',
    course: 'BSIT',
    yearLevel: '2nd Year',
    age: 20,
    hobby: 'Hobby Tanan',
    studentId: '202300126',
    email: 'chim.boop@school.edu',
    favoriteSubject: 'Networking',
  ),
  Student(
    image: 'assets/krylle.PNG',
    name: 'Karylle Buta',
    course: 'BSIS',
    yearLevel: '3rd Year',
    age: 21,
    hobby: 'Magpakatanga',
    studentId: '202300127',
    email: 'karylle.buta@school.edu',
    favoriteSubject: 'Information Systems',
  ),
  Student(
    image: 'assets/jolya.JPG',
    name: 'Julia Yashika Kong',
    course: 'BSIT',
    yearLevel: '3rd Year',
    age: 20,
    hobby: 'Depende sa uso',
    studentId: '202300128',
    email: 'julia.kong@school.edu',
    favoriteSubject: 'GEC',
  ),
];

List<Student> sortedStudents = List<Student>.from(students)
  ..sort((a, b) => a.name.compareTo(b.name));

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Student List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: sortedStudents.isEmpty
          ? const Center(
              child: Text(
                'No students found.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sortedStudents.length,
              itemBuilder: (context, index) {
                final student = sortedStudents[index];

                return GestureDetector(
                  onTap: () {
                    showMessage('Student Card tapped: ${student.name}');
                    debugPrint('Student Card tapped: ${student.name}');
                  },
                  child: Card(
                    color: student.isFavorite
                        ? Colors.red[100]
                        : Colors.white,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),

                          Image.asset(student.image, width: 130),

                          const SizedBox(height: 30),

                          Text(
                            student.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            student.course,
                            style: const TextStyle(fontSize: 18),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            student.yearLevel,
                            style: const TextStyle(fontSize: 18),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Age: ${student.age}',
                            style: const TextStyle(fontSize: 18),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Hobby: ${student.hobby}',
                            style: const TextStyle(fontSize: 18),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Student ID: ${student.studentId}',
                            style: const TextStyle(fontSize: 18),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Email: ${student.email}',
                            style: const TextStyle(fontSize: 18),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Favorite Subject: ${student.favoriteSubject}',
                            style: const TextStyle(fontSize: 18),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            student.isPressed
                                ? 'Button Status: Button Pressed'
                                : 'Button Status: Not Pressed',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    student.isFavorite = !student.isFavorite;
                                    student.isPressed = true;
                                  });

                                  showMessage(
                                    'Favorite button pressed for ${student.name}',
                                  );

                                  debugPrint(
                                    'Favorite button pressed for '
                                    '${student.name}',
                                  );
                                },
                                child: Icon(
                                  student.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                              ),

                              const SizedBox(width: 10),

                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    student.isPressed = true;
                                  });

                                  showMessage(
                                    'Edit button pressed for ${student.name}',
                                  );

                                  debugPrint(
                                    'Edit button pressed for '
                                    '${student.name}',
                                  );

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Edit Student ${student.name}',
                                        ),
                                        content: const Text(
                                          'Want to edit something?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Edit'),
                              ),

                              const SizedBox(width: 10),

                              ElevatedButton(
                                onPressed: () {
                                  showMessage(
                                    'Deleted student: ${student.name}',
                                  );

                                  debugPrint(
                                    'Deleted student: ${student.name}',
                                  );

                                  setState(() {
                                    sortedStudents.removeAt(index);
                                  });
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),

                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}