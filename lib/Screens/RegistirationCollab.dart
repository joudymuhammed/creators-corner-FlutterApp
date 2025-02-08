import 'package:creators_corner/Component/HomeScreenWrapper.dart';
import 'package:creators_corner/Screens/Home.dart';
import 'package:creators_corner/main.dart';
import 'package:flutter/material.dart';

import 'signin.dart';

class Signupcollab extends StatefulWidget {
  const Signupcollab({super.key});

  @override
  State<Signupcollab> createState() => _SignupcollabState();
}

class _SignupcollabState extends State<Signupcollab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Images/Super_Stars-removebg.png',
              height: 160,
            ),
            SizedBox(height: 20),

            Container(
              width: 500,
              child: Text(
                'Collab',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 500,
              child: Text(
                'Please collab to join.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),

            SizedBox(height: 20),

            // Username TextField
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Instagram Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),

            SizedBox(height: 20),

            // Sign up Button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [Color(0xFFB0A5A5), Color(0xFFFF7B7B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => HomeScreenWrapper()));
                },
                child: Text(
                  'Send us',
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    minimumSize: Size(double.infinity, 50)),
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you user?',
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signin(),
                          ));
                    },
                    child: Text('Sign in')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
