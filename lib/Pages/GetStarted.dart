import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Pages/HomePage.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:30),
                child: Text(
                  'Best Helping Hands For You !',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color:Color(0xFF2A629A),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:16,left:16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 32.0),
                    SizedBox(width: 4.0),
                    Text('Customer Reviews'),
                    SizedBox(width: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(right:16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.business, color: Colors.blue, size: 32.0),
                          SizedBox(width: 4.0),
                          Text('Multiple services'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.engineering, color: Colors.green, size: 32.0),
                    SizedBox(width: 4.0),
                    Text('Expert Workers'),
                  ],
                ),
              ),
              Stack(children: [
                Container(
                  height: 600,
                  decoration: BoxDecoration(),
                  margin: EdgeInsets.only(top: 32),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'images/GetStart.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 550.0,left: 16,right: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2A629A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}