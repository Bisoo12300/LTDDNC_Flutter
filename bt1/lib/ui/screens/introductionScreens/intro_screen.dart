import 'package:flutter/material.dart';
import 'dart:async';

class MemberIntroduction extends StatefulWidget {
  const MemberIntroduction({super.key});

  @override
  _MemberIntroductionState createState() => _MemberIntroductionState();
}

class _MemberIntroductionState extends State<MemberIntroduction> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeOut),
    );

    _controller!.forward();

    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation!,
          child: SlideTransition(
            position: _slideAnimation!,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Meet Our Team',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto', // Thay đổi font chữ
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 20),
                AnimatedText(
                  text: 'Doan Thai Son',
                  fontSize: 20,
                ),
                AnimatedText(
                  text: 'Nguyen Hong Thong Diep',
                  fontSize: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedText extends StatelessWidget {
  final String text;
  final double fontSize;

  const AnimatedText({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 2),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: EdgeInsets.only(top: value * 10),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'Roboto',
                color: Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }
}
