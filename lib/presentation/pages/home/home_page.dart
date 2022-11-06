import 'package:flutter/material.dart';
import 'package:top_in_city/core/constants.dart';
import 'package:top_in_city/presentation/core/widgets/responsive_widget.dart';
import 'package:top_in_city/presentation/pages/home/home_page_mobile.dart';
import 'package:top_in_city/presentation/pages/home/home_page_web.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return const Scaffold(
      body: HomePageWeb(),
    );
  }
}
