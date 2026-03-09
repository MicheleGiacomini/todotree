import 'package:flutter/material.dart';
import 'package:todotree/domain/element.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class TagEditor extends StatefulWidget {
  final IList<Tag> currentTags;
  final Set<Tag> allTags;
  final void Function(Tag) onAddTag;
  final void Function(Tag) onRemoveTag;

  const TagEditor({
    super.key,
    required this.currentTags,
    required this.allTags,
    required this.onAddTag,
    required this.onRemoveTag,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.currentTags.map((tag) {
            return Chip(
              label: Text(tag.name),
              onDeleted: () => widget.onRemoveTag(tag),
            );
          }).toList(),
        ),
        const SizedBox(height: 8.0),
        RawAutocomplete<String>(
          textEditingController: _controller,
          focusNode: _focusNode,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
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
