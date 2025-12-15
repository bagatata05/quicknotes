import 'package:flutter/material.dart';

class AnimatedFab extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String tooltip;

  const AnimatedFab({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.tooltip,
  });

  @override
  State<AnimatedFab> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FloatingActionButton(
        onPressed: () {
          _animationController.forward().then((_) {
            _animationController.reverse();
          });
          widget.onPressed();
        },
        tooltip: widget.tooltip,
        child: Icon(widget.icon),
      ),
    );
  }
}

