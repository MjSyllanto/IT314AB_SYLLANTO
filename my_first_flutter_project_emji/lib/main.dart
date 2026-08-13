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
      home: Scaffold(
        backgroundColor: Colors.lightBlue[50],

        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text(
            'My First Flutter Application',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),

        body: Center(
          child: Card(
            margin: const EdgeInsets.all(25),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(30),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Heart icon
                  const Icon(
                    Icons.favorite,
                    size: 70,
                    color: Colors.lightBlue,
                  ),

                  const SizedBox(height: 20),

                  // Circular profile picture
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.lightBlue,
                        width: 5,
                      ),
                    ),

                    child: ClipOval(
                      child: Image.asset(
                        'assets/dog.webp',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Name
                  const Text(
                    'Mary Jocelyn Syllanto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Course
                  const Text(
                    'BSIT 3',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Application title
                  const Text(
                    'My First Flutter Application',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Date
                  const Text(
                    'August 11, 2026',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}