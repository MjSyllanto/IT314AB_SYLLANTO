import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      backgroundColor: const Color.fromARGB(255, 27, 27, 27),
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
                        fontSize: 20,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),

                    SizedBox(width: 10),

                    Text(
                      'Messages',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'arial',
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),

                    SizedBox(width: 10),

                    Text(
                      'Requests',
                      style: TextStyle(
                        fontSize: 20,
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
                      fontSize: 20,
                      fontFamily: 'arial',
                      fontWeight: FontWeight.bold,
                    color: Colors.white
                    
                    ),
                  )

                ],
              ),
              
              )
            )
          ],
        ),
      )
    );
  }
}