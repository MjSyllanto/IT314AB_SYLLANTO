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

        // =========================
        // APP BAR
        // =========================
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text(
            'My First Flutter Application',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),

        // =========================
        // FLAG 9: STACK THE CARDS
        // =========================
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),

            // Column arranges the two Cards vertically
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // =========================
                // CARD 1: PROFILE
                // =========================
                Card(
                  color: Colors.white.withOpacity(0.3),
                  elevation: 0,

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      0,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image.asset(
                          'assets/dog.webp',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Mary Jocelyn Syllanto',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'BSIT 3',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'My First Flutter Application',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'August 17, 2026',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Hobby: Sleeping',
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Age: 22',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),

                            SizedBox(width: 25),

                            Text(
                              'Birthdate: February 24, 2004',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =========================
                // CARD 2: MY FAVORITES
                // =========================
                Card(
                  color: Colors.white.withOpacity(0.3),
                  elevation: 0,

                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      children: [
                        // Favorite Icon
                        const Icon(
                          Icons.flag_circle_rounded,
                          size: 25,
                        ),

                        const SizedBox(height: 10),

                        // My Favorites
                        const Text(
                          'My Favorites',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Game and Movie
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Game: Valorant',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),

                            SizedBox(width: 15),

                            Text(
                              'Movie: Spiderman',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Color
                        const Text(
                          'Color: Black',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}