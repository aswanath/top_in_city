import 'package:flutter/material.dart';
import 'package:top_in_city/modules/core/presentation/screen/core_screen_mobile.dart';
import 'package:top_in_city/modules/core/presentation/screen/core_screen_web.dart';
import 'package:top_in_city/modules/core/widgets/responsive_widget.dart';

class CoreScreen extends StatelessWidget {
  const CoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      largeScreen: CoreScreenWeb(),
      smallScreen: CoreScreenMobile(),
    );
  }
}
