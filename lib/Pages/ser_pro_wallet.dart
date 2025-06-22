import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _amountController = TextEditingController();
  double _balance = 1000.00;

  Future<void> _depositAmount() async {
    final enteredAmount = double.tryParse(_amountController.text);
    if (enteredAmount != null && enteredAmount > 0) {
      // Replace with your API URL
      final response = await http.post(
        Uri.parse('https://yourapi.com/deposit'), // Replace with your actual API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'wallet_id': '1',
          'amount': enteredAmount.toString(),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['Message'] == 'Deposited Successfully') {
          setState(() {
            _balance += enteredAmount;
          });
          _showSuccessMessage();
        } else {
          _showErrorMessage();
        }
      } else {
        _showErrorMessage();
      }
    }
  }

  void _showSuccessMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success', style: TextStyle(color: Colors.purpleAccent)),
          content: Text('Deposited Successfully'),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.purpleAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error', style: TextStyle(color: Colors.red)),
          content: Text('Failed to deposit amount. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet Service Provider', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
        backgroundColor: Color(0xFF2A629A), // Dark blue color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Your Balance',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2A629A)),
            ),
            SizedBox(height: 10),
            Text(
              '\$$_balance',
              style: TextStyle(fontSize: 24, color: Colors.purpleAccent, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              'Deposit Amount',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2A629A)),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _depositAmount,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFF2A629A), // Text color
              ),
              child: Text('Deposit'),
            ),
          ],
        ),
      ),
    );
  }
}
