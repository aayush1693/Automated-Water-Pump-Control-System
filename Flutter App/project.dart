import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class WaterPumpController {
  bool isPumpOn = false;

  void turnOnPump() {
    isPumpOn = true;
  }

  void turnOffPump() {
    isPumpOn = false;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automated Water Control',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WaterPumpController _controller = WaterPumpController();
  double waterLevel = 75.0; // Example water level percentage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Automated Water Control',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 100,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 100,
                  height: 200 * (100 - waterLevel) / 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Text(
                  '${waterLevel.toInt()}%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'Turn On Pump',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                setState(() {
                  _controller.turnOnPump();
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(
                'Turn Off Pump',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                setState(() {
                  _controller.turnOffPump();
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}