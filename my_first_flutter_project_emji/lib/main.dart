import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'viewmodels/enrollment_viewmodel.dart';
import 'viewmodels/grade_viewmodel.dart';
import 'viewmodels/schedule_viewmodel.dart';
import 'viewmodels/student_viewmodel.dart';
import 'viewmodels/subject_viewmodel.dart';
import 'views/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => StudentViewModel()..load()),
      ChangeNotifierProvider(create: (_) => SubjectViewModel()..load()),
      ChangeNotifierProvider(create: (_) => ScheduleViewModel()),
      ChangeNotifierProvider(create: (_) => EnrollmentViewModel()),
      ChangeNotifierProvider(create: (_) => GradeViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Enrollment System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
