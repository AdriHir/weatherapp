import 'package:flutter/material.dart';

class Chartpage extends StatefulWidget {


 Chartpage({super.key, required Set<String> listDailyWheather});

  @override
  State<Chartpage> createState() => _ChartpageState();
}

class _ChartpageState extends State<Chartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Welcome ",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),

                ElevatedButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text("Goback"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
