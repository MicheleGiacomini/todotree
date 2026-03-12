import 'package:flutter/material.dart';
import 'package:todotree/domain/element.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:todotree/ui/palette.dart';

class TagEditor extends StatefulWidget {
  final IList<Tag> currentTags;
  final Set<Tag> allTags;
  final Map<String, int> tagColors;
  final void Function(Tag) onAddTag;
  final void Function(Tag) onRemoveTag;
  final void Function(String, int) onSetTagColor;

  const TagEditor({
    super.key,
    required this.currentTags,
    required this.allTags,
    required this.tagColors,
    required this.onAddTag,
    required this.onRemoveTag,
    required this.onSetTagColor,
  });

  @override
  State<TagEditor> createState() => _TagEditorState();
}

class _TagEditorState extends State<TagEditor> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _onTagSubmitted(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty) {
      final tag = Tag(name: trimmed);
      if (!widget.currentTags.contains(tag)) {
        widget.onAddTag(tag);
      }
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  void _showColorPicker(Tag tag) {
    showDialog(
      context: context,
      builder: (context) {
        return _ExcalidrawColorPicker(
          tagName: tag.name,
          initialColor: TagPalette.getColor(widget.tagColors[tag.name]),
          onColorChanged: (color) {
            widget.onSetTagColor(tag.name, color.toARGB32());
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RawAutocomplete<String>(
          textEditingController: _controller,
          focusNode: _focusNode,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const <String>[];
            }

            final choices =
                widget.allTags
                    .map((t) => t.name)
                    .where(
                      (name) => !widget.currentTags.any(
                        (ct) => ct.name == name,
                      ),
                    )
                    .toList();

            if (choices.isEmpty) {
              return const Iterable<String>.empty();
            }

            final results = extractAll<String>(
              query: textEditingValue.text,
              choices: choices,
              cutoff: 50,
            );

            return results.map((r) => r.choice);
          },
          onSelected: (String selection) {
            _onTagSubmitted(selection);
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            final theme = Theme.of(context);
            final cp = theme.catppuccin;
            return TextField(
              controller: controller,
              focusNode: focusNode,
              style: TextStyle(fontSize: 14, color: cp.text),
              decoration: InputDecoration(
                hintText: 'Add Tag',
                hintStyle: TextStyle(color: cp.overlay0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cp.surface1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cp.mauve),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                suffixIcon:
                    widget.currentTags.isEmpty
                        ? null
                        : Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth / 2,
                                ),
                                child: Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  alignment: WrapAlignment.end,
                                  children:
                                      widget.currentTags.map((tag) {
                                        final colorValue =
                                            widget.tagColors[tag.name];
                                        final backgroundColor =
                                            TagPalette.getColor(colorValue);
                                        final contrastColor =
                                            TagPalette.getContrastColor(
                                              backgroundColor,
                                            );
                                        return GestureDetector(
                                          onTap: () => _showColorPicker(tag),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0,
                                              vertical: 2.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  tag.name,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: contrastColor,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 4.0),
                                                GestureDetector(
                                                  onTap:
                                                      () => widget.onRemoveTag(
                                                        tag,
                                                      ),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 12,
                                                    color: contrastColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
              ),
              onSubmitted: (value) {
                _onTagSubmitted(value);
              },
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 300,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return ListTile(
                        title: Text(option),
                        onTap: () {
                          onSelected(option);
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ExcalidrawColorPicker extends StatefulWidget {
  final String tagName;
  final Color initialColor;
  final void Function(Color) onColorChanged;

  const _ExcalidrawColorPicker({
    required this.tagName,
    required this.initialColor,
    required this.onColorChanged,
  });

  @override
  State<_ExcalidrawColorPicker> createState() => _ExcalidrawColorPickerState();
}

class _ExcalidrawColorPickerState extends State<_ExcalidrawColorPicker> {
  late Color _currentColor;
  late Color _currentBase;
  late TextEditingController _hexController;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialColor;
    _currentBase = _findBase(_currentColor);
    _hexController = TextEditingController(
      text: _currentColor.toARGB32().toRadixString(16).padLeft(8, '0').substring(2),
    );
  }

  Color _findBase(Color color) {
    for (final base in TagPalette.baseColors) {
      if (base.toARGB32() == color.toARGB32()) return base;
      final shades = TagPalette.getShades(base);
      if (shades != null && shades.any((s) => s.toARGB32() == color.toARGB32())) {
        return base;
      }
    }
    return TagPalette.baseColors[1];
  }

  void _updateColor(Color color, {bool updateBase = true}) {
    setState(() {
      _currentColor = color;
      if (updateBase) {
        _currentBase = _findBase(color);
      }
      _hexController.text =
          _currentColor.toARGB32().toRadixString(16).padLeft(8, '0').substring(2);
    });
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cp = theme.catppuccin;
    final shades = TagPalette.getShades(_currentBase);

    return Dialog(
      backgroundColor: cp.base,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Colors",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: cp.subtext1),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: TagPalette.baseColors.map((color) {
                final isSelected = _currentBase.toARGB32() == color.toARGB32();
                return GestureDetector(
                  onTap: () => _updateColor(color),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? cp.mauve : cp.surface0,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [BoxShadow(color: cp.mauve.withValues(alpha: 0.2), blurRadius: 4)]
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              "Shades",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: cp.subtext1),
            ),
            const SizedBox(height: 12),
            if (shades != null)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: shades.map((color) {
                  final isSelected = _currentColor.toARGB32() == color.toARGB32();
                  return GestureDetector(
                    onTap: () => _updateColor(color, updateBase: false),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? cp.mauve : cp.surface0,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              Text(
                "No shades available for this color",
                style: TextStyle(fontSize: 12, color: cp.subtext0, fontStyle: FontStyle.italic),
              ),
            const SizedBox(height: 20),
            Text(
              "Hex code",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: cp.subtext1),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: cp.surface0,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cp.surface1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text("#", style: TextStyle(color: cp.overlay0, fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _hexController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      style: TextStyle(fontFamily: 'monospace', fontSize: 14, color: cp.text),
                      onSubmitted: (value) {
                        final color = Color(int.parse("FF$value", radix: 16));
                        _updateColor(color);
                      },
                    ),
                  ),
                  Icon(Icons.edit_outlined, size: 18, color: cp.overlay0),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Done", style: TextStyle(color: cp.mauve)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
