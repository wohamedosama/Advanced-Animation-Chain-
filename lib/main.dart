import 'package:flutter/material.dart';

void main() {
  runApp(const SequentialLoadingDots());
}

class SequentialLoadingDots extends StatelessWidget {
  const SequentialLoadingDots({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          centerTitle: true,
          leading: Icon(Icons.arrow_back_ios),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Sequential Loading Dots',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        body: Center(child: LoadingDotsAnimation()),
      ),
    );
  }
}

class LoadingDotsAnimation extends StatefulWidget {
  final Color dotColor;
  final double dotSize;
  final Duration animationDuration;

  const LoadingDotsAnimation({
    super.key,
    this.dotColor = const Color(0xFF2196F3), // Blue color like in image
    this.dotSize = 12.0,
    this.animationDuration = const Duration(milliseconds: 1200),
  });

  @override
  State<LoadingDotsAnimation> createState() => _LoadingDotsAnimationState();
}

class _LoadingDotsAnimationState extends State<LoadingDotsAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  // Scale animations for each dot
  late Animation<double> _scaleAnimation1;
  late Animation<double> _scaleAnimation2;
  late Animation<double> _scaleAnimation3;

  // Opacity animations for each dot
  late Animation<double> _opacityAnimation1;
  late Animation<double> _opacityAnimation2;
  late Animation<double> _opacityAnimation3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Create staggered animations for each dot
    // Dot 1: starts at 0.0, peaks at 0.33
    _scaleAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.33, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation1 = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.33, curve: Curves.easeInOut),
      ),
    );

    // Dot 2: starts at 0.33, peaks at 0.66
    _scaleAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.33, 0.66, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation2 = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.33, 0.66, curve: Curves.easeInOut),
      ),
    );

    // Dot 3: starts at 0.66, peaks at 1.0
    _scaleAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.66, 1.0, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimation3 = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.66, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Start the animation and repeat
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dot 1
            _buildAnimatedDot(
              scale: _scaleAnimation1.value,
              opacity: _opacityAnimation1.value,
            ),

            SizedBox(width: 8),

            // Dot 2
            _buildAnimatedDot(
              scale: _scaleAnimation2.value,
              opacity: _opacityAnimation2.value,
            ),

            SizedBox(width: 8),

            // Dot 3
            _buildAnimatedDot(
              scale: _scaleAnimation3.value,
              opacity: _opacityAnimation3.value,
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedDot({required double scale, required double opacity}) {
    return Transform.scale(
      scale: 0.5 + (scale * 0.5), // Scale from 0.5 to 1.0
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: widget.dotSize,
          height: widget.dotSize,
          decoration: BoxDecoration(
            color: widget.dotColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.dotColor.withOpacity(0.3),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Alternative version with bounce effect
class BouncyLoadingDots extends StatefulWidget {
  const BouncyLoadingDots({super.key});

  @override
  State<BouncyLoadingDots> createState() => _BouncyLoadingDotsState();
}

class _BouncyLoadingDotsState extends State<BouncyLoadingDots>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    // Create bouncing animations with different delays
    _animation1 =
        Tween<double>(
          begin: 0.0,
          end: -20.0, // Bounce up by 20 pixels
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 0.4, curve: Curves.bounceOut),
          ),
        );

    _animation2 = Tween<double>(begin: 0.0, end: -20.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.6, curve: Curves.bounceOut),
      ),
    );

    _animation3 = Tween<double>(begin: 0.0, end: -20.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.8, curve: Curves.bounceOut),
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Transform.translate(
              offset: Offset(0, _animation1.value),
              child: _buildDot(Colors.blue),
            ),
            SizedBox(width: 8),
            Transform.translate(
              offset: Offset(0, _animation2.value),
              child: _buildDot(Colors.blue),
            ),
            SizedBox(width: 8),
            Transform.translate(
              offset: Offset(0, _animation3.value),
              child: _buildDot(Colors.blue),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
