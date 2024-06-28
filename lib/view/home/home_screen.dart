import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/view/home/widgets/appbar_widget.dart';
import 'package:weather_app/view/home/widgets/current_temp_widget.dart';
import 'package:weather_app/view/home/widgets/footer_widget.dart';
import 'package:weather_app/view/home/widgets/info_widget.dart';

import '../../view_model/controller/global_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<GlobalProvider>(context, listen: false).getLocationAndFetchWeather();
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<GlobalProvider>(context, listen: false).getLocationAndFetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator.adaptive(
        onRefresh: _refreshData,
        child: Consumer<GlobalProvider>(
          builder: (context, globalProvider, child) {
            return globalProvider.isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Container(
              decoration: BoxDecoration(
                gradient: Utils.getBackgroundGradient(globalProvider.weatherMain),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: const [
                    AppbarWidget(),
                    CurrentTempWidget(),
                    InfoWidget(),
                    FooterWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
