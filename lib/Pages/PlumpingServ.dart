import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Pages/PlumpingServList.dart';

import '../Models/AllProviderSameServiceModel.dart';
import '../Providers/AllProviderSameServiceProvider.dart';
import '../Providers/ClientLoginProvider.dart';
import '../Providers/GetAllServicesProvider.dart';
import '../Services/AllProviderSameServiceServ.dart';
import '../Services/ProviderInMyCityService.dart';


class PlumpingServ extends StatelessWidget {
  const PlumpingServ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  Icon(Icons.arrow_back, color: Color(0xFF2A629A),size: 22),
        title: Text('Plumping',
          style: TextStyle(fontSize:16,color: Color(0xFF2A629A)),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/plumbing.jpeg',
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'We offer you professional plumbing services for both residential and commercial properties. Our skilled plumbers are equipped to handle a wide range of plumbing issues, including pipe repair, drain cleaning, fixture installation, and more. We prioritize customer satisfaction and provide efficient solutions using the latest tools and techniques. Whether you\'re dealing with a minor leak or a major plumbing emergency, our dedicated team is ready to deliver exceptional service that exceeds your expectations.',
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
                'Notice:The price does not include any spare parts But this is the price of labor',
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
              serviceName: 'External extensions',
              price: 60,
            ),
            ServiceOption(
              serviceName: 'Internal extensions & Drain Cleaning',
              price: 50,
            ),
            ServiceOption(
              serviceName: 'Pipe Repair & Water heater',
              price: 20,
            ),
            // Add more ServiceOption widgets for other customizations
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child:ElevatedButton(
          onPressed: () async {
            List<AllProviderSameServiceModel> allProviders=await GetAllProviderSameServices().getAllProviderSame(
              serviceId: Provider.of<GetAllServicesProvider>(context,listen: false).getAllServices![1].id,
              token: Provider.of<ClientLoginProvider>(context, listen: false).getClientModel!.token,
            );
            Provider.of<AllProviderSameProvider>(context,listen: false).setAllProviderSameModel(allProviders);


            List<AllProviderSameServiceModel> allProviders1=await ProviderInMyCityService().providerInMyCityService(
              serviceID: Provider.of<GetAllServicesProvider>(context,listen: false).getAllServices![1].id,
              token: Provider.of<ClientLoginProvider>(context, listen: false).getClientModel!.token,
            );

            Provider.of<AllProviderSameProvider>(context,listen: false).setAllProviderSameincityModel(allProviders1);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlumbingServList()),
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
