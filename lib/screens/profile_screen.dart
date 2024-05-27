// import 'package:flutter/material.dart';
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Профиль'),
//       ),
//       body: Center(
//         child: Text('Страница профиля'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/teacher2.png'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement functionality to change profile picture
                    },
                    child: Text('Изменить фотографию'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Статус абонемента:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Активный до 30 июля 2024 г.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Продлить абонемент:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement functionality to renew subscription
              },
              child: Text('Продлить абонемент'),
            ),
            SizedBox(height: 20),
            Text(
              'Настройки:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement functionality to navigate to settings screen
              },
              child: Text('Настройки профиля'),
            ),
          ],
        ),
      ),
    );
  }
}
