import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'schedule_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  final List<Widget> _screens = [
    HomeScreenContent(), // Custom widget for Home content
    ScheduleScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(begin: 700.0, end: 750.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimation = ColorTween(
      begin: const Color(0xFFFF9A9E),
      end: const Color(0xFFFAD04C),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ThemeData _buildTheme(BuildContext context) {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFFB25000),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildTheme(context),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              right: -170,
              top: MediaQuery.of(context).size.height / 2 - _sizeAnimation.value / 2,
              child: Container(
                width: _sizeAnimation.value,
                height: _sizeAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      _colorAnimation.value ?? const Color(0xFFFF9A9E),
                      _colorAnimation.value != null ? _colorAnimation.value!.withOpacity(0.6) : const Color(0xFFFAD04C).withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: _screens[_selectedIndex],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/home.svg',
                color: _selectedIndex == 0 ? Colors.orange : Colors.grey,
                height: 24,
                width: 24,
              ),
              label: 'Дом',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/schedule.svg',
                color: _selectedIndex == 1 ? Colors.orange : Colors.grey,
                height: 24,
                width: 24,
              ),
              label: 'Расписание',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/profile.svg',
                color: _selectedIndex == 2 ? Colors.orange : Colors.grey,
                height: 24,
                width: 24,
              ),
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
          PracticeCard(),
          const SizedBox(height: 30),
          StatsCard(),
        ],
      ),
    );
  }
}

class PracticeCard extends StatelessWidget {
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
            const SizedBox(height: 10),
            const Text(
              'Ближайшая практика на курсе\n“Здоровая спина”',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
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
                          '29 мая 19:00',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Наталья Иванова',
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/practitioner.png'),
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

class StatsCard extends StatelessWidget {
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
            const SizedBox(height: 14),
            const Text(
              'Ваша статистика',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ProgressBar(month: 'фев', progress: 0.85),
                ProgressBar(month: 'март', progress: 0.25),
                ProgressBar(month: 'апр', progress: 0.85),
                ProgressBar(month: 'май', progress: 0.5),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final String month;
  final double progress;

  const ProgressBar({
    required this.month,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final Color progressColor = progress >= 0.5 ? const Color(0xFFFFC107) : const Color(0xFFFF6F61);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 50,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 2),
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 46,
                height: 100 * progress,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  color: progressColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          month,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
