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
        return AlertDialog(
          title: Text("Choose color for ${tag.name}"),
          content: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: TagPalette.colors.map((color) {
              return GestureDetector(
                onTap: () {
                  widget.onSetTagColor(tag.name, color.toARGB32());
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.tagColors[tag.name] == color.toARGB32()
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.currentTags.map((tag) {
            final colorValue = widget.tagColors[tag.name];
            final backgroundColor = TagPalette.getColor(colorValue);
            return InputChip(
              backgroundColor: backgroundColor,
              label: Text(
                tag.name,
                style: TextStyle(
                  color: TagPalette.getContrastColor(backgroundColor),
                ),
              ),
              onDeleted: () => widget.onRemoveTag(tag),
              deleteIconColor: TagPalette.getContrastColor(backgroundColor),
              onPressed: () => _showColorPicker(tag),
            );
          }).toList(),
        ),
        const SizedBox(height: 8.0),
        RawAutocomplete<String>(
          textEditingController: _controller,
          focusNode: _focusNode,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const <String>[];
            }
            
            final choices = widget.allTags
                .map((t) => t.name)
                .where((name) => !widget.currentTags.any((ct) => ct.name == name))
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
            return TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(
                labelText: 'Add Tag',
                border: OutlineInputBorder(),
                isDense: true,
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
                  constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
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
        ),
      ],
    );
  }
}
