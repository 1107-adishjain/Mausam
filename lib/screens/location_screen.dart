import 'package:mausam/screens/city-screeen.dart';
import 'package:mausam/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:mausam/utilities.dart/constants.dart';

WeatherModel messandsign = WeatherModel();

// ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  LocationScreen({super.key, this.data});

  @override
  // ignore: library_private_types_in_public_api
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late double temp;
  late int id;
  late String message;
  late String cityname;
  @override
  void initState() {
    updateval(widget.data);
    super.initState();
  }

  void updateval(var weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0.0;
        id = 0;
        cityname = "Unknown";
        return;
      } else {
        temp = weatherData['main']['temp'];
        id = weatherData['weather'][0]['id'];
        cityname = weatherData["name"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherr = await WeatherModel().getweatherlocation();
                      updateval(weatherr);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typetext = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityScreen(),
                        ),
                      );
                      if (typetext != null) {
                        var dataaa = await messandsign.getcityweather(typetext);
                        updateval(dataaa);
                      }
                      else{
                        throw "Error";
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${temp.toInt()}°C",
                      style: kTempTextStyle,
                    ),
                    Text(
                      (widget.data != null)
                          ? messandsign.getWeatherIcon(id)
                          : messandsign.getWeatherIcon(0),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  (temp!=0)
                      ? "${messandsign.getMessage(temp)} in $cityname"
                      : "Unable to get weather data",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
