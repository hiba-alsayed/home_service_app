import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/GetAllServicesProvider.dart';
import '../Providers/ProviderLoginProvider.dart';
import '../Services/EmergencyBookingService.dart';

class InstantOrders extends StatefulWidget {
  const InstantOrders({super.key});

  @override
  _InstantOrdersState createState() => _InstantOrdersState();
}

class _InstantOrdersState extends State<InstantOrders> {
  String? selectedService;
  String? description;

  @override
  void initState() {
    super.initState();
    Provider.of<GetAllServicesProvider>(context, listen: false).fetchAllServices();
  }

  @override
  Widget build(BuildContext context) {
    final servicesProvider = Provider.of<GetAllServicesProvider>(context);
    final loginProvider = Provider.of<ProviderLoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Color(0xFF2A629A), size: 22),
        backgroundColor: Colors.white,
        title: Text(
          'Instant Orders',
          style: TextStyle(fontSize: 16, color: Color(0xFF2A629A)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('images/instant.jpg'),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Choose any service you need and book it...',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.blueGrey),
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonFormField<String>(
                value: selectedService,
                hint: Text('Select a service'),
                onChanged: (value) {
                  setState(() {
                    selectedService = value;
                  });
                },
                items: servicesProvider.getAllServices
                    ?.map((service) => DropdownMenuItem<String>(
                  value: service.id.toString(),
                  child: Text(service.name),
                ))
                    .toList(),
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write Your description here',
                  hintStyle: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (selectedService != null && description != null) {
              final success = await EmergencyService().createEmergency(
                serviceId: selectedService!,
                description: description!,
                token: loginProvider.token ?? '',
              );
              if (success) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Success'),
                    content: Text('Emergency created and providers notified.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Failed to create emergency.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2A629A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            'Book Now',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
