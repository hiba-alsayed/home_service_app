import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Services/AllProviderSameServiceServ.dart';
import '../Models/AllProviderSameServiceModel.dart';
import '../Providers/AllProviderSameServiceProvider.dart';
import '../Providers/ProviderProfileProvider.dart';
import '../main.dart';
import 'BookingCleaning.dart';

class CleaningServProvDetails extends StatelessWidget {
  CleaningServProvDetails({required this.provider});
  final AllProviderSameServiceModel provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Color(0xFF2A629A), size: 22),
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(fontSize: 16, color: Color(0xFF2A629A)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Image(
              image: NetworkImage( "http:$ipServer:8000/${provider.image}"),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 38.0, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey),
                        SizedBox(width: 8.0),
                        Text(
                          '${provider.yearsOfExperience} Years of Experience',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.person_outline, color: Colors.grey),
                    SizedBox(width: 8.0),
                    Text(
                      '${provider.phone}',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 38.0),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  provider.description,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AllProviderSameProvider>(context,listen:false).id="${provider.id}";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingCleaning()),
                        );
                      },
                      child: Row(
                        children: [
                          Text('Book Now'),
                          SizedBox(width: 8.0),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 12.0,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2A629A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
