import 'package:flutter/material.dart';

class MoveFocusUpIntent extends Intent {
  const MoveFocusUpIntent();
}

class MoveFocusDownIntent extends Intent {
  const MoveFocusDownIntent();
}

class MoveFocusTopIntent extends Intent {
  const MoveFocusTopIntent();
}

class MoveFocusBottomIntent extends Intent {
  const MoveFocusBottomIntent();
}

class ToggleExpandIntent extends Intent {
  const ToggleExpandIntent();
}

class CollapseIntent extends Intent {
  const CollapseIntent();
}

class ExpandIntent extends Intent {
  const ExpandIntent();
}

class EditNodeIntent extends Intent {
  const EditNodeIntent();
}

class ToggleDoneIntent extends Intent {
  const ToggleDoneIntent();
}

class IndentNodeIntent extends Intent {
  const IndentNodeIntent();
}

class OutdentNodeIntent extends Intent {
  const OutdentNodeIntent();
}

class DeleteNodeIntent extends Intent {
  const DeleteNodeIntent();
}

class CreateNodeIntent extends Intent {
  const CreateNodeIntent();
}

class CreateNodeAboveIntent extends Intent {
  const CreateNodeAboveIntent();
}
