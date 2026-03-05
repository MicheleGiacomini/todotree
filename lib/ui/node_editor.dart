import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:todotree/ui/node_view.dart';
import 'package:todotree/utils/debouncer.dart';

import '../domain/element.dart';

class NodeEditor extends StatefulWidget {
  final NodeId nodeId;
  final NodeProvider nodeProvider;
  final ISet<Tag> tagList;
  final void Function(NodeDescription) onUpdateDescription;
  final void Function(NodeDetails) onUpdateDetails;
  final void Function(ISet<Tag>) onUpdateTags;

  const NodeEditor({
    super.key,
    required this.nodeId,
    required this.nodeProvider,
    required this.onUpdateDescription,
    required this.onUpdateDetails,
    required this.onUpdateTags,
    required this.tagList,
  });

  @override
  State<NodeEditor> createState() => _NodeEditorState();
}

class _NodeEditorState extends State<NodeEditor> {
  late Node node;
  final descriptionController = TextEditingController();
  final detailsController = TextEditingController();
  final debouncer = Debouncer();

  @override
  void initState() {
    node = widget.nodeProvider(widget.nodeId);
    descriptionController.text = node.description.content;
    detailsController.text = node.details.content;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NodeEditor oldWidget) {
    node = widget.nodeProvider(widget.nodeId);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text("Edit node", style: textTheme.headlineMedium),
        TextField(
          decoration: InputDecoration(labelText: "Description"),
          controller: descriptionController,
          onChanged: (value) {
            debouncer.run(
              () => widget.onUpdateDescription(NodeDescription(content: value)),
            );
          },
          onTapOutside: (_) => debouncer.complete(),
        ),
        TextField(
          minLines: 7,
          maxLines: null,
          decoration: InputDecoration(labelText: "Details"),
          controller: detailsController,
          onChanged: (value) {
            debouncer.run(
              () => widget.onUpdateDetails(NodeDetails(content: value)),
            );
          },
        ),
      ],
    );
  }
}
