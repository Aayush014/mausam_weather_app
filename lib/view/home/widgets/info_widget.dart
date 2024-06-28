import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/res/images/image_assets.dart';
import 'package:weather_app/view/home/widgets/components/frosted_container.dart';
import 'package:weather_app/view/home/widgets/components/horizontal_container.dart';
import 'package:weather_app/view/home/widgets/components/info_row.dart';

import '../../../view_model/controller/global_controller.dart';
import 'components/vertical_container.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, globalProvider, child) {
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: VerticalContainer(
                          label: 'Sunrise',
                          value: globalProvider.sunriseTime(),
                          imagePath: ImageAssets.sunrise,
                        ),
                      ),
                      Expanded(
                        child: VerticalContainer(
                          label: 'Sunset',
                          value: globalProvider.sunsetTime(),
                          imagePath: ImageAssets.sunset,
                        ),
                      ),
                    ],
                  ),
                  HorizontalContainer(
                    label: globalProvider.windDirection(),
                    value: globalProvider.windSpeed(),
                    imagePath: ImageAssets.wind,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FrostedContainer(
                height: 170,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      InfoRow(
                        label: 'Real Feel',
                        value: '${globalProvider.feelsLike()} °C',
                      ),
                      InfoRow(
                        label: 'Pressure',
                        value: globalProvider.pressure(),
                      ),
                      InfoRow(
                        label: 'Humidity',
                        value: globalProvider.humidity(),
                      ),
                      InfoRow(
                        label: 'Visibility',
                        value: globalProvider.visibility(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
