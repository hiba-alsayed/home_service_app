import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Models/GetAllRegionsModel.dart';
import 'package:untitled1/Providers/ClientRegisterProvider.dart';
import 'package:untitled1/Providers/GetAllRegionsProvider.dart';
import 'package:untitled1/Providers/GetCitiesByRegionProvider.dart';
import 'package:untitled1/Services/GetCitiesByRegionServices.dart';

import '../Models/GetCitiesByRegionModel.dart';

class CountryCityScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Country'),
      ),
      body: Consumer<GetAllRegionsProvider>(
        builder: (context, regionsProvider, child) {
          if (regionsProvider.getAllRegions == null) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: regionsProvider.getAllRegions!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(regionsProvider.getAllRegions![index].region_name as String),
                onTap: () async {
                  int id = regionsProvider.getAllRegions![index].id;
                  print("****************");
                  print(id);
                  List<GetCitiesByRegionModel> citiesByRegion = await GetCitiesByRegionServices().getAllCitiesByRegion(region_id: id);
                  print("///////////////////////");
                  print(citiesByRegion[0].city_name);
                  print(citiesByRegion[1].city_name);

                  Navigator.pop(context, regionsProvider.getAllRegions![index].region_name);
                  // Set the cities in the provider
                  Provider.of<GetCitiesByRegionProvider>(context, listen: false).setGetCitiesByRegionModel(citiesByRegion);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class CityScreen extends StatelessWidget {
  final String selectedCountry;

  CityScreen({required this.selectedCountry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select City'),
      ),
      body: Consumer<GetCitiesByRegionProvider>(
        builder: (context, citiesProvider, child) {
          if (citiesProvider.getCitiesByRegion == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (citiesProvider.getCitiesByRegion!.isEmpty) {
            return Center(child: Text('No cities available'));
          }
          return ListView.builder(
            itemCount: citiesProvider.getCitiesByRegion!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(citiesProvider.getCitiesByRegion![index].city_name as String),
                onTap: () async {
                  Provider.of<ClientRegisterProvider>(context, listen: false)
                      .setCityId(citiesProvider.getCitiesByRegion![index].id);

                  print("/*//////////////////////////////////");
                  print(citiesProvider.getCitiesByRegion![index].id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
