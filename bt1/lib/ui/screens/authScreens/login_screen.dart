import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void handleLogin() {
    if (_usernameController.text == 'manager' && _passwordController.text == 'password123') {
      Navigator.pushReplacementNamed(context, '/managerDashboard');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid credentials, please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          FadeTransition(
            opacity: _animation!,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Thêm logo tại đây
                      Image.asset(
                        'lib/assets/user.jpg',
                        height: 80, // Điều chỉnh kích thước logo
                        width: 80,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Manager Login',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto', // Phông chữ mới
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedInputField(
                        controller: _usernameController,
                        labelText: 'Username',
                      ),
                      const SizedBox(height: 10),
                      AnimatedInputField(
                        controller: _passwordController,
                        labelText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: handleLogin,
                        child: const Text('Login', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const AnimatedInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: EdgeInsets.only(left: value * 10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.blueAccent),
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              obscureText: obscureText,
            ),
          ),
        );
      },
    );
  }
}
