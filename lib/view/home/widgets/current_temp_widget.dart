import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/constants.dart';

import '../../../view_model/controller/global_controller.dart';

class CurrentTempWidget extends StatelessWidget {
  const CurrentTempWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .6,
      child: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/weather/${globalProvider.weatherIconCode()}.png',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    globalProvider.currentTemperature(),
                    style: largeTextStyle,
                  ),
                  Text(
                    '°C',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              Text(
                globalProvider.weatherDescription(),
                style: titleTextStyle,
              ),
            ],
          );
        },
      ),
    );
  }
}
