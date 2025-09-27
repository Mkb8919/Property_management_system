import 'package:flutter/material.dart';
import 'screens/property_screen.dart';
import 'screens/agent_screen.dart';
import 'screens/dashboard_screen.dart';
import 'services/api_service.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Estate Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // HomeScreen me ab instance ki zarurat nahi, static method use karenge

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Real Estate Admin Panel")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Manage Properties"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PropertyScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Manage Agents"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AgentScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Dashboard"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DashboardScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Test Backend"),
              onPressed: () async {
                try {
                  // Static method call
                  await ApiService.testGetRequest();
                } catch (e) {
                  print("Error: $e");
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
