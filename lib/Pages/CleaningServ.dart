import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Models/AllProviderSameServiceModel.dart';
import 'package:untitled1/Providers/ClientLoginProvider.dart';
import 'package:untitled1/Providers/GetAllServicesProvider.dart';
import 'package:untitled1/Services/AllProviderSameServiceServ.dart';
import '../Providers/AllProviderSameServiceProvider.dart';
import '../Services/ProviderInMyCityService.dart';
import '../Services/ProviderInMyCityService.dart';
import '../Services/ProviderInMyCityService.dart';
import '../Services/ProviderInMyCityService.dart';
import '../Services/ProviderInMyCityService.dart';
import 'CleaningServList.dart';

class CleaningServ extends StatelessWidget {
  const CleaningServ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF2A629A), size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Cleaning',
          style: TextStyle(fontSize: 16, color: Color(0xFF2A629A)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('images/cleaning.jpeg'),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'We offer you a professional cleaning service that offers a wide range of cleaning solutions for residential and commercial properties...',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.blueGrey),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '!!Don\'t forget to read the order cancellation policy on the booking page!!',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.blueGrey),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'What can this service include and what are the prices in hour?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.blueGrey),
                textAlign: TextAlign.start,
              ),
            ),
            ServiceOption(
              serviceName: 'Furniture & carpet Cleaning',
              price: 60,
            ),
            ServiceOption(
              serviceName: 'Deep Cleaning',
              price: 50,
            ),
            ServiceOption(
              serviceName: 'Normal Cleaning',
              price: 20,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            List<AllProviderSameServiceModel> allProviders=await GetAllProviderSameServices().getAllProviderSame(
              serviceId: Provider.of<GetAllServicesProvider>(context,listen: false).getAllServices![0].id,
              token: Provider.of<ClientLoginProvider>(context, listen: false).getClientModel!.token,
            );
            Provider.of<AllProviderSameProvider>(context,listen: false).setAllProviderSameModel(allProviders);


            List<AllProviderSameServiceModel> allProviders1=await ProviderInMyCityService().providerInMyCityService(
              serviceID: Provider.of<GetAllServicesProvider>(context,listen: false).getAllServices![0].id,
              token: Provider.of<ClientLoginProvider>(context, listen: false).getClientModel!.token,
            );

            Provider.of<AllProviderSameProvider>(context,listen: false).setAllProviderSameincityModel(allProviders1);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CleaningServList()),
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
      title: Text(
        serviceName,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.blueGrey),
      ),
      trailing: Text(
        '\$$price',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
