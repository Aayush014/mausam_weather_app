import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/utils.dart';

import '../../../view_model/controller/global_controller.dart';

class AppbarWidget extends StatefulWidget {
  const AppbarWidget({super.key});

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  String city = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final globalProvider = Provider.of<GlobalProvider>(context, listen: false);
      getAddress(globalProvider.latitude, globalProvider.longitude);
    });
  }

  Future<void> getAddress(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          city = place.locality ?? '';
        });
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(city, style: mediumTextStyle),
              Text(
                Utils.date,
                style: lightTitleTextStyle,
              ),
            ],
          );
        },
      ),
    );
  }
}
