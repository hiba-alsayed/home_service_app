import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Pages/GetStarted.dart';
import 'package:untitled1/Pages/SearchPage.dart';
import 'package:untitled1/Pages/login_screen.dart';
import 'package:untitled1/Pages/register.dart';
import 'package:untitled1/Pages/save_photo.dart';
import 'package:untitled1/Pages/ser_pro_profile.dart';
import 'package:untitled1/Providers/AppointmentApprovedProvider.dart';
import 'package:untitled1/Providers/GetAllRegionsProvider.dart';
import 'package:untitled1/Providers/GetAllServicesProvider.dart';
import 'package:untitled1/Providers/GetCitiesByRegionProvider.dart';
import 'package:untitled1/Providers/ProviderLoginProvider.dart';
import 'Pages/CleaningServList.dart';
import 'Providers/AdsProvider.dart';
import 'Providers/AllProviderSameServiceProvider.dart';
import 'Providers/AppointmentCancelProvider.dart';
import 'Providers/AppointmentProvider.dart';
import 'Providers/ClientLoginProvider.dart';
import 'Providers/ClientRegisterProvider.dart';
import 'Pages/HomePage.dart';
import 'Pages/Order_Service_Provider.dart';
import 'Providers/ProviderProfileProvider.dart';
import '../Services/ProviderInMyCityService.dart';
import 'Providers/SearchProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetCitiesByRegionProvider()),
        ChangeNotifierProvider(create: (_) => GetAllRegionsProvider()),
        ChangeNotifierProvider(create: (_) => GetAllServicesProvider()),
        ChangeNotifierProvider(create: (_) => ClientLoginProvider()),
        ChangeNotifierProvider(create: (_) => ClientRegisterProvider()),
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (_) => ProfilenameProvider()),
        ChangeNotifierProvider(create: (_) => ProviderLoginProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => AllProviderSameProvider()),
        ChangeNotifierProvider(create: (_) => ProviderProfileProvider()),
        ChangeNotifierProvider(create: (_) => AdsProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentApprovedProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentCancelProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
String ipServer = "192.168.1.13";
