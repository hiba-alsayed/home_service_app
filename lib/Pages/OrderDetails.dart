import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Color(0xFF2A629A), size: 22),
        backgroundColor: Colors.white,
        title: Text('Order Details', style: TextStyle(fontSize: 16, color: Color(0xFF2A629A))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order['service'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Service Provider',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  order['provider'],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  order['date'],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  order['hour'],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, color: Colors.grey[300]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      order['statusIcon'],
                      color: order['statusColor'],
                    ),
                    SizedBox(width: 4),
                    Text(
                      order['status'],
                      style: TextStyle(
                        color: order['statusColor'],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),
            if (order['status'] == 'Accepted') ...[
              Text(
                'Service evaluation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // Handle rating update
                  },
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Feedback',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your feedback here',
                    hintStyle: TextStyle(fontSize: 14.0)),
              ),
            ],
            if (order['status'] == 'Completed') ...[
              SizedBox(height: 32),
              Text(
                'Service Rating',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: RatingBarIndicator(
                  rating: order['rating'] ?? 0,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 24.0,
                  direction: Axis.horizontal,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Feedback',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                order['comment'] ?? 'No feedback provided',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
            Spacer(),
            if (order['status'] == 'Accepted') ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child:  Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.grey),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'The order can only be canceled before 24 hours.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle cancel action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle finish action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Finish',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
