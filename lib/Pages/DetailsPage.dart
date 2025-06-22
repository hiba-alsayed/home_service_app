import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../Models/Appointment.dart';
import '../Providers/AppointmentApprovedProvider.dart';
import '../Providers/AppointmentCancelProvider.dart';
import '../Providers/ClientLoginProvider.dart';

class DetailsPage extends StatelessWidget {
  final Appointment appointment;

  DetailsPage({required this.appointment});

  @override
  Widget build(BuildContext context) {
    double rating = 0.0;
    final TextEditingController feedbackController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Color(0xFF2A629A), size: 22),
        title: Text(
          'Appointment Details',
          style: TextStyle(fontSize: 18, color: Color(0xFF2A629A)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF2A629A)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Provider: ${appointment.provider}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2A629A)),
            ),
            SizedBox(height: 8),
            Text('Date: ${appointment.date}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Time: ${appointment.hour}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('City: ${appointment.city}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(
              'Status: ${appointment.status}',
              style: TextStyle(
                fontSize: 16,
                color: appointment.status == 'approved' ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 16),
            Text('Rate the Service:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                rating = newRating;
              },
            ),
            SizedBox(height: 16),
            Text('Your Feedback:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add your feedback here',
                hintStyle: TextStyle(fontSize: 14.0),
                contentPadding: EdgeInsets.all(12.0),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<AppointmentCancelProvider>(context, listen: false)
                        .cancelAppointment(context, appointment.id.toString());
                  },
                  child: Row(
                    children: [
                      Icon(Icons.cancel, size: 20, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Cancel Order', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<AppointmentApprovedProvider>(context, listen: false)
                        .submitRating(
                      context,
                      appointment.id.toString(),
                      rating,
                      feedbackController.text,
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.check, size: 20, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Finish', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
