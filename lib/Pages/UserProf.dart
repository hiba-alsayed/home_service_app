import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'country_city.dart';

class UserProf extends StatefulWidget {
  @override
  _UserProfState createState() => _UserProfState();
}

class _UserProfState extends State<UserProf> {
  XFile? _profileImage;
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _yearsOfExperienceController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  bool _isEditing = false;
  String _selectedCountry = '';
  String _selectedCity = '';
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _phoneNumberController.text = '0933120339';
    _descriptionController.text =
    'Our cleaning process involves carefully dusting, vacuuming, and wiping down all accessible electric service components to remove accumulated dust, debris, and grime.';
    _yearsOfExperienceController.text = '5 years';
  }

  Future<void> _pickProfileImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    setState(() {
      _profileImage = image;
    });
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickProfileImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickProfileImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    // Save the updated profile information
    String phoneNumber = _phoneNumberController.text;
    String description = _descriptionController.text;
    int yearsOfExperience =
        int.tryParse(_yearsOfExperienceController.text) ?? 0;

    // You can add additional logic to save the profile information to a backend or local storage

    _toggleEditMode();
  }

  void _selectCountry(BuildContext context) async {
    final selectedCountry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CountryCityScreen()),
    );
    if (selectedCountry != null) {
      setState(() {
        _selectedCountry = selectedCountry;
        _countryController.text = selectedCountry;
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
          _cityController.text = selectedCity;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Color(0xFF2A629A), size: 22),
        title: Text('Profile',style: TextStyle(fontSize: 16, color: Color(0xFF2A629A))),
        centerTitle: true,
        actions: [
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.save,color: Color(0xFF2A629A)),
              onPressed: _saveProfile,
            ),
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit,color: Color(0xFF2A629A)),
            onPressed: _toggleEditMode,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _isEditing ? _showImageSourceDialog : null,
                  child: CircleAvatar(
                    backgroundColor: Colors.black26,
                    radius: 60.0,
                    backgroundImage: _profileImage != null
                        ? FileImage(File(_profileImage!.path))
                        : null,
                    child: _profileImage == null
                        ? Icon(Icons.person, size: 50.0)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              if (_isEditing)
                _buildTextField(
                  controller: _phoneNumberController,
                  label: 'Phone Number',
                )
              else
                _buildDisplayText('Phone Number', _phoneNumberController.text),
              SizedBox(height: 20.0),
              if (_isEditing)
                _buildTextField(
                  controller: _yearsOfExperienceController,
                  label: 'Years of Experience',
                )
              else
                _buildDisplayText(
                    'Years of Experience', _yearsOfExperienceController.text),
              SizedBox(height: 20.0),
              if (_isEditing)
                _buildTextField(
                  controller: _descriptionController,
                  label: 'About Myself',
                )
              else
                _buildDisplayText('About Myself', _descriptionController.text),
              SizedBox(height: 20.0),
              if (_isEditing)
                _buildTextField(
                  controller: _countryController,
                  label: 'Country',
                  readOnly: true,
                  onTap: () => _selectCountry(context),
                )
              else
                _buildDisplayText('Country', _selectedCountry),
              const SizedBox(height: 20),
              if (_isEditing)
                _buildTextField(
                  controller: _cityController,
                  label: 'City',
                  readOnly: true,
                  onTap: () => _selectCity(context),
                )
              else
                _buildDisplayText('City', _selectedCity),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
        required String label,
        bool readOnly = false,
        VoidCallback? onTap}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Color(0xFF2A629A),
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
    );
  }

  Widget _buildDisplayText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(fontSize: 15, color: Color(0xFF2A629A)),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
