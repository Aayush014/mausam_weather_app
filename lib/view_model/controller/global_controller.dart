import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/network/api_services.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/utils/utils.dart';

class GlobalProvider extends ChangeNotifier {
  bool _isLoading = true;
  double _latitude = 0.0;
  double _longitude = 0.0;
  WeatherModel? _weatherData;
  String _weatherMain = '';

  bool get isLoading => _isLoading;
  double get latitude => _latitude;
  double get longitude => _longitude;
  WeatherModel? get weatherData => _weatherData;
  String get weatherMain => _weatherMain;

  void setWeatherMain(String value) {
    _weatherMain = value;
    notifyListeners();
  }

  String weatherDescription() =>
      _weatherData!.weather![0].description!.toUpperCase().toString();

  String weatherIconCode() => _weatherData!.weather![0].icon.toString();

  String currentTemperature() =>
      _weatherData!.main!.temp!.round().toString();

  String minTemperature() =>
      _weatherData!.main!.tempMin!.round().toString();

  String maxTemperature() =>
      _weatherData!.main!.tempMax!.round().toString();

  String pressure() => '${_weatherData!.main!.pressure.toString()} hPa';

  String humidity() => '${_weatherData!.main!.humidity.toString()} %';

  String visibility() =>
      Utils.convertVisibility(_weatherData!.visibility.toString());

  String sunriseTime() =>
      Utils.convertTimestampToTime(_weatherData!.sys!.sunrise.toString());

  String sunsetTime() =>
      Utils.convertTimestampToTime(_weatherData!.sys!.sunset.toString());

  String windSpeed() =>
      Utils.convertSpeed(_weatherData!.wind!.speed.toString());

  String windDirection() =>
      Utils.getWindDirection(_weatherData!.wind!.deg.toString());

  String feelsLike() => _weatherData!.main!.feelsLike!.round().toString();

  String dtValue() => Utils.convertDtToTime(_weatherData!.dt.toString());

  Future<void> getLocationAndFetchWeather() async {
    try {
      await _getLocation();
      await _getWeather();
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      _latitude = position.latitude;
      _longitude = position.longitude;
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _getWeather() async {
    try {
      final weatherData = await ApiServices().getWeatherApi(
        _latitude,
        _longitude,
      );

      _weatherData = WeatherModel.fromJson(weatherData);
      setWeatherMain(_weatherData!.weather![0].main!.toString());
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }
}
