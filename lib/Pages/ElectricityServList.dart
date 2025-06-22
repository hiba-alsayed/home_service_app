import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/ProviderInMyCityModel.dart';
import '../main.dart';
import 'CleaningServProvDetails.dart';
import 'ElectricityServProvDetails.dart';
import '../Models/AllProviderSameServiceModel.dart';  // Ensure the model is imported
import '../Providers/AllProviderSameServiceProvider.dart';

class ElectricityServList extends StatelessWidget {
  List<AllProviderSameServiceModel>? allProvider = [];
  List<AllProviderSameServiceModel>?allProvider1=[];
  @override
  Widget build(BuildContext context) {
    allProvider = Provider.of<AllProviderSameProvider>(context, listen: false).getAllProviderSame;
    allProvider1=Provider.of<AllProviderSameProvider>(context,listen: false).getAllProviderSameincity;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF2A629A), size: 22),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            'Find Expert Electrician',
            style: TextStyle(fontSize: 16, color: Color(0xFF2A629A)),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Color(0xFF2A629A),
            labelColor: Color(0xFF2A629A),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'All Providers'),
              Tab(text: 'Providers in My City'),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: allProvider!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              "http:$ipServer:8000/${allProvider![index].image}",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allProvider![index].name ?? 'Unknown',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Color(0xFF2A629A),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                  size: 14.0,
                                ),
                                SizedBox(width: 6.0),
                                Flexible(
                                  child: Text(
                                    '${allProvider![index].yearsOfExperience ?? 0} years of experience',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey,
                                  size: 14.0,
                                ),
                                SizedBox(width: 6.0),
                                Flexible(
                                  child: Text(
                                    allProvider![index].location ?? 'Unknown',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16.0,
                                ),
                                SizedBox(width: 6.0),
                                Text(
                                  allProvider![index].rating.toString() ?? 'No rating',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Details',
                                  style: TextStyle(
                                    color: Color(0xFF2A629A),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ElectricityServProvDetails(
                                          provider: allProvider![index],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF2A629A),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget buildProviderList(BuildContext context, List<ProviderInMyCityModel> providers) {
    return ListView.builder(
      itemCount: allProvider1!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Uncomment and use if image is needed
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Make the image circular
                      image: DecorationImage(
                        image: NetworkImage(
                          "http:$ipServer:8000/${allProvider![index].image}",
                        ),
                        fit: BoxFit.cover, // Cover the container with the image
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allProvider1![index].name ?? 'Unknown',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Color(0xFF2A629A),
                          ),
                          overflow: TextOverflow.ellipsis, // Prevents overflow
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                              size: 14.0,
                            ),
                            SizedBox(width: 6.0),
                            Flexible(
                              child: Text(
                                '${ allProvider1![index].yearsOfExperience ?? 0} years of experience',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey,
                              size: 14.0,
                            ),
                            SizedBox(width: 6.0),
                            Flexible(
                              child: Text(
                                allProvider1![index].location ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16.0,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              allProvider1![index].rating?.toString() ?? 'No rating',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Details',
                              style: TextStyle(
                                color: Color(0xFF2A629A),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CleaningServProvDetails(
                                      provider: allProvider1![index],
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.chevron_right,
                                color: Color(0xFF2A629A),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
