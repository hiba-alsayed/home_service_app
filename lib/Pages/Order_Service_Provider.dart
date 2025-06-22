import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Pages/login_screen.dart';
import 'package:untitled1/Pages/save_photo.dart';
import 'package:untitled1/Pages/ser_pro_subscriptions.dart';
import 'package:untitled1/Pages/ser_pro_wallet.dart';
import 'package:untitled1/Services/ProviderLogoutServices.dart';
import '../Providers/ProviderLoginProvider.dart';
import 'rating&comment.dart';
import 'ser_pro_order_details.dart';
import 'ser_pro_profile.dart';
import 'OrderDetails.dart';

class ServiceProviderOrder extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<ServiceProviderOrder> {
  final List<Map<String, dynamic>> orders = [
    {
      'service': 'Cleaning',
      'date': 'May 25, 2024',
      'provider': 'John Doe',
      'price': '\$50',
      'status': 'InProcess',
      'statusColor': Colors.orange,
      'statusIcon': Icons.waving_hand_rounded,
    },
    {
      'service': 'Plumbing',
      'date': 'May 26, 2024',
      'provider': 'Jane Smith',
      'price': '\$75',
      'status': 'Completed',
      'statusColor': Colors.green,
      'statusIcon': Icons.pending,
    },
    {
      'service': 'Cleaning',
      'date': 'May 26, 2024',
      'provider': 'Sarah Lee',
      'price': '\$20',
      'status': 'Canceled',
      'statusColor': Colors.red,
      'statusIcon': Icons.cancel,
    },
  ];

  String _selectedStatus = 'InProcess';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredOrders =
        orders.where((order) => order['status'] == _selectedStatus).toList();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            color: Color(0xFF2A629A),
          ),
        ],
        backgroundColor: Colors.white,
        title: const Text('My Orders',
            style: TextStyle(fontSize: 16, color: Color(0xFF2A629A))),
        centerTitle: true,
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Consumer2<ProfileImageProvider, ProfilenameProvider>(
              builder:
                  (context, profileImageProvider, profilenameProvider, child) {
                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF2A629A)),
                  accountName: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(profilenameProvider.name),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: profileImageProvider.profileImage != null
                        ? FileImage(
                            File(profileImageProvider.profileImage!.path))
                        : null,
                    child: profileImageProvider.profileImage == null
                        ? Icon(Icons.person, size: 50.0)
                        : null,
                  ),
                  accountEmail: null,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceProviderProfile(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.wallet),
              title: Text('My Wallet'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.subscriptions),
              title: Text('My Subscriptions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubscriptionScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text('Rating & Comment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RatingCommentScreen(),
                  ),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  try {
                    // Accessing the provider with listen: false
                    String? token = Provider.of<ProviderLoginProvider>(context,listen: false).getProviderModel!.token;
                    if (token == null) {
                      throw Exception("Token is null");
                    }
                    print("Token: $token"); // Debug the token

                    Map<String, dynamic> logout = await ProviderLogoutServices().providerLogoutServices(token: token);

                    print(logout);
                    String message = logout["message"];

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );

                    if (message == "User logged out Successfully") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                    print("Exception: $e");
                  }
                }),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigation bar
          Container(
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
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedStatus = 'InProcess';
                      });
                    },
                    child: Text(
                      'InProcess',
                      style: TextStyle(
                        color: _selectedStatus == 'InProcess'
                            ? Color(0xFF2A629A)
                            : Colors.grey,
                        fontSize: _selectedStatus == 'InProcess' ? 14.0 : 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedStatus = 'Completed';
                      });
                    },
                    child: Text(
                      'Completed',
                      style: TextStyle(
                        color: _selectedStatus == 'Completed'
                            ? Color(0xFF2A629A)
                            : Colors.grey,
                        fontSize: _selectedStatus == 'Completed' ? 14.0 : 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedStatus = 'Canceled';
                      });
                    },
                    child: Text(
                      'Canceled',
                      style: TextStyle(
                        color: _selectedStatus == 'Canceled'
                            ? Color(0xFF2A629A)
                            : Colors.grey,
                        fontSize: _selectedStatus == 'Canceled' ? 14.0 : 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return _buildOrderCard(order);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SerProOrederDetails(
                order: order,
              ),
            ),
          );
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order['service'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'User Name: ${order['provider']}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFF2A629A),
                    ),
                  ],
                ),
                Text(
                  'Date: ${order['date']}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price: ${order['price']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          order['statusIcon'],
                          color: order['statusColor'],
                        ),
                        SizedBox(width: 4),
                        Text(
                          order['status'],
                          style: TextStyle(
                            color: order['statusColor'],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
