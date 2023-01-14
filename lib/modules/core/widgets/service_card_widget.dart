import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatefulWidget {
  final String imageUrl;
  final String heading;
  final String description;

  const ServiceCard({
    Key? key,
    required this.description,
    required this.imageUrl,
    required this.heading,
  }) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> with SingleTickerProviderStateMixin {
  double scale = 1;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      lowerBound: 0.7,
    )..value = 0.7;
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        // setState(() {
        //   scale = 1.1;
        // });
        _controller.forward();
      },
      onExit: (_) {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _animation,
        child: Material(
          elevation: 15,
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: .67,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 12 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AutoSizeText(
                    widget.heading,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                    maxLines: 2,
                    minFontSize: 10,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        widget.description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.1),
                        maxLines: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
