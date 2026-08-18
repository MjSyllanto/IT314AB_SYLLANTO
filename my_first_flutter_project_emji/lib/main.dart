import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Colors.lightBlue[50],

        // APP BAR
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            'My First Flutter Application',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),

            // Column arranges the two Cards vertically
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                // =========================
                // CARD 1: PROFILE
                // =========================
                Card(
                  color: Colors.lightBlue.withOpacity(0.3),
                  elevation: 0,

                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      0,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Circular Avatar
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

                        SizedBox(height: 10),

                        Text(
                          'Mary Jocelyn Syllanto',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          'BSIT 3',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          'My First Flutter Application',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          'August 17, 2026',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          'Hobby: Sleeping',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),

                        SizedBox(height: 10),

                        Row(
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

                SizedBox(height: 20),

                // =========================
                // CARD 2: MY FAVORITES
                // =========================
                Card(
                  color: Colors.lightBlue.withOpacity(0.3),
                  elevation: 0,

                  child: Padding(
                    padding: EdgeInsets.all(16),

                    child: Column(
                      children: [

                        // Favorite Icon
                        Icon(
                          Icons.favorite,
                          size: 25,
                        ),

                        SizedBox(height: 10),

                        // My Favorites
                        Text(
                          'My Favorites',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10),

                        // Game and Movie
                        Row(
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

                        SizedBox(height: 10),

                        // FLAG 10: CHIP WIDGET
                        Chip(
                          label: Text(
                            'Color: Black',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}