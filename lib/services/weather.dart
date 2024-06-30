import 'package:mausam/services/networking.dart';
import 'package:mausam/utilities.dart/constants.dart';
import 'package:mausam/services/location.dart';
class WeatherModel {

  
  Future getcityweather(String typedcityname) async
  {
    var url="https://api.openweathermap.org/data/2.5/weather?q=$typedcityname&appid=$kapikey&units=metric";
    Networkhelper net=Networkhelper(url);
    var weatherdata= await net.getdata();
    return weatherdata;
  }


   Future <dynamic> getweatherlocation() async 
   {
    Location loc = Location();
    await loc.getcurrentlocation(); 
    Networkhelper network = Networkhelper("https://api.openweathermap.org/data/2.5/weather?lat=${loc.latitude}&lon=${loc.longitude}&appid=$kapikey&units=metric");
    var weatherdata = await network.getdata();
    return weatherdata;
   }


  String getWeatherIcon(int condition) {
    if (condition < 300&&condition>0) {
      return '🌩';
    } else if (condition < 400&&condition>0) {
      return '🌧';
    } else if (condition < 600&&condition>0) {
      return '☔️';
    } else if (condition < 700&&condition>0) {
      return '☃️';
    } else if (condition < 800&&condition>0) {
      return '🌫';
    } else if (condition == 800&&condition>0) {
      return '☀️';
    } else if (condition <= 804&&condition>0) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}