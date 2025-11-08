import 'package:calculator_app/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Use_State',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: 'calculator',
          routes: {
            'calculator':(context)=>Calculator(),

          },
        );
      },

    );
  }
}