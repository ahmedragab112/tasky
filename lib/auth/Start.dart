import 'package:flutter/material.dart';
import 'package:foucesflow3/auth/colors.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: BG,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              const Padding(
                padding: EdgeInsets.only(left: 85),
                child: Text(
                  'FocusFlow',
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Lobster',
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Text(
                  'Keep your',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                    color: Grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Text(
                  'mind',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                    color: Grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Text(
                  'Focused',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    color: Grey,
                  ),
                ),
              ),
              const SizedBox(height: 0),
              Image.asset(
                'images/Logo.png',
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 110, vertical: 15),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Alef',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Home');
                  },
                  child: const Text(
                    'Guest',
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
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
