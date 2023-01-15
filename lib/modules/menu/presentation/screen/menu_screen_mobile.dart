import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:top_in_city/modules/core/presentation/bloc/core_bloc.dart';

class MenuScreenMobile extends StatefulWidget {
  final String selectedMenu;
  final List<List<String>> menuRows;

  const MenuScreenMobile({
    Key? key,
    required this.selectedMenu,
    required this.menuRows,
  }) : super(key: key);

  @override
  State<MenuScreenMobile> createState() => _MenuScreenMobileState();
}

class _MenuScreenMobileState extends State<MenuScreenMobile> {
  final AutoSizeGroup malayalamAutoSizeGroup = AutoSizeGroup();
  final AutoSizeGroup englishAutoSizeGroup = AutoSizeGroup();
  bool isMalayalam = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<CoreBloc, CoreState>(
      listener: (context, state) {
        if (state is ChangedLanguage) {
          isMalayalam = state.isMalayalam;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.075),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: TextRenderer(
                    text: widget.selectedMenu,
                    child: Text(
                      widget.selectedMenu.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
              const SizedBox(
                height: 30,
              ),
              StaggeredGridView.builder(
                shrinkWrap: true,
                itemCount: widget.menuRows.length,
                // padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var itemDetailsList = widget.menuRows[index];
                  var englishItemList = itemDetailsList[1].split(',').toList();
                  var malayalamItemList = itemDetailsList[2].split(',').toList();
                  return SelectionArea(
                    child: Container(
                      padding: EdgeInsets.all(size.width * 0.03),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(3, 2),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(.5),
                          ),
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
                              : TextRenderer(
                                  text: isMalayalam ? itemDetailsList.first.split(',')[1].trim() : itemDetailsList.first.split(',')[0].trim(),
                                  child: AutoSizeText(
                                    isMalayalam ? itemDetailsList.first.split(',')[1].trim() : itemDetailsList.first.split(',')[0].trim(),
                                    style: Theme.of(context).textTheme.headlineMedium,
                                    maxLines: 1,
                                  ),
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.019,
                          ),
                          ...List.generate(
                            isMalayalam ? malayalamItemList.length : englishItemList.length,
                            (textIndex) => TextRenderer(
                              text: isMalayalam ? malayalamItemList[textIndex].trim() : englishItemList[textIndex].trim(),
                              child: AutoSizeText(
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
                                          fontSize: 14,
                                        ),
                                maxLines: 1,
                                group: malayalamAutoSizeGroup,
                                minFontSize: 8,
                                wrapWords: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                  staggeredTileBuilder: (int index) {
                    return const StaggeredTile.fit(1);
                  },
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 25,
                  staggeredTileCount: widget.menuRows.length,
                ),
              ),
              if (widget.selectedMenu == 'Sadhya Packages ( Veg )')
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: TextRenderer(
                      text: isMalayalam ? "രണ്ടാം പായസം: പരിപ്പ് / ഗോതമ്പ് / സേമിയ" : "SECOND PAYASAM: PARIPPU / WHEAT / SEMIYA",
                      child: Text(
                        isMalayalam ? "രണ്ടാം പായസം: പരിപ്പ് / ഗോതമ്പ് / സേമിയ" : "SECOND PAYASAM: PARIPPU / WHEAT / SEMIYA",
                        style: isMalayalam
                            ? Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 14,
                                  height: 1.5,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                )
                            : Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  height: 1.8,
                                  fontSize: 12,
                                ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
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
            TextRenderer(
              text: 'top in city per leaf price',
              child: AutoSizeText(
                'PER LEAF',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                      height: 1,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
