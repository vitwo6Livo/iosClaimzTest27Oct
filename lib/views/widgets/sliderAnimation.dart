import 'package:flutter/cupertino.dart';

class sliderAnimation extends StatefulWidget {
  Container container;
  sliderAnimation({super.key, required this.container});

  @override
  State<sliderAnimation> createState() => _sliderAnimationState(container);
}

class _sliderAnimationState extends State<sliderAnimation>
    with SingleTickerProviderStateMixin {
  Container containers;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  _sliderAnimationState(Container this.containers);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 2), () {
    //   _controller.stop();
    // });
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: containers,
      ),
    );
  }
}
