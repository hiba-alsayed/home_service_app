import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SerProOrederDetails extends StatefulWidget {
  final Map<String, dynamic> order;

  SerProOrederDetails({required this.order});

  @override
  _SerProOrederDetailsState createState() => _SerProOrederDetailsState();
}

class _SerProOrederDetailsState extends State<SerProOrederDetails> {
  bool isAccepted = false;
  bool isRejected = false;

  void _acceptOrder() {
    setState(() {
      isAccepted = true;
      isRejected = false;
    });
  }

  void _rejectOrder() {
    setState(() {
      isAccepted = false;
      isRejected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  widget.order['service'],
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
                  'User Provider',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.order['provider'],
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
                  widget.order['date'],
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
                  'Price',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.order['price'],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Divider(thickness: 1, color: Colors.grey[300]),
            if (widget.order['status'] == 'InProcess') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isRejected) ...[
                    Text(
                      'Accept',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: _acceptOrder,
                      icon: Icon(Icons.check_circle),
                      color: Colors.green,
                    ),
                  ],
                  if (!isAccepted) ...[
                    Text(
                      'Reject',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: _rejectOrder,
                      icon: Icon(Icons.cancel),
                      color: Colors.red,
                    ),
                  ],
                ],
              ),
            ],
            Spacer(),
            if (widget.order['status'] == 'Pending')
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}

