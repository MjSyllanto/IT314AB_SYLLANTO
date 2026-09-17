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
      title: 'Exam_2',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.black)
      ),
      home:  MyHomePage()
    );
  }
}

class MyHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Social',
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'arial',
            fontWeight: FontWeight.bold,
            color: Colors.white
            )
          )
        ),
        body: Center(
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero),
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(children: [
                    Text(
                      'Friends',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),

                    SizedBox(width: 10),

                    Text(
                      'Messages',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),

                    SizedBox(width: 10),

                    Text(
                      'Requests',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
                  ],
                )
              ),
            ),
            Card(
              margin: EdgeInsets.only(top: 1, bottom: 0, left: 0, right: 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: Colors.black,
              child: Padding(padding: EdgeInsetsGeometry. all(16),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular (10)),

                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Row(
                    children: [
                      SizedBox(width: 15,),
                      Icon(
                        Icons.search,
                        size: 28,
                        color: const Color.fromARGB(255, 59, 58, 58)
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'arial',
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 59, 58, 58)
                        ),
                      ),
                    ],
                  ),
                )
              )
            )
          ),
               Card(
              color: Colors.black,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(padding: 
              EdgeInsetsGeometry.only(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.circle_rounded,
                    size: 28,
                    color: Colors.redAccent,
                  
                  ),
                  SizedBox(width: 15,),
                  Text(
                    'VALORANT',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),
                  ),

                   SizedBox(width: 10),

                  Text(
                    '3',
                    style: TextStyle (
                      fontSize: 15,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.bold,
                      color: Colors.white30,
                    )
                  )
                ],
              ),
            )
          ),
            Card(
              color: Colors.black,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 0,
                  bottom: 16,
                  left: 25, 
                  right: 16,
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB (255, 20, 20, 20),
                          radius: 30,
                          child: Icon(Icons.person, color:Colors.redAccent,
                          size: 40),
                          ),
                             
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 16,
                                color: Colors.black
                              ),

                              SizedBox(width: 10),

                              Icon(
                                Icons.circle,
                                size: 18,
                                color:Colors.greenAccent,                          
                              ),
                            ],
                          ),
                        ],
                      ),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MissYouLikeKrazy',
                          style: TextStyle (
                            fontSize: 20,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),

                        Row(
                          children: [
                            Icon(
                              Icons.monitor,
                              size: 15,
                              color: Colors.white70,
                            ),

                            SizedBox(width: 10),

                            Text(
                              'Online- VALORANT',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'arial',
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.black,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 0,
                  bottom: 15,
                  left: 28, 
                  right: 17,
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB (255, 20, 20, 20),
                          radius: 30,
                          child: Icon(Icons.person, color:Colors.redAccent,
                          size: 40),
                          ),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 16,
                                color: Colors.black
                              ),

                              SizedBox(width: 10),

                              Icon(
                                Icons.play_circle,
                                size: 18,
                                color:Colors.blueAccent,                          
                              ),
                            ],
                          ),
                        ],
                      ),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'bread',
                          style: TextStyle (
                            fontSize: 20,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),

                        Row(
                          children: [
                            Icon(
                              Icons.monitor,
                              size: 15,
                              color: Colors.white70,
                            ),

                            SizedBox(width: 10),

                            Text(
                              'Playing- VALORANT',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'arial',
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          Card(
              color: Colors.black,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 0,
                  bottom: 15,
                  left: 28, 
                  right: 17,
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB (255, 20, 20, 20),
                          radius: 30,
                          child: Icon(Icons.person, color:Colors.redAccent,
                          size: 40),
                          ),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 16,
                                color: Colors.black
                              ),

                              SizedBox(width: 10),

                              Icon(
                                Icons.play_circle,
                                size: 18,
                                color:Colors.blueAccent,                          
                              ),
                            ],
                          ),
                        ],
                      ),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The14th',
                          style: TextStyle (
                            fontSize: 20,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),

                        Row(
                          children: [
                            Icon(
                              Icons.monitor,
                              size: 15,
                              color: Colors.white70,
                            ),

                            SizedBox(width: 10),

                            Text(
                              'Playing- VALORANT',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'arial',
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            Card(
              color: Colors.black,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            child: Padding (
              padding:EdgeInsets.only(
                top: 0,
                bottom: 16,
                left: 20,
                right: 16,
              ),
              child: Row(
                children: [
                  Text (
                    'Online',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(width: 10),

                  Text(
                    '4',
                    style: TextStyle (
                      fontSize: 15,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.bold,
                      color: Colors.white30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
              color: Colors.black,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 0,
                  bottom: 15,
                  left: 28, 
                  right: 17,
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB (255, 20, 20, 20),
                          radius: 30,
                          child: Icon(Icons.person, color:Colors.white,
                          size: 40),
                          ),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 16,
                                color: Colors.black
                              ),

                              SizedBox(width: 10),

                              Icon(
                                Icons.dark_mode,
                                size: 18,
                                color:Colors.yellowAccent,                          
                              ),
                            ],
                          ),
                      ],
                    ),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carlvendish',
                          style: TextStyle (
                            fontSize: 20,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),

                        Row(
                          children: [
                            Icon(
                              Icons.phone_android,
                              size: 15,
                              color: Colors.white70,
                            ),

                            SizedBox(width: 10),

                            Text(
                              'Away - Riot Mobile',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'arial',
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          Card(
              color: Colors.black,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 0,
                  bottom: 15,
                  left: 28, 
                  right: 17,
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB (255, 20, 20, 20),
                          radius: 30,
                          child: Icon(Icons.person, color:Colors.white,
                          size: 40),
                          ),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 16,
                                color: Colors.black
                              ),

                              SizedBox(width: 10),

                              Icon(
                                Icons.dark_mode,
                                size: 18,
                                color:Colors.yellowAccent,                          
                              ),
                            ],
                          ),
                      ],
                    ),

                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'D1yah',
                          style: TextStyle (
                            fontSize: 20,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),

                        Row(
                          children: [
                            Icon(
                              Icons.phone_android,
                              size: 15,
                              color: Colors.white70,
                            ),

                            SizedBox(width: 10),

                            Text(
                              'Away - Riot Mobile',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'arial',
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}