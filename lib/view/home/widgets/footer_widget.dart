import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/constants.dart';

import '../../../view_model/controller/global_controller.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'OpenWeather',
                style: lightBodyTextStyle,
              ),
              Text(
                'Last updated ${globalProvider.dtValue()}',
                style: lightBodyTextStyle,
              ),
            ],
          );
        },
      ),
    );
  }
}
