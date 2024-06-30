import 'package:mausam/screens/location_screen.dart';
import 'package:mausam/services/weather.dart';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';



class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    getlocationdata();
    super.initState();
  }

  void getlocationdata() async {
    var weatherdata= await WeatherModel().getweatherlocation();
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          data: weatherdata,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          duration: Duration(seconds: 2),
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
