import 'package:flutter/material.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'f17e0ff5fbecbe657359f059887bc01b';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkhelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');

    var weatherData = await networkhelper.getData();

    double temperature = weatherData['main']['temp'];
    int id = weatherData['weather'][0]['id'];
    String country = weatherData['name'];

    print(temperature);
    print(id);
    print(country);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(weatherData);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        color: Colors.blue,
        size: 50.0,
      )),
    );
  }
}
