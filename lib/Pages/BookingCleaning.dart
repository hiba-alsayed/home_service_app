import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/Providers/ClientLoginProvider.dart';
import 'package:untitled1/Services/CreatAppointmentService.dart';

import '../Providers/AllProviderSameServiceProvider.dart';

class BookingCleaning extends StatefulWidget {
  const BookingCleaning({super.key});

  @override
  _BookingCleaningState createState() => _BookingCleaningState();
}
final _TextEditingController= new TextEditingController();
class _BookingCleaningState extends State<BookingCleaning> {
  DateTime? _selectedDateTime;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Color(0xFF2A629A), size: 22),
        title: Text(
          'Cleaning',
          style: TextStyle(fontSize: 16, color: Color(0xFF2A629A)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.grey),
                      SizedBox(width: 8.0),
                      Text(
                        'Alert Information',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'The order can only be canceled before 24 hours.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.blueGrey),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2A629A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      onPressed: _isLoading
                          ? null
                          : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        final dateTime = await showOmniDateTimePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
                          lastDate: DateTime.now().add(const Duration(days: 3652)),
                          is24HourMode: false,
                          isShowSeconds: false,
                          minutesInterval: 1,
                          secondsInterval: 1,
                          transitionBuilder: (context, anim1, anim2, child) {
                            return FadeTransition(
                              opacity: anim1.drive(
                                Tween(
                                  begin: 0,
                                  end: 1,
                                ),
                              ),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 200),
                          barrierDismissible: true,
                          selectableDayPredicate: (dateTime) {
                            if (dateTime == DateTime(2023, 2, 25)) {
                              return false;
                            } else {
                              return true;
                            }
                          },
                        );
                        if (dateTime != null) {
                          setState(() {
                            _selectedDateTime = dateTime;
                            _isLoading = false;
                          });
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_isLoading)
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          else ...[
                            Text(
                              'Select Date and Time',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 8.0),
                            Icon(Icons.arrow_forward_ios_sharp, size: 12.0),
                          ],
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  if (_selectedDateTime != null)
                    Text(
                      'Selected Date and Time: ${DateFormat('yyyy-MM-dd').format(_selectedDateTime!)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: _TextEditingController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add order details',
                  hintStyle: TextStyle(fontSize: 14.0),
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    print(DateFormat('yyyy-MM-dd').format(_selectedDateTime!)
                    );
                    print(DateFormat('HH:mm').format(_selectedDateTime!)
                    );
                    Map<String,dynamic>booking=await CreatAppointementService().creatAppointementService(
                      id: Provider.of<AllProviderSameProvider>(context,listen:false).id,
                      token: Provider.of<ClientLoginProvider>(context,listen: false).getClientModel!.token,
                     description: _TextEditingController.text,
                     date: DateFormat('yyyy-MM-dd').format(_selectedDateTime!),
                      hours: DateFormat('HH:mm').format(_selectedDateTime!),
                      );
                   String message=booking["message"];
                    if(message=="Appointment created successfully"){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Success'),
                        content: Text(message),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                    // Confirm action
                  }
                    },
                  child: Row(
                    children: [
                      Text('Confirm'),
                      SizedBox(width: 8.0),
                      Icon(Icons.check, size: 14.0),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2A629A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
