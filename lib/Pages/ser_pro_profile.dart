import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Pages/save_photo.dart';

class ServiceProviderProfile extends StatefulWidget {
  @override
  _ServiceProviderProfileState createState() => _ServiceProviderProfileState();
}

class _ServiceProviderProfileState extends State<ServiceProviderProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _yearsOfExperienceController = TextEditingController();
  bool _isEditing = false;
  String? _selectedCountry;
  String? _selectedCity;
  String? _selectedService;
  final _picker = ImagePicker();

  List<String> services = ['Cleaning', 'Plumbing', 'Electricity', 'Painting'];
  List<String> countries = ['Country A', 'Country B', 'Country C'];
  Map<String, List<String>> citiesByCountry = {
    'Country A': ['City A1', 'City A2'],
    'Country B': ['City B1', 'City B2'],
    'Country C': ['City C1', 'City C2'],
  };

  @override
  void initState() {
    super.initState();
    _nameController.text = 'John Doe';
    _phoneNumberController.text = '0933120339';
    _descriptionController.text =
    'Our cleaning process involves carefully dusting, vacuuming, and wiping down all accessible electric service components to remove accumulated dust, debris, and grime.';
    _yearsOfExperienceController.text = '5 years';
  }

  Future<void> _pickProfileImage() async {
    final XFile? image = await _picker.pickImage(
      source: _isEditing ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      Provider.of<ProfileImageProvider>(context, listen: false)
          .setProfileImage(image);
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    String name = _nameController.text;
    String phoneNumber = _phoneNumberController.text;
    String description = _descriptionController.text;
    int yearsOfExperience =
        int.tryParse(_yearsOfExperienceController.text) ?? 0;
    String? selectedService = _selectedService;

    // Add additional logic to save the profile information to a backend or local storage
    // Update the profile name in ProfileProvider
    Provider.of<ProfilenameProvider>(context, listen: false).setName(name);

    _toggleEditMode();
  }

  void _selectCountry(BuildContext context) async {
    final selectedCountry = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Country'),
          content: DropdownButtonFormField<String>(
            value: _selectedCountry,
            onChanged: (String? value) {
              setState(() {
                _selectedCountry = value;
                _selectedCity = null; // Reset city selection when country changes
              });
              Navigator.pop(context, value);
            },
            items: countries.map<DropdownMenuItem<String>>((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _selectCity(BuildContext context) async {
    if (_selectedCountry != null) {
      final selectedCity = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select City'),
            content: DropdownButtonFormField<String>(
              value: _selectedCity,
              onChanged: (String? value) {
                setState(() {
                  _selectedCity = value;
                });
                Navigator.pop(context, value);
              },
              items: citiesByCountry[_selectedCountry]
                  ?.map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList() ??
                  [],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImageProvider = Provider.of<ProfileImageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Provider Profile', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
        actions: [
          if (_isEditing)
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.save),
              onPressed: _saveProfile,
            ),
          IconButton(
            color: Colors.white,
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: _toggleEditMode,
          ),
        ],
        backgroundColor: Color(0xFF2A629A), // Primary color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _isEditing ? _pickProfileImage : null,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF2A629A), // Profile image background
                    radius: 60.0,
                    backgroundImage: profileImageProvider.profileImage != null
                        ? FileImage(
                        File(profileImageProvider.profileImage!.path))
                        : null,
                    child: profileImageProvider.profileImage == null
                        ? Icon(Icons.person, size: 60.0, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              if (_isEditing)
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          profileImageProvider.setProfileImage(image);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2A629A), // Button background color
                        ),
                        child: Text(
                          'Pick Image from Gallery',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.camera);
                          profileImageProvider.setProfileImage(image);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2A629A), // Button background color
                        ),
                        child: Text(
                          'Pick Image from Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20.0),
              if (_isEditing)
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Color(0xFF2A629A), // Label color
                      fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Color(0xFF2A629A),
                        width: 1.0,
                      ),
                    ),
                  ),
                )
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name:',
                        style:
                        TextStyle(fontSize: 15, color: Color(0xFF2A629A))),
                    Text('${_nameController.text}',
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              SizedBox(height: 20.0),
              if (_isEditing)
                TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      color: Color(0xFF2A629A), // Label color
                      fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Color(0xFF2A629A),
                        width: 1.0,
                      ),
                    ),
                  ),
                )
              else
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone Number:',
                        style: TextStyle(fontSize: 15, color: Color(0xFF2A629A))),
                    Text('${_phoneNumberController.text}',
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              SizedBox(height: 20.0),
              if (_isEditing)
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Color(0xFF2A629A), // Label color
                      fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Color(0xFF2A629A),
                        width: 1.0,
                      ),
                    ),
                  ),
                )
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description:',
                        style: TextStyle(fontSize: 15, color: Color(0xFF2A629A))),
                    Text('${_descriptionController.text}',
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              SizedBox(height: 20.0),
              if (_isEditing)
                TextField(
                  controller: _yearsOfExperienceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Years of Experience',
                    labelStyle: TextStyle(
                      color: Color(0xFF2A629A), // Label color
                      fontSize: 16.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Color(0xFF2A629A),
                        width: 1.0,
                      ),
                    ),
                  ),
                )
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Years of Experience:',
                        style: TextStyle(fontSize: 15, color: Color(0xFF2A629A))),
                    Text('${_yearsOfExperienceController.text}',
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              SizedBox(height: 20.0),
              if (_isEditing)
                Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedService,
                      items: services.map((String service) {
                        return DropdownMenuItem<String>(
                          value: service,
                          child: Text(service),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedService = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Service',
                        labelStyle: TextStyle(
                          color: Color(0xFF2A629A), // Label color
                          fontSize: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Color(0xFF2A629A),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedCountry,
                      items: countries.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCountry = newValue;
                          _selectedCity = null; // Reset city selection when country changes
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Country',
                        labelStyle: TextStyle(
                          color: Color(0xFF2A629A), // Label color
                          fontSize: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Color(0xFF2A629A),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    if (_selectedCountry != null)
                      DropdownButtonFormField<String>(
                        value: _selectedCity,
                        items: citiesByCountry[_selectedCountry]
                            ?.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList() ??
                            [],
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCity = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Select City',
                          labelStyle: TextStyle(
                            color: Color(0xFF2A629A), // Label color
                            fontSize: 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Color(0xFF2A629A),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service:',
                        style: TextStyle(fontSize: 15, color: Color(0xFF2A629A))),
                    Text('${_selectedService ?? ''}',
                        style: TextStyle(fontSize: 15)),
                    SizedBox(height: 8.0),
                    Text('Country:',
                        style: TextStyle(fontSize: 15, color: Color(0xFF2A629A))),
                    Text('${_selectedCountry ?? ''}',
                        style: TextStyle(fontSize: 15)),
                    SizedBox(height: 8.0),
                    Text('City:',
                        style: TextStyle(fontSize: 15, color: Color(0xFF2A629A))),
                    Text('${_selectedCity ?? ''}', style: TextStyle(fontSize: 15)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
