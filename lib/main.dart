import 'package:doctor_home_page/Main_Layout.dart';
import 'package:doctor_home_page/booking_page.dart';
import 'package:doctor_home_page/doctor_details.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => MainLayout(),
        'doc_details':(context) => const DoctorDetails(),
        'booking_page':(context) => BookingPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(


        primarySwatch: Colors.blue,
      ),
    );
  }
}

