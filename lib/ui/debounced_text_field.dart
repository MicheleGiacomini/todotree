import 'package:flutter/material.dart';
import 'package:todotree/utils/debouncer.dart';

class DebouncedTextField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final Duration debounceDuration;
  final InputDecoration? decoration;
  final TextStyle? style;
  final int? minLines;
  final int? maxLines;
  final bool? enabled;
  final bool readOnly;
  final FocusNode? focusNode;

  const DebouncedTextField({
    super.key,
    this.controller,
    required this.onChanged,
    this.onSubmitted,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.decoration,
    this.style,
    this.minLines,
    this.maxLines,
    this.enabled,
    this.readOnly = false,
    this.focusNode,
  });

  @override
  State<DebouncedTextField> createState() => _DebouncedTextFieldState();
}

class _DebouncedTextFieldState extends State<DebouncedTextField> {
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(debounce: widget.debounceDuration);
  }

  @override
  void dispose() {
    _debouncer.complete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: widget.decoration,
      style: widget.style,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      onChanged: (value) {
        _debouncer.run(() => widget.onChanged(value));
      },
      onSubmitted: (value) {
        _debouncer.complete();
        widget.onSubmitted?.call(value);
      },
      onTapOutside: (_) => _debouncer.complete(),
    );
  }
}
