import 'package:flutter/material.dart';

class ProgressAnimation extends StatefulWidget {
  final double progress;

  ProgressAnimation({required this.progress});

  @override
  _ProgressAnimationState createState() => _ProgressAnimationState();
}

class _ProgressAnimationState extends State<ProgressAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) => Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              value: _progressAnimation.value,
              backgroundColor:
                  theme.colorScheme.secondary.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation(
                  theme.colorScheme.secondary),
            ),
          ),
          Text(
            "${(_progressAnimation.value * 100).toInt()}%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: theme.secondaryHeaderColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
