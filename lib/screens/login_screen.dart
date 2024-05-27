import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_screen.dart';
import 'registration_screen.dart';
import 'buy_subscription_screen.dart'; // Импортируем новый экран

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

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
      begin: Color(0xFFFF9A9E),
      end: Color(0xFFFAD04C),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final url = Uri.parse('http://192.168.0.204:3001/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (responseBody['status'] == 'success') {
        _checkSubscription(responseBody['user']['id']);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ошибка входа'),
              content: Text(responseBody['message']),
              actions: <Widget>[
                TextButton(
                  child: Text('ОК'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ошибка входа'),
            content: Text('Произошла ошибка при входе'),
            actions: <Widget>[
              TextButton(
                child: Text('ОК'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _checkSubscription(int id) async {
    final url = Uri.parse('http://192.168.0.204:3001/api/check_subscription?email=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody[0] == 1) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BuySubscriptionScreen(id)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка проверки подписки: ${response.body}')));
    }
  }

  ThemeData _buildTheme(BuildContext context) {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: Color(0xFFB25000),
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
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
              right: -300,
              top: MediaQuery.of(context).size.height / 2 - _sizeAnimation.value / 2,
              child: Container(
                width: _sizeAnimation.value,
                height: _sizeAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      _colorAnimation.value ?? Color(0xFFFF9A9E),
                      _colorAnimation.value != null ? _colorAnimation.value!.withOpacity(0.6) : Color(0xFFFAD04C).withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Привет!',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      controller: _emailController,
                      cursorColor: Color(0xFFB25000),
                      decoration: InputDecoration(
                        labelText: 'Login',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      cursorColor: Color(0xFFB25000),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _login,
                        child: Text('Войти'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                              }
                              return null;
                            },
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                      },
                      child: Text(
                        'Я тут первый раз (💧´∇ ` )',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
