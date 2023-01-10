import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:top_in_city/core/asset_constants.dart';
import 'package:top_in_city/core/constants.dart';
import 'package:top_in_city/presentation/booking/screen/booking_screen_web.dart';
import 'package:top_in_city/presentation/core/widgets/drop_down_widget.dart';
import 'package:top_in_city/presentation/home/screen/home_screen_web.dart';
import 'package:top_in_city/presentation/menu/screen/menu_screen_web.dart';

class CoreScreenWeb extends StatelessWidget {
  const CoreScreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: _AppBar(),
      ),
      body: _Body(),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        topInCityLogo,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    GradientText(
                      'Catering and event management',
                      style: Theme.of(context).textTheme.titleLarge,
                      colors: gradientColors,
                    ),
                  ],
                ),
                SizedBox(
                  width: 400,
                  child: GradientText(
                    'അമ്മയുടെ കയ്യിൽ നിന്നും നാവിൻ തുമ്പിലേക്ക് രുചിയുടെ മേള.',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                    colors: gradientColors,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late Widget screen;

  @override
  void initState() {
    super.initState();
    // screen = const MenuScreenWeb(selectedMenu: sadhyaPackages);
    screen = ContactScreenWeb();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomDropDown(
                menuText: 'Home',
                onTap: () => setState(() {
                  screen = const HomeScreenWeb();
                }),
              ),
              CustomDropDown(
                menuText: 'Catering Menu',
                onTap: () {},
                childMenu: [
                  ChildMenu(
                    menuString: sadhyaPackages,
                    onTap: () => setState(() {
                      screen = const MenuScreenWeb(
                        selectedMenu: sadhyaPackages,
                      );
                    }),
                  ),
                  ChildMenu(
                    menuString: nonVegFoodMenu,
                    onTap: () => setState(() {
                      screen = const MenuScreenWeb(
                        selectedMenu: nonVegFoodMenu,
                      );
                    }),
                  ),
                  ChildMenu(
                    menuString: sweetsDessertsJuices,
                    onTap: () => setState(() {
                      screen = const MenuScreenWeb(
                        selectedMenu: sweetsDessertsJuices,
                      );
                    }),
                  ),
                ],
              ),
              // CustomDropDown(
              //   menuText: 'Booking',
              //   onTap: () => setState(() {
              //     screen = const BookingScreenWeb();
              //   }),
              // ),
              CustomDropDown(
                menuText: 'Contact',
                onTap: () => setState(() {
                  screen = const ContactScreenWeb();
                }),
              ),
            ],
          ),
        ),
        screen,
      ],
    );
  }
}
