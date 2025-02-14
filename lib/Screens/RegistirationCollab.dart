import 'package:flutter/material.dart';

class Signupcollab extends StatelessWidget {
  const Signupcollab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Images/Super_Stars-removebg.png',
              height: 160,
            ),
            const SizedBox(height: 20),

            const Text(
              'Join Us on Creators Corner Local Brand!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            const Text(
              'We’ve launched a dedicated app for local brand owners! Download "Creators Corner Local Brand" to start collaborating and growing your business.',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Download Button
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Download Now',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Navigator.pop(context); // Go back if needed
              },
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
