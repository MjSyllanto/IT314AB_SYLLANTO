import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/db_connection.dart';
import '../viewmodels/student_viewmodel.dart';
import '../viewmodels/subject_viewmodel.dart';
import 'student_list_screen.dart';
import 'subject_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  late Future<String?> _conn = DbConnection.testConnection();

  void _retry() {
    setState(() => _conn = DbConnection.testConnection());
    _conn.then((err) {
      if (err == null && mounted) {
        context.read<StudentViewModel>().load();
        context.read<SubjectViewModel>().load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder<String?>(
          future: _conn,
          builder: (ctx, snap) {
            Color color;
            String text;
            bool failed = false;
            if (snap.connectionState != ConnectionState.done) {
              color = Colors.orange;
              text = 'Connecting to database...';
            } else if (snap.data == null) {
              color = Colors.green.shade700;
              text = 'Connected to Neon database';
            } else {
              color = Colors.red.shade700;
              text = 'Connection failed: ${snap.data}';
              failed = true;
            }
            return Material(
              color: color,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(children: [
                    Expanded(
                        child: Text(text,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 12))),
                    if (failed)
                      TextButton(
                          onPressed: _retry,
                          child: const Text('Retry', style: TextStyle(color: Colors.white))),
                  ]),
                ),
              ),
            );
          },
        ),
        Expanded(
          child: IndexedStack(
            index: _tab,
            children: const [StudentListScreen(), SubjectListScreen()],
          ),
        ),
      ]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.people), label: 'Students'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Subjects'),
        ],
      ),
    );
  }
}
