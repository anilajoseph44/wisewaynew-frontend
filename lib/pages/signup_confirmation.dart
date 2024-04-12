import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/LoginPage.dart';

class SignupConfirmation extends StatefulWidget {
  const SignupConfirmation({super.key});

  @override
  State<SignupConfirmation> createState() => _SignupConfirmationState();
}

class _SignupConfirmationState extends State<SignupConfirmation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body: Container(padding: EdgeInsets.all(40),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Account created successfully.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  // Navigate to login page
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}