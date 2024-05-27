// import 'package:flutter/material.dart';
//
// class ScheduleScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Расписание'),
//       ),
//       body: Center(
//         child: Text('Страница расписания'),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -170,
            top: MediaQuery.of(context).size.height / 2 - 800 / 2,
            child: Container(
              width: 750,
              height: 750,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFF9A9E),
                    const Color(0xFFFAD04C),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Ещё 3 практики',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                PracticeCard(
                  date: '29 мая 19:00',
                  practitioner: 'Наталья Иванова',
                  photo: 'assets/practitioner.png',
                ),
                const SizedBox(height: 10),
                PracticeCard(
                  date: '3 июня 19:00',
                  practitioner: 'Михаил Андреев',
                  photo: 'assets/teacher2.png',
                ),
                const SizedBox(height: 10),
                PracticeCard(
                  date: '5 июня 19:00',
                  practitioner: 'Наталья Иванова',
                  photo: 'assets/practitioner.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PracticeCard extends StatelessWidget {
  final String date;
  final String practitioner;
  final String photo;

  const PracticeCard({
    required this.date,
    required this.practitioner,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          practitioner,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
