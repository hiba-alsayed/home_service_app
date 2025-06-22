import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/AppointmentApprovedService.dart';
import '../Models/ClientLoginModel.dart';
import 'ClientLoginProvider.dart';

class AppointmentCancelProvider with ChangeNotifier {
  final AppointmentApprovedService _service = AppointmentApprovedService();

  Future<void> cancelAppointment(BuildContext context, String appointmentId) async {
    final token = Provider.of<ClientLoginProvider>(context, listen: false).getClientModel?.token;

    if (token == null) {
      throw Exception('No authentication token found');
    }

    try {
      await _service.cancelAppointment(id: appointmentId, token: token);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Appointment Canceled successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to cancel appointment. Error: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
