import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_screen.dart';

// Your existing imports
import 'package:flutter/material.dart';

class BuySubscriptionScreen extends StatelessWidget {
  final int userId;

  BuySubscriptionScreen(this.userId);

  Future<void> _buySubscription(BuildContext context, int months, int sessions) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.204:3001/buy'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'months': months,
        'sessions': sessions,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to buy subscription')),
      );
    }
  }

  Widget _buildSubscriptionCard(BuildContext context, String title, int sessions, int months) {
    int price = sessions * 10;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      margin: EdgeInsets.all(10.0),
      child:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '$sessions занятий на $months ${months > 1 ? 'месяца' : 'месяц'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '\$$price',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _buySubscription(context, months, sessions),
              child: Text('Купить'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Выберите абонемент'),
      // ),
      body: Stack(
        children: [
          Positioned(
            left: -300,
            top: MediaQuery.of(context).size.height / 2 - 350,
            child: Container(
              width: 700,
              height: 700,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF9A9E),
                    Color(0xFFFAD04C).withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 35),
                    _buildSubscriptionCard(context, 'Абонемент на 1 занятие', 1, 1),
                    _buildSubscriptionCard(context, 'Абонемент на 3 занятия', 3, 1),
                    _buildSubscriptionCard(context, 'Абонемент на 6 занятий', 6, 1),
                    _buildSubscriptionCard(context, 'Абонемент на 8 занятий', 8, 2),
                    _buildSubscriptionCard(context, 'Абонемент на 12 занятий', 12, 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
