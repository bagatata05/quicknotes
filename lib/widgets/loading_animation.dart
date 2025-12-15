import 'package:flutter/material.dart';
import '../theme/theme.dart';

class LoadingAnimation extends StatefulWidget {
  final String? message;

  const LoadingAnimation({
    super.key,
    this.message,
  });

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated dots
          SizedBox(
            height: 60,
            width: 60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rotating outer circle
                RotationTransition(
                  turns: _controller1,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                        width: 3,
                      ),
                    ),
                  ),
                ),

                // Pulsing dot
                ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.2)
                      .animate(_controller2),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),

                // Orbiting dot
                RotationTransition(
                  turns: _controller3,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Loading message
          if (widget.message != null)
            Text(
              widget.message!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
