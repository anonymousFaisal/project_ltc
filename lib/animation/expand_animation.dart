import 'package:flutter/material.dart';

class ExpandAnimation extends StatefulWidget {
  final Widget child;
  final bool isExpanded;

  ExpandAnimation({required this.child, required this.isExpanded});

  @override
  _ExpandAnimationState createState() => _ExpandAnimationState();
}

class _ExpandAnimationState extends State<ExpandAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _sizeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _sizeAnimation,
      child: widget.child,
    );
  }
}
