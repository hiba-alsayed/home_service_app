import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/AllProviderSameServiceModel.dart';
import '../Providers/AllProviderSameServiceProvider.dart';
import '../Providers/ClientLoginProvider.dart';
import '../Providers/GetAllServicesProvider.dart';
import '../Services/AllProviderSameServiceServ.dart';
import 'PaintingServList.dart';

class PaintingServ extends StatelessWidget {
  const PaintingServ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  Icon(Icons.arrow_back, color: Color(0xFF2A629A),size: 22),
        title: Text('Painting',
          style: TextStyle(fontSize:16,color: Color(0xFF2A629A)),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/Painting.jpg',
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'We offer professional painting services for both residential and commercial properties. Our skilled painters are dedicated to transforming your space with high-quality paint and meticulous attention to detail. Whether you need interior painting, exterior painting, or other specialized painting services, our experienced team will deliver exceptional results. We use premium paints, advanced techniques, and a keen eye for aesthetics to ensure a flawless finish that exceeds your expectations.',
                style: TextStyle(fontSize: 12 , fontWeight: FontWeight.normal,color: Colors.blueGrey),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '!!Don\'t forget to read the order cancellation policy on the booking page!!',
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.blueGrey),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Notice:The price does not include any external parts But this is the price of labor',
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.blueGrey),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'What can this service include and what are the prices in hour?',
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.blueGrey),
                textAlign: TextAlign.start,
              ),
            ),
            ServiceOption(
              serviceName: 'Exterior Painting',
              price: 300.0,
            ),
            ServiceOption(
              serviceName: 'Interior Painting',
              price: 200.0,
            ),
            // Add more ServiceOption widgets for other customizations
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            List<AllProviderSameServiceModel> allProviders=await GetAllProviderSameServices().getAllProviderSame(
              serviceId: Provider.of<GetAllServicesProvider>(context,listen: false).getAllServices![3].id,
              token: Provider.of<ClientLoginProvider>(context, listen: false).getClientModel!.token,
            );
            Provider.of<AllProviderSameProvider>(context,listen: false).setAllProviderSameModel(allProviders);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaintingServList()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2A629A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            'Accept & Continue',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
class ServiceOption extends StatelessWidget {
  final String serviceName;
  final double price;

  ServiceOption({required this.serviceName, required this.price});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(serviceName,style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.blueGrey
      ),),
      trailing: Text('\$$price',style: TextStyle(
        fontWeight: FontWeight.bold,
      ),),
    );
  }
}