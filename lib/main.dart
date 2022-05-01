import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupay_assignment/constants/colors.dart';
import 'package:zupay_assignment/model/cart_model.dart';
import 'package:zupay_assignment/screens/homescreen.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CartModel())
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: white,
            fontFamily: GoogleFonts.poppins().fontFamily
          ),
          home: const HomeScreen(),
        );
      }
    );
  }
}