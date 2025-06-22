import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/AllProviderSameServiceModel.dart';
import '../Providers/AllProviderSameServiceProvider.dart';
import '../main.dart';
import 'PaintingServProvDetails.dart';

class PaintingServList extends StatelessWidget {
  List<AllProviderSameServiceModel>? allProvider = [];

  @override
  Widget build(BuildContext context) {
    allProvider = Provider.of<AllProviderSameProvider>(context, listen: false).getAllProviderSame;

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
            'Find Expert Painter',
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
                              "http://$ipServer:8000/${allProvider![index].image}",
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
                                        builder: (context) => PaintingServProvDetails(
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

  // Example of the buildProviderList function (not used directly in this implementation)
  Widget buildProviderList(BuildContext context, List<AllProviderSameServiceModel> providers) {
    return ListView.builder(
      itemCount: providers.length,
      itemBuilder: (context, index) {
        final provider = providers[index];
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      provider.image ?? 'images/placeholder.jpg',
                      width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.name ?? 'Unknown',
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
                            Text(
                              '${provider.yearsOfExperience} years of experience',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
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
                            Text(
                              provider.location ?? 'Unknown',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
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
                              provider.rating?.toString() ?? 'No rating',
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
                                    builder: (context) => PaintingServProvDetails(
                                      provider: provider,
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
