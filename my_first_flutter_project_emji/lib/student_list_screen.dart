
import 'package:flutter/material.dart';

class Student {
  final String image;
  String name;
  String course;
  String yearLevel;
  int age;
  String hobby;
  String studentId;
  String email;
  String favoriteSubject;
  bool isPressed = false;
  bool isFavorite = false;
  bool active;

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
    required this.active,
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
    active: true,
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
    active: false,
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
    active: true,
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
    active: true,
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
    active: true,
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
    active: false,
  ),
];

List<Student> sortedStudents = List<Student>.from(students)
  ..sort((a, b) => a.name.compareTo(b.name));

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() =>
      _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 10),
      ),
    );
  }

  // NAMED ROUTE: OPEN STUDENT DETAILS
  void openStudentDetails(Student student) {
    Navigator.pushNamed(
      context,
      '/student-details',
      arguments: {
        'image': student.image,
        'name': student.name,
        'course': student.course,
        'yearLevel': student.yearLevel,
        'age': student.age,
        'hobby': student.hobby,
        'studentId': student.studentId,
        'email': student.email,
        'favoriteSubject': student.favoriteSubject,
        'active': student.active,
        'isFavorite': student.isFavorite,
        'isPressed': student.isPressed,
        'onSave': (
          newName,
          newStudentId,
          newCourse,
          newYearLevel,
          newAge,
          newHobby,
          newEmail,
          newFavoriteSubject,
        ) {
          setState(() {
            student.name = newName;
            student.studentId = newStudentId;
            student.course = newCourse;
            student.yearLevel = newYearLevel;
            student.age = newAge;
            student.hobby = newHobby;
            student.email = newEmail;
            student.favoriteSubject = newFavoriteSubject;

            sortedStudents.sort(
              (a, b) => a.name.compareTo(b.name),
            );
          });
        },
      },
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add-student');
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            tooltip: 'Add Student',
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.lightBlue,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Loading students...',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Arial',
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            )
          : sortedStudents.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'No students found.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Your student profile is currently empty.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Arial',
                          color: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sortedStudents.length,
                  itemBuilder: (context, index) {
                    final student = sortedStudents[index];

                    return GestureDetector(
                      onTap: () {
                        showMessage(
                          'Student Card tapped: ${student.name}',
                        );

                        debugPrint(
                          'Student Card tapped: ${student.name}',
                        );

                        openStudentDetails(student);
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

                              Image.asset(
                                student.image,
                                width: 130,
                              ),

                              const SizedBox(height: 30),

                              Text(
                                student.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial',
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                student.course,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                student.yearLevel,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'Age: ${student.age}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'Hobby: ${student.hobby}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'Student ID: ${student.studentId}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'Email: ${student.email}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'Favorite Subject: ${student.favoriteSubject}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 18,
                                    color: student.active
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    student.active
                                        ? 'Active'
                                        : 'Inactive',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              if (!student.active)
                                const Text(
                                  'Student is not enrolled at this time.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Arial',
                                  ),
                                ),

                              const SizedBox(height: 10),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        student.isFavorite =
                                            !student.isFavorite;
                                      });

                                      showMessage(
                                        'Favorite button pressed for ${student.name}',
                                      );

                                      debugPrint(
                                        'Favorite button pressed for ${student.name}',
                                      );
                                    },
                                    child: Icon(
                                      student.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: student.isFavorite
                                          ? Colors.red
                                          : null,
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
                                        'Edit button pressed for ${student.name}',
                                      );

                                      openStudentDetails(student);
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
