import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension IconExtension on Icon {
  Icon copyWith(Color? color) {
    return Icon(
      icon,
      key: key,
      size: size,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
      color: color ?? this.color,
    );
  }
}

class AutoHideMessageDialog extends StatefulWidget {
  final String message;
  final Color? backgroundColor;
  final Color? textColor;
  final Icon? icon;
  final Duration? duration;
  final Function()? onClose;

  const AutoHideMessageDialog({
    Key? key,
    required this.message,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.duration,
    this.onClose,
  }) : super(key: key);

  @override
  _AutoHideMessageDialogState createState() => _AutoHideMessageDialogState();
}

class _AutoHideMessageDialogState extends State<AutoHideMessageDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _textColorAnimation;
  late Animation<Color?> _iconColorAnimation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _backgroundColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: widget.backgroundColor ?? Colors.black.withOpacity(0.5),
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _textColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: widget.textColor ?? Colors.white,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    if (widget.icon != null) {
      _iconColorAnimation = ColorTween(
        begin: Colors.transparent,
        end: widget.icon!.color ?? Colors.white,
      ).animate(_controller)
        ..addListener(() {
          setState(() {});
        });
    }

    _controller.forward();

    _timer = Timer(widget.duration ?? const Duration(seconds: 3), () async {
      if (mounted) {
        await _controller.reverse();
      }
      widget.onClose?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: _backgroundColorAnimation.value,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width * 0.75,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.icon != null ? widget.icon!.copyWith(_iconColorAnimation.value) : Container(),
              widget.icon != null ? const SizedBox(width: 10) : Container(),
              Expanded(
                child: Text(
                  widget.message,
                  softWrap: true,
                  style: TextStyle(
                    color: _textColorAnimation.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
