import 'package:flutter/services.dart';
import 'package:todotree/ui/actions.dart';
import 'package:todotree/ui/input_system.dart';

final vimKeyMap = KeyMap([
  KeyBinding(const KeySequence([LogicalKeyboardKey.keyJ]), const MoveFocusDownIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.keyK]), const MoveFocusUpIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.keyH]), const CollapseIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.keyL]), const ExpandIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.keyG, LogicalKeyboardKey.keyG]), const MoveFocusTopIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.keyG]), const MoveFocusBottomIntent()), // G
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.keyG]), const MoveFocusBottomIntent()), // G
  KeyBinding(const KeySequence([LogicalKeyboardKey.keyI]), const EditNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.keyO]), const CreateNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.keyO]), const CreateNodeAboveIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.keyO]), const CreateNodeAboveIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.keyD, LogicalKeyboardKey.keyD]), const DeleteNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.period]), const IndentNodeIntent()), // >
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.period]), const IndentNodeIntent()), // >
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.comma]), const OutdentNodeIntent()), // <
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftRight, LogicalKeyboardKey.comma]), const OutdentNodeIntent()), // <
  KeyBinding(const KeySequence([LogicalKeyboardKey.tab]), const IndentNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.tab]), const OutdentNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.enter]), const EditNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.space]), const ToggleDoneIntent()),
]);

final standardKeyMap = KeyMap([
  KeyBinding(const KeySequence([LogicalKeyboardKey.arrowDown]), const MoveFocusDownIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.arrowUp]), const MoveFocusUpIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.arrowLeft]), const CollapseIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.arrowRight]), const ExpandIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.home]), const MoveFocusTopIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.end]), const MoveFocusBottomIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.enter]), const EditNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.delete]), const DeleteNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.tab]), const IndentNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.tab]), const OutdentNodeIntent()),
  KeyBinding(const KeySequence([LogicalKeyboardKey.space]), const ToggleDoneIntent()),
]);
