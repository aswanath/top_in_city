import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheets/gsheets.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:top_in_city/core/asset_constants.dart';
import 'package:top_in_city/core/constants.dart';
import 'package:top_in_city/modules/contact/presentation/screen/contact_screen_web.dart';
import 'package:top_in_city/modules/core/presentation/bloc/core_bloc.dart';
import 'package:top_in_city/modules/core/widgets/custom_progress_bar.dart';
import 'package:top_in_city/modules/core/widgets/drop_down_widget.dart';
import 'package:top_in_city/modules/core/widgets/footer_widget.dart';
import 'package:top_in_city/modules/home/presentation/screen/home_screen_web.dart';
import 'package:top_in_city/modules/menu/presentation/screen/menu_screen_web.dart';

class CoreScreenWeb extends StatefulWidget {
  const CoreScreenWeb({Key? key}) : super(key: key);

  @override
  State<CoreScreenWeb> createState() => _CoreScreenWebState();
}

class _CoreScreenWebState extends State<CoreScreenWeb> {
  Widget screen = const HomeScreenWeb();
  List<Worksheet>? menuList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<CoreBloc>(context).add(FetchAllMenus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: _AppBar(
          onTap: () => BlocProvider.of<CoreBloc>(context).add(
            HomeScreenTapped(),
          ),
        ),
      ),
      body: BlocConsumer<CoreBloc, CoreState>(
        listener: (context, state) {
          if (state is NavigateToHomeScreen) {
            screen = const HomeScreenWeb();
          } else if (state is NavigateToContactScreen) {
            screen = const ContactScreenWeb();
          } else if (state is NavigateToMenuScreen) {
            screen = MenuScreenWeb(
              selectedMenu: state.screenName,
              menuRows: state.menuRows ?? [],
            );
          } else if (state is FetchedAllMenus) {
            menuList = state.menuList;
          } else if (state is LoadingState) {
            if (state.isLoading) {
              CustomProgressBar(context).showLoadingIndicator();
            } else {
              CustomProgressBar(context).hideLoadingIndicator();
            }
          }
        },
        builder: (context, state) {
          final coreBloc = BlocProvider.of<CoreBloc>(context);
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
                      onTap: () => coreBloc.add(HomeScreenTapped()),
                    ),
                    if (menuList != null)
                      CustomDropDown(
                        menuText: 'Catering Menu',
                        onTap: () {},
                        childMenu: List.generate(
                          menuList!.length,
                          (index) => ChildMenu(
                            menuString: menuList![index].title,
                            onTap: () => coreBloc.add(
                              MenuTapped(menuTitle: menuList![index].title),
                            ),
                          ),
                        ),
                      ),
                    CustomDropDown(
                      menuText: 'Contact',
                      onTap: () => coreBloc.add(ContactScreenTapped()),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: screen,
              ),
              Footer(
                onTap: (val) {
                  if (val == 'HOME') {
                    coreBloc.add(HomeScreenTapped());
                  } else if (val == 'CONTACT') {
                    coreBloc.add(ContactScreenTapped());
                  } else {
                    coreBloc.add(
                      MenuTapped(menuTitle: val),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final VoidCallback onTap;

  const _AppBar({
    Key? key,
    required this.onTap,
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
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Column(
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
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: GradientText(
                    '"അമ്മയുടെ കയ്യിൽ നിന്നും നാവിൻ തുമ്പിലേക്ക് രുചിയുടെ മേള."',
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
