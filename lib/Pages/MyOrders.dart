import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/AppointmentProvider.dart';
import 'DetailsPage.dart';

class MyOrdersContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Color(0xFF2A629A), size: 22),
        title: Text(
          'My Orders',
          style: TextStyle(fontSize: 16, color: Color(0xFF2A629A)),
        ),
        centerTitle: true,
      ),
      body: Consumer<AppointmentProvider>(
        builder: (ctx, appointmentProvider, _) {
          final appointments = appointmentProvider.appointments;

          // Sort appointments
          appointments.sort((a, b) {
            final dateTimeA = DateTime.parse('${a.date} ${a.hour}');
            final dateTimeB = DateTime.parse('${b.date} ${b.hour}');
            return dateTimeB.compareTo(dateTimeA);
          });

          if (appointments.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          // Build the ListView with sorted appointments
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: appointments.length,
            itemBuilder: (ctx, i) {
              final appointment = appointments[i];

              return GestureDetector(
                onTap: appointment.status == 'approved'
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(appointment: appointment),
                    ),
                  );
                }
                    : null, // No navigation for non-accepted appointments
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointment.provider,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Color(0xFF2A629A),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${appointment.date} at ${appointment.hour}',
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                              SizedBox(height: 2),
                              Text(
                                appointment.city,
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                              SizedBox(height: 4),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (appointment.status == 'pending')
                                      Icon(Icons.pending, color: Colors.orange),
                                    if (appointment.status == 'canceled')
                                      Icon(Icons.cancel, color: Colors.red),
                                    if (appointment.status == 'approved')
                                      Icon(Icons.check_circle, color: Colors.green),
                                    if (appointment.status == 'finished')
                                      Icon(Icons.check, color: Colors.green),
                                    SizedBox(width: 8),
                                    Text(
                                      appointment.status,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: appointment.status == 'pending'
                                            ? Colors.orange
                                            : appointment.status == 'canceled'
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

