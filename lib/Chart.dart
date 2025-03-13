import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wefund/ThemeProvider.dart';
class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("chart", style: TextStyle(  fontSize: 22.px,
                fontWeight: FontWeight.w700,)),
        ),
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white, iconTheme: IconThemeData(
    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
  ),
      ),
      body: Center(
          child: Text("chart Page",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w800))),
    );
  }
}
