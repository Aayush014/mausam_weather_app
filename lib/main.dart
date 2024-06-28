import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/res/app_color.dart';
import 'package:weather_app/view/home/home_screen.dart';
import 'package:weather_app/view_model/controller/global_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mausam',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.defaultAppColor,
            brightness: Brightness.dark
          ),
          useMaterial3: true,
          fontFamily: 'Lato',
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
