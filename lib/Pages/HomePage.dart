import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/AdModel.dart';
import '../Models/GetAllServicesModel.dart';
import '../Providers/AdsProvider.dart';
import '../Providers/AppointmentProvider.dart';
import '../Providers/ClientLoginProvider.dart';
import '../Providers/GetAllServicesProvider.dart';
import '../Services/ClientLogoutServices.dart';
import 'CleaningServ.dart';
import 'ElectricityServ.dart';
import 'InstantOrders.dart';
import 'MyOrders.dart';
import 'PaintingServ.dart';
import 'PlumpingServ.dart';
import 'SearchPage.dart';
import 'UserProf.dart';
import 'login_screen.dart';

// Data model for professionals
class Professional {
  final String name;
  final String serviceType;
  final String imagePath;

  Professional({
    required this.name,
    required this.serviceType,
    required this.imagePath,
  });
}

List<GetAllServicesModel>? allServices = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override

  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isLoadingOrders = false;

  final List<Widget> _pages = [
    HomePageContent(),
    MyOrdersContent(),  // Placeholder for My Orders content
    UserProf(),
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) { // "My Orders" tab
      setState(() {
        isLoadingOrders = true;
      });

      final token = Provider.of<ClientLoginProvider>(context, listen: false).getClientModel?.token;

      if (token != null) {
        await Provider.of<AppointmentProvider>(context, listen: false).fetchAppointments(token);
      }

      setState(() {
        isLoadingOrders = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AdsProvider>(context, listen: false).fetchAds());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadingOrders
          ? Center(child: CircularProgressIndicator())
          : _pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InstantOrders()),
          );
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add, color: Colors.white),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF2A629A),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// class MyOrdersContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppointmentProvider>(
//       builder: (ctx, appointmentProvider, _) {
//         final appointments = appointmentProvider.appointments;
//
//         if (appointments.isEmpty) {
//           return Center(child: Text('No orders found.'));
//         }
//
//         return ListView.builder(
//           itemCount: appointments.length,
//           itemBuilder: (ctx, i) {
//             final appointment = appointments[i];
//             return ListTile(
//               title: Text(appointment.provider),
//               subtitle: Text(
//                   '${appointment.date} at ${appointment.hour}\n${appointment.city}\n${appointment.description}'),
//               trailing: Text(appointment.status),
//             );
//           },
//         );
//       },
//     );
//   }
// }

class HomePageContent extends StatelessWidget {
  // Sample list of professionals
  final List<Professional> professionals = [
    Professional(
      name: 'John Doe',
      serviceType: 'Cleaning',
      imagePath: 'images/professional1.jpg',
    ),
    Professional(
      name: 'Jane Smith',
      serviceType: 'Plumbing',
      imagePath: 'images/professional2.jpg',
    ),
    Professional(
      name: 'Mike Johnson',
      serviceType: 'Electricity',
      imagePath: 'images/professional3.jpg',
    ),
    Professional(
      name: 'Anna Brown',
      serviceType: 'Painting',
      imagePath: 'images/professional4.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          // Accessing the provider with listen: false
                          dynamic token = Provider.of<ClientLoginProvider>(
                                  context,
                                  listen: false)
                              .getClientModel!
                              .token;

                          Map<String, dynamic> logout =
                              await ClientLogoutServices()
                                  .clientLogoutServices(token: token);

                          String message = logout["message"];

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          );

                          if (message == "User logged out Successfully") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                          print(e.toString());
                        }
                      },
                      icon: Icon(
                        Icons.login_outlined,
                      ),
                    ),

                    // Icon(Icons.login_outlined,),
                    Spacer(),
                    Center(
                      child: Text(
                        'Welcome back!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 34),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'What services do you need today?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    print("****************************");
                    print(allServices!.length);
                    print(Provider.of<GetAllServicesProvider>(context,
                            listen: false)
                        .getAllServices!
                        .length);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                  child:AbsorbPointer(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(Icons.search, size: 22),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        ),
                      ),
                    ),
                  )
                ),
              ),
              SizedBox(height: 28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF2A629A),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              Consumer<GetAllServicesProvider>(
                builder: (context, provider, child) {
                  final services = provider.getAllServices ?? [];

                  if (services.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return ServiceCard(
                          // imagePath: "images/${service.image.toString()}",
                          serviceName: service.name.toString(),
                          subText: service.description.toString(),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Suggested Providers',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 14),
              // Fetching and displaying ads
              Consumer<AdsProvider>(
                builder: (context, adsProvider, child) {
                  final ads = adsProvider.ads;

                  if (ads.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: ads.length,
                    itemBuilder: (context, index) {
                      final ad = ads[index];
                      return AdCard(ad: ad);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget to display individual ad
class AdCard extends StatelessWidget {
  final AdModel ad;
  AdCard({required this.ad});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(14),
        title: Text(
          ad.provider,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color(0xFF2A629A),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ad.service),
            Text(ad.city),
            Text('${ad.yearsExperience} years experience'),
            // Text(ad.description),
          ],
        ),
      ),
    );
  }
}

// عرض الصور ك assets
String getAssetImageForService(String serviceName) {
  switch (serviceName.toLowerCase()) {
    case 'cleaning':
      return 'images/cleaning.jpeg';
    case 'plumber':
      return 'images/plumbing.jpeg';
    case 'electricity':
      return 'images/electricity.jpg';
    case 'painting':
      return 'images/Painting.jpg';
    default:
      return 'images/cleaning.jpeg';
  }
}
class ServiceCard extends StatelessWidget {
  // final String imagePath;
  final String serviceName;
  final String subText;

  ServiceCard({
    // required this.imagePath,
    required this.serviceName,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath = getAssetImageForService(serviceName);
    return InkWell(
      onTap: () {
        if (serviceName == 'Cleaning') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CleaningServ()),
          );
        } else if (serviceName == 'Plumber') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlumpingServ()),
          );
        } else if (serviceName == 'Electricity') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ElectricityServ()),
          );
        } else if (serviceName == 'Painting') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaintingServ()),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 200,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          subText,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfessionalCard extends StatelessWidget {
  final Professional professional;

  ProfessionalCard({required this.professional});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(14),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(professional.imagePath),
        ),
        title: Text(
          professional.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          professional.serviceType,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w300,
          ),
        ),
        trailing: TextButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Details',
                  style: TextStyle(
                    color: Color(0xFF2A629A),
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  color: Color(0xFF2A629A),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
