import 'package:flutter/material.dart';
import 'package:todotree/domain/element.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:todotree/ui/palette.dart';

class TagEditor extends StatefulWidget {
  final IList<Tag> currentTags;
  final Set<Tag> allTags;
  final Map<String, String> tagColors;
  final void Function(Tag) onAddTag;
  final void Function(Tag) onRemoveTag;
  final void Function(String, String) onSetTagColor;

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
    final tagColorStr = widget.tagColors[tag.name];
    final tagColor = tagColorStr != null
        ? TagColor.fromStorageString(tagColorStr)
        : const TagColor(SemanticColor.blue);
    showDialog(
      context: context,
      builder: (context) {
        return _ExcalidrawColorPicker(
          tagName: tag.name,
          initialColor: tagColor,
          onColorChanged: (color) {
            widget.onSetTagColor(tag.name, color.toStorageString());
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
            final cp = theme.palette;
            return TextField(
              controller: controller,
              focusNode: focusNode,
              style: TextStyle(fontSize: 14, color: cp.foreground),
              decoration: InputDecoration(
                hintText: 'Add Tag',
                hintStyle: TextStyle(color: cp.brightBlack),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cp.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cp.magenta),
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
                                        final tagColorStr =
                                            widget.tagColors[tag.name];
                                        final tagColor = tagColorStr != null
                                            ? TagColor.fromStorageString(
                                              tagColorStr,
                                            )
                                            : const TagColor(
                                              SemanticColor.blue,
                                            );
                                        final backgroundColor =
                                            TagPalette.resolveColor(
                                              context,
                                              tagColor,
                                            );
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
  final TagColor initialColor;
  final void Function(TagColor) onColorChanged;

  const _ExcalidrawColorPicker({
    required this.tagName,
    required this.initialColor,
    required this.onColorChanged,
  });

  @override
  State<_ExcalidrawColorPicker> createState() => _ExcalidrawColorPickerState();
}

class _ExcalidrawColorPickerState extends State<_ExcalidrawColorPicker> {
  late SemanticColor _currentColor;
  late int _currentShade;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialColor.color;
    _currentShade = widget.initialColor.shade;
  }

  void _updateColor(SemanticColor color) {
    setState(() {
      _currentColor = color;
    });
    widget.onColorChanged(TagColor(_currentColor, _currentShade));
  }

  void _updateShade(int shade) {
    setState(() {
      _currentShade = shade;
    });
    widget.onColorChanged(TagColor(_currentColor, _currentShade));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.palette;

    return Dialog(
      backgroundColor: palette.background,
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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: palette.brightBlack,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  TagPalette.baseColors.map((color) {
                    final isSelected = _currentColor == color;
                    final hexColor = palette[color];
                    return GestureDetector(
                      onTap: () => _updateColor(color),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: hexColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? palette.magenta : palette.black,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow:
                              isSelected
                                  ? [
                                    BoxShadow(
                                      color: palette.magenta.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 4,
                                    ),
                                  ]
                                  : null,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              "Shades",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: palette.brightBlack,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(5, (index) {
                final isSelected = _currentShade == index;
                final shadeColor = TagPalette.resolveColor(
                  context,
                  TagColor(_currentColor, index),
                );
                return GestureDetector(
                  onTap: () => _updateShade(index),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: shadeColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? palette.magenta : palette.black,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Done", style: TextStyle(color: palette.magenta)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
