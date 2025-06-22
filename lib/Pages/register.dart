import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Models/ClientRegisterModel.dart';
import '../Providers/ClientRegisterProvider.dart';
import '../Services/ClientRegisterServices.dart';
import 'Order_Service_Provider.dart';
import 'country_city.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 // final TextEditingController _phoneNumberController = TextEditingController();
  bool _isObscure = true;
  String _selectedCountry = '';
  String _selectedCity = '';
  String? message;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _selectCountry(BuildContext context) async {
    final selectedCountry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CountryCityScreen()),
    );
    if (selectedCountry != null) {
      setState(() {
        _selectedCountry = selectedCountry;
      });
    }
  }

  void _selectCity(BuildContext context) async {
    if (_selectedCountry.isNotEmpty) {
      final selectedCity = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CityScreen(selectedCountry: _selectedCountry),
        ),
      );
      if (selectedCity != null) {
        setState(() {
          _selectedCity = selectedCity;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a country first.")),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    //_phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome, Sign Up Now",
                  style: const TextStyle(
                    fontSize: 25,
                    color: Color(0xFF2A629A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name must not be empty";
                    }
                    return null;
                  },
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                ),
                const SizedBox(height: 15),
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
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password must not be empty";
                    }
                    return null;
                  },
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: _toggleObscure,
                      child: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                ),
                const SizedBox(height: 15),
               /* TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone number must not be empty";
                    }
                    return null;
                  },
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                ),*/
                SizedBox(height: 15),
                TextFormField(
                  onTap: () => _selectCountry(context),
                  decoration: InputDecoration(
                    hintText: 'Country',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  controller: TextEditingController(text: _selectedCountry),
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onTap: () => _selectCity(context),
                  decoration: InputDecoration(
                    hintText: 'City',
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  controller: TextEditingController(text: _selectedCity),
                  readOnly: true,
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  color: Color(0xFF2A629A),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_selectedCountry.isNotEmpty && _selectedCity.isNotEmpty) {
                          try {
                            // Accessing the provider with listen: false
                            var clientRegisterProvider = Provider.of<ClientRegisterProvider>(context, listen: false);
                            print("******************${clientRegisterProvider.city_id}");

                            RegisterModel registerModel = await ClientRegisterServices().registerServices(
                              name: _firstNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              city_id: "${clientRegisterProvider.city_id}", // corrected property name
                              deviceToken: "dfgvfdghdshdsfffgrgertg56465434FCM",
                            );

                            print(registerModel.token);
                            print(registerModel.roleId);
                            print(registerModel.roleName);
                            print(registerModel.message);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${registerModel.message}'),
                              ),
                            );

                            if (registerModel.message == " created successfully") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ServiceProviderOrder()),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                            print(e.toString());
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text("Please select a country and city."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },

                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
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
