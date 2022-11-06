import 'package:flutter/material.dart';
import 'package:top_in_city/core/asset_constants.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 125,
          child: Material(
            elevation: 10,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(22),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(22),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                          child: Image.asset(
                            topInCityLogo,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Text(
                          'Catering and event management',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
