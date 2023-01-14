import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_in_city/core/constants.dart';
import 'package:top_in_city/modules/core/presentation/bloc/core_bloc.dart';

class Footer extends StatelessWidget {
  final Function(String) onTap;

  const Footer({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var menuList = BlocProvider.of<CoreBloc>(context).menuList?.map((e) => e.title).toList() ?? [];
    if (menuList.isNotEmpty && footerLinks.length == 2) {
      footerLinks.insertAll(1, menuList);
    }

    return SizedBox(
      height: 100,
      child: Material(
        elevation: 10,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(22),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(22),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 150,
                    ),
                    itemCount: footerLinks.length,
                    itemBuilder: (context, index) {
                      return _Text(
                        text: footerLinks[index].toUpperCase(),
                        onTap: () {
                          onTap(footerLinks[index]);
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Near Moyans School,\nPalakkad, Kerala, India.',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Phone: +91 9995755339, +91 9961147164',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11),
                    ),
                    Text(
                      'Email: atozwehelp@gmail.com',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Text extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _Text({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_Text> createState() => _TextState();
}

class _TextState extends State<_Text> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                decoration: isHovering ? TextDecoration.underline : null,
                color: isHovering ? Colors.black : Colors.black.withOpacity(.6),
              ),
        ),
      ),
    );
  }
}
