import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:top_in_city/modules/core/presentation/bloc/core_bloc.dart';

class MenuScreenWeb extends StatefulWidget {
  final String selectedMenu;
  final List<List<String>> menuRows;

  const MenuScreenWeb({
    Key? key,
    required this.selectedMenu,
    required this.menuRows,
  }) : super(key: key);

  @override
  State<MenuScreenWeb> createState() => _MenuScreenWebState();
}

class _MenuScreenWebState extends State<MenuScreenWeb> {
  final AutoSizeGroup autoSizeGroup = AutoSizeGroup();
  bool isMalayalam = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoreBloc, CoreState>(
      listener: (context, state) {
        if (state is ChangedLanguage) {
          isMalayalam = state.isMalayalam;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.selectedMenu.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    children: [
                      Text(
                        'ENG',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: FittedBox(
                          child: CupertinoSwitch(
                            activeColor: Colors.black,
                            value: isMalayalam,
                            onChanged: (val) => BlocProvider.of<CoreBloc>(context).add(
                              SwitchLanguage(isMalayalam: val),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'MAL',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            StaggeredGridView.builder(
              shrinkWrap: true,
              itemCount: widget.menuRows.length,
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.11),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var itemDetailsList = widget.menuRows[index];
                var englishItemList = itemDetailsList[1].split(',').toList();
                var malayalamItemList = itemDetailsList[2].split(',').toList();
                return Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.019),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(offset: const Offset(3, 2), blurRadius: 5, color: Colors.black.withOpacity(.5)),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      tileMode: TileMode.decal,
                      colors: [
                        Color(0xffF9CC5E),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      int.tryParse(itemDetailsList.first) != null
                          ? _PriceWidget(
                              price: itemDetailsList.first,
                            )
                          : AutoSizeText(
                              isMalayalam ? itemDetailsList.first.split(',')[1].trim() : itemDetailsList.first.split(',')[0].trim(),
                              style: Theme.of(context).textTheme.headlineMedium,
                              maxLines: 1,
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.019,
                      ),
                      ...List.generate(
                        isMalayalam ? malayalamItemList.length : englishItemList.length,
                        (textIndex) => AutoSizeText(
                          isMalayalam ? malayalamItemList[textIndex].trim() : englishItemList[textIndex].trim(),
                          style: isMalayalam
                              ? Theme.of(context).textTheme.headlineLarge!.copyWith(
                                    fontSize: 18,
                                    height: 1.5,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  )
                              : Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    height: 1.8,
                                    fontSize: 18,
                                  ),
                          maxLines: 1,
                          group: autoSizeGroup,
                          minFontSize: 8,
                          maxFontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
              gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                staggeredTileBuilder: (int index) {
                  return const StaggeredTile.fit(1);
                },
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 50,
                staggeredTileCount: widget.menuRows.length,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        );
      },
    );
  }
}

class _PriceWidget extends StatelessWidget {
  final String price;

  const _PriceWidget({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          '₹ ',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              price,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            AutoSizeText(
              'PER LEAF',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                    height: 1,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
