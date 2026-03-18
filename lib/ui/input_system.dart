import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Represents a sequence of keys that triggers an intent.
/// e.g. ['g', 'g'] or [LogicalKeyboardKey.arrowDown]
class KeySequence {
  final List<LogicalKeyboardKey> keys;

  const KeySequence(this.keys);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeySequence &&
          keys.length == other.keys.length &&
          keys.asMap().entries.every((e) => e.value == other.keys[e.key]);

  @override
  int get hashCode => Object.hashAll(keys);

  @override
  String toString() => keys.map((k) => k.keyLabel).join(' ');
}

/// Maps a sequence of keys to an intent.
class KeyBinding {
  final KeySequence sequence;
  final Intent intent;

  const KeyBinding(this.sequence, this.intent);
}

class KeyMap {
  final List<KeyBinding> bindings;

  const KeyMap(this.bindings);

  Intent? match(List<LogicalKeyboardKey> buffer) {
    for (final binding in bindings) {
      if (binding.sequence.keys.length == buffer.length) {
        bool match = true;
        for (int i = 0; i < buffer.length; i++) {
          if (binding.sequence.keys[i] != buffer[i]) {
            match = false;
            break;
          }
        }
        if (match) return binding.intent;
      }
    }
    return null;
  }

  bool isPrefix(List<LogicalKeyboardKey> buffer) {
    for (final binding in bindings) {
      if (binding.sequence.keys.length > buffer.length) {
        bool match = true;
        for (int i = 0; i < buffer.length; i++) {
          if (binding.sequence.keys[i] != buffer[i]) {
            match = false;
            break;
          }
        }
        if (match) return true;
      }
    }
    return false;
  }
}

class InputManager extends StatefulWidget {
  final Widget child;
  final KeyMap keyMap;
  final FocusNode focusNode;
  final bool enabled;

  const InputManager({
    super.key,
    required this.child,
    required this.keyMap,
    required this.focusNode,
    this.enabled = true,
  });

  @override
  State<InputManager> createState() => _InputManagerState();
}

class _InputManagerState extends State<InputManager> {
  final List<LogicalKeyboardKey> _buffer = [];
  Timer? _bufferTimer;

  void _resetBuffer() {
    _buffer.clear();
    _bufferTimer?.cancel();
    _bufferTimer = null;
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!widget.enabled) return KeyEventResult.ignored;
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;

    // Ignore modifier keys alone
    if (key == LogicalKeyboardKey.shiftLeft ||
        key == LogicalKeyboardKey.shiftRight ||
        key == LogicalKeyboardKey.controlLeft ||
        key == LogicalKeyboardKey.controlRight ||
        key == LogicalKeyboardKey.altLeft ||
        key == LogicalKeyboardKey.altRight ||
        key == LogicalKeyboardKey.metaLeft ||
        key == LogicalKeyboardKey.metaRight) {
      return KeyEventResult.ignored;
    }

    _buffer.add(key);
    _bufferTimer?.cancel();
    _bufferTimer = Timer(const Duration(milliseconds: 1000), _resetBuffer);

    // Check for exact match
    final intent = widget.keyMap.match(_buffer);
    if (intent != null) {
      Actions.invoke(context, intent);
      _resetBuffer();
      return KeyEventResult.handled;
    }

    // Check if it's a prefix of any binding
    if (widget.keyMap.isPrefix(_buffer)) {
      return KeyEventResult.handled; // Wait for more keys
    }

    // No match and not a prefix, maybe the last key itself is a single key binding?
    // But we already checked the full buffer.
    // Retry with just the last key if buffer had more elements
    if (_buffer.length > 1) {
       final lastKey = _buffer.last;
       _resetBuffer();
       _buffer.add(lastKey);
       final retryIntent = widget.keyMap.match(_buffer);
       if (retryIntent != null) {
         Actions.invoke(context, retryIntent);
         _resetBuffer();
         return KeyEventResult.handled;
       }
    } else {
        _resetBuffer();
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      onKeyEvent: _handleKeyEvent,
      child: widget.child,
    );
  }
}
