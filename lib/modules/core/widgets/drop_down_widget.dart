import 'package:flutter/material.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

class ChildMenu {
  final String menuString;
  final VoidCallback? onTap;

  ChildMenu({
    required this.menuString,
    this.onTap,
  });
}

class CustomDropDown extends StatefulWidget {
  final String menuText;
  final VoidCallback? onTap;
  final List<ChildMenu>? childMenu;

  const CustomDropDown({
    Key? key,
    required this.menuText,
    this.onTap,
    this.childMenu,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onExit: (point) {
          if (point.delta.dy <= 0 || (isHovering && point.localPosition.dx < 10)) {
            _closeOverlay();
            isHovering = false;
          }
        },
        onEnter: (_) {
          OverlayState overlayState = Overlay.of(context)!;
          _closeOverlay();
          if (widget.childMenu != null) {
            _overlayEntry = _createOverLayEntry();
            overlayState.insert(_overlayEntry!);
            isHovering = true;
          }
        },
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: _Text(
              text: widget.menuText,
            ),
          ),
        ),
      ),
    );
  }

  void _closeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry? _createOverLayEntry() {
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    Size parentSize = renderBox.size;
    Size screenSize = MediaQuery.of(context).size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    late double offsetHorizontal;
    double width = 240;

    if (screenSize.width < (offset.dx + width + 10)) {
      offsetHorizontal = parentSize.width - width;
    } else {
      offsetHorizontal = 0;
    }

    return OverlayEntry(
      builder: (context) => Positioned(
        width: width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(
            offsetHorizontal,
            parentSize.height + 6,
          ),
          child: MouseRegion(
            onExit: (_) {
              _closeOverlay();
              isHovering = false;
            },
            child: Material(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6)),
              elevation: 10,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.childMenu!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (widget.childMenu![index].onTap != null) {
                        widget.childMenu![index].onTap!.call();
                      }
                      _closeOverlay();
                      isHovering = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 11),
                      decoration: BoxDecoration(
                        border: index != (widget.childMenu!.length - 1) ? const Border(bottom: BorderSide(color: Colors.black26)) : null,
                      ),
                      child: TextRenderer(
                        text: widget.childMenu![index].menuString,
                        child: Text(
                          widget.childMenu![index].menuString,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;

  const _Text({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextRenderer(
        text: text,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
