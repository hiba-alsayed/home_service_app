import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/SearchProvider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _searchController.addListener(() {
      _performSearch();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.searchServiceProviders(
      _searchController.text,
      _searchController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back, color: Colors.white70, size: 22),
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.white70, size: 22),
            ),
            onChanged: (value) {
              _performSearch();
            },
          ),
          backgroundColor: Color(0xFF2A629A),
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: Color(0xFF2A629A),
              labelColor: Color(0xFF2A629A),
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              controller: _tabController,
              tabs: [
                Tab(text: 'Services'),
                Tab(text: 'Providers'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildServiceTab(),
                  _buildProfessionalTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTab() {
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, child) {
        if (searchProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (searchProvider.serviceProviders.isEmpty) {
          return Center(child: Text('Tab to search service'));
        }

        return ListView.builder(
          itemCount: searchProvider.serviceProviders.length,
          itemBuilder: (context, index) {
            final serviceProvider = searchProvider.serviceProviders[index];
            return ListTile(
              // leading: Image.network(serviceProvider.image),
              title: Text(serviceProvider.service),
              subtitle: Text(serviceProvider.description),
              trailing: Text('${serviceProvider.yearsExperience} years'),
            );
          },
        );
      },
    );
  }

  Widget _buildProfessionalTab() {
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, child) {
        if (searchProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (searchProvider.serviceProviders.isEmpty) {
          return Center(child: Text('Tab to search provider'));
        }

        return ListView.builder(
          itemCount: searchProvider.serviceProviders.length,
          itemBuilder: (context, index) {
            final serviceProvider = searchProvider.serviceProviders[index];
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(serviceProvider.providerName),
              subtitle: Text(serviceProvider.providerCity),
              trailing: Text('${serviceProvider.phone}'),
            );
          },
        );
      },
    );
  }
}
