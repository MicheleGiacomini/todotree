import 'dart:ui';

import 'package:flutter/material.dart';

class ClickableIcon extends StatefulWidget {
  final void Function()? onTap;
  final IconData icon;
  final Color? color;

  const ClickableIcon({super.key, required this.icon, this.onTap, this.color});

  @override
  State<ClickableIcon> createState() => _ClickableIconState();
}

class _ClickableIconState extends State<ClickableIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final iconColor = widget.color ?? Theme.of(context).iconTheme.color;

    return MouseRegion(
      onEnter: (event) => setState(() {
        _hovered = true;
      }),
      onExit: (event) => setState(() {
        _hovered = false;
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Icon(widget.icon, color: iconColor),
            if (_hovered)
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Icon(widget.icon, color: iconColor),
              ),
          ],
        ),
      ),
    );
  }
}
