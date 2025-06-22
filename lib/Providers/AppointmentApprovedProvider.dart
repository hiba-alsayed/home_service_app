import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/AppointmentApprovedService.dart';
import '../Models/ClientLoginModel.dart';
import 'ClientLoginProvider.dart';

class AppointmentApprovedProvider with ChangeNotifier {
  final AppointmentApprovedService _service = AppointmentApprovedService();

  Future<void> submitRating(BuildContext context, dynamic appointmentId, dynamic rating, dynamic comment) async {
    final token = Provider.of<ClientLoginProvider>(context, listen: false).getClientModel?.token;

    if (token == null) {
      throw Exception('No authentication token found');
    }

    try {
      await _service.submitRating(
        id: appointmentId,
        token: token,
        rating: rating,
        comment: comment,
      );
      _showDialog(context, 'Success', 'Rating submitted successfully');
    } catch (error) {
      _showDialog(context, 'Error', 'Failed to submit rating: ${error.toString()}');
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
