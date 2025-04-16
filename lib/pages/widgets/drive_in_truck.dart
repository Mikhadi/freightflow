import 'package:flutter/material.dart';

class DriveInTruck extends StatefulWidget {
  @override
  _DriveInTruckState createState() => _DriveInTruckState();
}

class _DriveInTruckState extends State<DriveInTruck>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Image will come in from the right side (Offset(x, y): x = 1.0 = right)
    _animation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(); // Start animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image.asset(
        'assets/truck.png', // Replace with your image path
        width: double.infinity,
      ),
    );
  }
}
