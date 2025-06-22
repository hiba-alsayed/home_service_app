import 'package:flutter/material.dart';

class RatingCommentScreen extends StatelessWidget {
  // Dummy data
  final List<Map<String, dynamic>> ratings = [
    {
      "rating": 4,
      "comment": "great",
      "name": "aya",
      "email": "ayaa@gmail.com",
      "city": "Damascus city"
    },
    {
      "rating": 5,
      "comment": "good",
      "name": "noor",
      "email": "noor@gmail.com",
      "city": "Damascus city"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A629A),
        title: Text(
          'Ratings and Comments',
          style: TextStyle(color:Colors.white), // Primary color
        ),
        centerTitle: true, // AppBar background color
        elevation: 0, // Remove shadow
      ),
      body: ListView.builder(
        itemCount: ratings.length,
        itemBuilder: (context, index) {
          final ratingComment = ratings[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ratingComment['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A629A), // Name color
                            ),
                          ),
                          Text(
                            ratingComment['city'],
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(Icons.star, color: Color(0xFFFFD700)), // Star color
                          SizedBox(width: 4),
                          Text(
                            '${ratingComment['rating']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A629A), // Rating color
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 20, thickness: 1, color: Colors.grey[300]),
                  Text(
                    ratingComment['comment'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2A629A) , // Comment color
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blueAccent), // Email icon color
                      SizedBox(width: 4),
                      Text(
                        ratingComment['email'],
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
