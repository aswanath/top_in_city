import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheets/gsheets.dart';
import 'package:seo_renderer/renderers/image_renderer/image_renderer_vm.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:top_in_city/core/asset_constants.dart';
import 'package:top_in_city/core/constants.dart';
import 'package:top_in_city/modules/contact/presentation/screen/contact_screen_mobile.dart';
import 'package:top_in_city/modules/core/presentation/bloc/core_bloc.dart';
import 'package:top_in_city/modules/core/widgets/custom_progress_bar.dart';
import 'package:top_in_city/modules/core/widgets/drop_down_widget.dart';
import 'package:top_in_city/modules/core/widgets/footer_widget.dart';
import 'package:top_in_city/modules/home/presentation/screen/home_screen_mobile.dart';
import 'package:top_in_city/modules/menu/presentation/screen/menu_screen_args.dart';
import 'package:top_in_city/modules/menu/presentation/screen/menu_screen_mobile.dart';

const menuListItemHeight = 37.0;

class CoreScreenMobile extends StatefulWidget {
  const CoreScreenMobile({Key? key}) : super(key: key);

  @override
  State<CoreScreenMobile> createState() => _CoreScreenMobileState();
}

class _CoreScreenMobileState extends State<CoreScreenMobile> with SingleTickerProviderStateMixin {
  Widget screen = const HomeScreenMobile();
  List<Worksheet>? menuList;
  bool isExpanded = false;
  late ScrollController scrollController;
  late AnimationController controller;
  late Animation<double> doubleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    doubleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<CoreBloc>(context).add(FetchAllMenus());
    scrollController = ScrollController();
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.width * 0.2),
        child: _AppBar(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: doubleAnimation,
          ),
          onLogoTapped: () => BlocProvider.of<CoreBloc>(context).add(
            HomeScreenTapped(),
          ),
          onIconTapped: () {
            BlocProvider.of<CoreBloc>(context).add(
              BurgerMenuTapped(isExpanded: isExpanded),
            );
          },
        ),
      ),
      body: BlocConsumer<CoreBloc, CoreState>(
        listener: (context, state) {
          if (state is NavigateToHomeScreen) {
            screen = const HomeScreenMobile();
            isExpanded = false;
            controller.reverse();
          } else if (state is NavigateToContactScreen) {
            screen = const ContactScreenMobile();
            isExpanded = false;
            controller.reverse();
          } else if (state is NavigateToMenuScreen) {
            screen = MenuScreenMobile(
              args: MenuScreenArgs(
                selectedMenu: state.screenName,
                menuRows: state.menuRows ?? [],
              ),
            );
            isExpanded = false;
            controller.reverse();
          } else if (state is FetchedAllMenus) {
            menuList = state.menuList;
          } else if (state is BurgerMenuChanged) {
            isExpanded = state.isExpanded;
            if (state.isExpanded) {
              controller.forward();
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            } else {
              controller.reverse();
            }
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
          return InteractiveViewer(
            child: ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: [
                SizeTransition(
                  sizeFactor: doubleAnimation,
                  child: Container(
                    height: footerLinks.length * menuListItemHeight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    color: Colors.grey.withOpacity(0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        footerLinks.length,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index != 0)
                              const Divider(
                                height: 5,
                              ),
                            CustomDropDown(
                              menuText: footerLinks[index],
                              onTap: () {
                                if (footerLinks[index] == 'Home') {
                                  coreBloc.add(HomeScreenTapped());
                                } else if (footerLinks[index] == 'Contact') {
                                  coreBloc.add(ContactScreenTapped());
                                } else {
                                  coreBloc.add(
                                    MenuTapped(menuTitle: footerLinks[index]),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: screen,
                ),
                Footer(
                  padding: 10,
                  crossAxisCount: 4,
                  mainAxisExtent: 100,
                  addressFontSize: 8,
                  menuFontSize: 6,
                  onTap: (val) {
                    if (val == 'Home') {
                      coreBloc.add(HomeScreenTapped());
                    } else if (val == 'Contact') {
                      coreBloc.add(ContactScreenTapped());
                    } else {
                      coreBloc.add(
                        MenuTapped(menuTitle: val),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final VoidCallback onLogoTapped;
  final VoidCallback onIconTapped;
  final Widget icon;

  const _AppBar({
    Key? key,
    required this.onLogoTapped,
    required this.onIconTapped,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Material(
        elevation: 1,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: onIconTapped,
                    padding: EdgeInsets.zero,
                    iconSize: 24,
                    icon: icon,
                  ),
                ),
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: onLogoTapped,
                      child: Column(
                        children: [
                          Expanded(
                            child: ImageRenderer(
                              alt: 'top in city logo',
                              child: Image.asset(
                                topInCityLogo,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          TextRenderer(
                            child: GradientText(
                              'Catering and event management',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14),
                              colors: gradientColors,
                            ),
                          ),
                        ],
                      ),
                    ),
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
