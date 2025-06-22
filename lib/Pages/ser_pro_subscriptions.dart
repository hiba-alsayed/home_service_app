import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _subscriptionType = 'month';
  Map<String, dynamic> _subscriptionDetails = {
    "start_date": "2024-07-16",
    "end_date": "2024-08-16",
    "subscription": "Basic",
    "price": "80000.00",
    "duration": "month"
  };
  bool _showDetails = false;

  void _submitSubscription() {
    setState(() {
      // يمكنك هنا إضافة منطق الاشتراك الفعلي إذا كان هناك حاجة
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Subscription'),
          content: Text('Subscribed successfully to $_subscriptionType plan'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscription Plans',
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
        ),
        backgroundColor: Color(0xFF2A629A),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Choose Subscription Type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A629A),
              ),
            ),
            ListTile(
              title: const Text('Monthly'),
              leading: Radio<String>(
                value: 'month',
                groupValue: _subscriptionType,
                onChanged: (String? value) {
                  setState(() {
                    _subscriptionType = value!;
                  });
                },
                activeColor: Color(0xFF2A629A),
              ),
            ),
            ListTile(
              title: const Text('Yearly'),
              leading: Radio<String>(
                value: 'year',
                groupValue: _subscriptionType,
                onChanged: (String? value) {
                  setState(() {
                    _subscriptionType = value!;
                  });
                },
                activeColor: Color(0xFF2A629A),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitSubscription,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFF2A629A), // foreground
              ),
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            Text(
              'If you want to see your details, press here:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A629A),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _toggleDetails,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFF2A629A), // foreground
              ),
              child: Text('Details'),
            ),
            SizedBox(height: 20),
            _showDetails
                ? Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Subscription: ${_subscriptionDetails['subscription']}'),
                    subtitle: Text('Price: ${_subscriptionDetails['price']}'),
                  ),
                  ListTile(
                    title: Text('Duration: ${_subscriptionDetails['duration']}'),
                    subtitle: Text('Start Date: ${_subscriptionDetails['start_date']}'),
                  ),
                  ListTile(
                    title: Text('End Date: ${_subscriptionDetails['end_date']}'),
                  ),
                ],
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}


