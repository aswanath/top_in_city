import 'package:flutter/material.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:top_in_city/core/constants.dart';
import 'package:top_in_city/core/helpers/email_helper.dart';

class Footer extends StatelessWidget {
  final Function(String) onTap;
  final double padding;
  final double menuFontSize;
  final double addressFontSize;
  final int crossAxisCount;
  final double mainAxisExtent;

  const Footer({
    Key? key,
    required this.onTap,
    this.padding = 30,
    this.addressFontSize = 11,
    this.menuFontSize = 9,
    this.crossAxisCount = 3,
    this.mainAxisExtent = 140,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: padding,
                    vertical: padding == 30 ? 20 : 15,
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisExtent: mainAxisExtent,
                    ),
                    itemCount: footerLinks.length,
                    itemBuilder: (context, index) {
                      return TextRenderer(
                        text: footerLinks[index],
                        child: _Text(
                          text: footerLinks[index].toUpperCase(),
                          fontSize: menuFontSize,
                          onTap: () {
                            onTap(footerLinks[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextRenderer(
                      text: 'Near Moyans School,\nPalakkad, Kerala, India.',
                      child: Text(
                        'Near Moyans School,\nPalakkad, Kerala, India.',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: addressFontSize),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SelectionArea(
                          child: MouseRegion(
                            child: InkWell(
                              onTap: () {
                                try {
                                  launchAnyUrl(
                                    Uri(
                                      scheme: 'tel',
                                      path: '+919995755339',
                                    ),
                                  );
                                } catch (_) {}
                              },
                              child: Text(
                                'Phone: +91 9995755339,',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: addressFontSize),
                              ),
                            ),
                          ),
                        ),
                        SelectionArea(
                          child: MouseRegion(
                            child: InkWell(
                              onTap: () {
                                try {
                                  launchAnyUrl(
                                    Uri(
                                      scheme: 'tel',
                                      path: '+919961147164',
                                    ),
                                  );
                                } catch (_) {}
                              },
                              child: Text(
                                ' +91 9961147164',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: addressFontSize),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextRenderer(
                      text: 'Email: topincitypalakkad@gmail.com',
                      child: SelectionArea(
                        child: MouseRegion(
                          child: InkWell(
                            onTap: () => launchAnyUrl(emailLaunchUri),
                            child: Text(
                              'Email: topincitypalakkad@gmail.com',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: addressFontSize,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ),
                      ),
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
  final double fontSize;

  const _Text({
    Key? key,
    required this.text,
    required this.onTap,
    required this.fontSize,
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
                fontSize: widget.fontSize,
              ),
          maxLines: 1,
        ),
      ),
    );
  }
}
