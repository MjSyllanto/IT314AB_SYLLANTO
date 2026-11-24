class Student {
  final String image;
  String name;
  String course;
  String yearLevel;
  int age;
  String hobby;
  final String studentId;
  String email;
  String favoriteSubject;
  bool isPressed = false;
  bool isFavorite = false;
  final bool active;

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