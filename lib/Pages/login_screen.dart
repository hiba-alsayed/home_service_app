import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Models/ClientLoginModel.dart';
import 'package:untitled1/Models/GetAllRegionsModel.dart';
import 'package:untitled1/Models/GetAllServicesModel.dart';
import 'package:untitled1/Models/ProviderLoginModel.dart';
import 'package:untitled1/Pages/register.dart';
import 'package:untitled1/Providers/GetAllRegionsProvider.dart';
import 'package:untitled1/Providers/GetAllServicesProvider.dart';
import 'package:untitled1/Providers/ProviderLoginProvider.dart';
import 'package:untitled1/Services/GetAllRegionsServices.dart';
import 'package:untitled1/Services/GetAllServices.dart';
import 'package:untitled1/Services/ProviderLoginServices.dart';
import '../Models/ClientRegisterModel.dart';
import '../Providers/ClientLoginProvider.dart';
import '../Services/ClientLoginService.dart';
import 'HomePage.dart';
import 'Order_Service_Provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  String? message;
  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome back!",
                          style: TextStyle(
                            fontSize: 40,
                            color: Color(0xFF2A629A),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email address must not be empty";
                            }
                            return null;
                          },
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password must not be empty";
                            }
                            return null;
                          },
                          controller: _passwordController,
                          obscureText: _isObscure,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: _toggleObscure,
                              child: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  List<GetAllServicesModel> allServices =
                                      await GetAllServices().getAllService();
                                  Provider.of<GetAllServicesProvider>(context,
                                          listen: false)
                                      .setGetAllServicesModel(allServices);

                                  ClientLoginModel clientLoginModel =
                                      await ClientLoginServices()
                                          .clientLoginServices(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  Provider.of<ClientLoginProvider>(context,
                                          listen: false)
                                      .setClientModel(clientLoginModel);

                                  ProviderLoginModel providerLoginModel =
                                      await ProviderLoginServices()
                                          .loginServices(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    deviceToken: "newDeviceToken",
                                  );

                                  Provider.of<ProviderLoginProvider>(context,
                                          listen: false)
                                      .setProviderModel(providerLoginModel);
                                  print("ggfggfgfgggggg" +
                                      clientLoginModel.roleName[0]);

                                  if (clientLoginModel.message ==
                                          "Login successful" &&
                                      clientLoginModel.roleName[0] ==
                                          "client") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(clientLoginModel.message)),
                                    );
                                  }
                                  print(providerLoginModel.roleName[0]);
                                  if (providerLoginModel.message ==
                                          "Login successful" &&
                                      providerLoginModel.roleName[0] ==
                                          "provider") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceProviderOrder()),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(providerLoginModel.message)),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2A629A),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'Login ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t Have an Account ?'),
                            TextButton(
                              onPressed: () async {
                                List<GetAllRegionsModel> getAllRegion =
                                    await GetAllRegionServices()
                                        .getAllRegions();
                                Provider.of<GetAllRegionsProvider>(context,
                                        listen: false)
                                    .setGetAllRegionsModel(getAllRegion);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Color(0xFF2A629A),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
