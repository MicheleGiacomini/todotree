import 'package:flutter/material.dart';
import 'package:todotree/domain/element.dart';
import 'package:todotree/ui/clickable_icon.dart';
import 'package:todotree/ui/debounced_text_field.dart';
import 'package:todotree/ui/tag_editor.dart';
import 'package:todotree/ui/palette.dart';

typedef NodeProvider = Node Function(NodeId);

class NodeList extends StatefulWidget {
  final Map<NodeId, Node> nodes;
  final NodeId treeRoot;
  final void Function(NodeId) onCreateNewAt;
  final void Function(NodeId) onPrune;
  final void Function(NodeId child, NodeId newParent) onReparent;
  final void Function(NodeId) onEdit;
  final void Function(NodeId, NodeDescription) onDescriptionChanged;
  final void Function(NodeId, NodeDetails) onDetailsChanged;
  final void Function(NodeId, bool) onDoneChanged;
  final bool showDone;
  final void Function() onToggleShowDone;
  final void Function(NodeId, Tag) onAddTag;
  final void Function(NodeId, Tag) onRemoveTag;
  final void Function(String, String) onSetTagColor;
  final Set<Tag> allTags;
  final Map<String, String> tagColors;
  final Set<NodeId> nodesBeingEdited;
  final bool allowMultipleEdits;
  final void Function() onToggleMultiEdit;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const NodeList({
    super.key,
    required this.nodes,
    required this.treeRoot,
    required this.onCreateNewAt,
    required this.onPrune,
    required this.onReparent,
    required this.onEdit,
    required this.onDescriptionChanged,
    required this.onDetailsChanged,
    required this.onDoneChanged,
    required this.showDone,
    required this.onToggleShowDone,
    required this.onAddTag,
    required this.onRemoveTag,
    required this.onSetTagColor,
    required this.allTags,
    required this.tagColors,
    required this.nodesBeingEdited,
    required this.allowMultipleEdits,
    required this.onToggleMultiEdit,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  State<NodeList> createState() => _NodeListState();
}

class _NodeViewData {
  final Node node;
  final int depth;

  _NodeViewData({required this.node, required this.depth});
}

class _NodeListState extends State<NodeList> {
  late NodeId currentBase = widget.treeRoot;
  Map<NodeId, bool> expandedNodes = {};
  late Map<NodeId, NodeId> parents;
  double levelPadding = 25;

  @override
  void initState() {
    expandedNodes.addAll(widget.nodes.map((k, v) => MapEntry(k, false)));
    parents = {
      for (final node in widget.nodes.values) ...{
        for (final child in node.children) child: node.id,
      },
    };
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NodeList oldWidget) {
    parents = {
      for (final node in widget.nodes.values) ...{
        for (final child in node.children) child: node.id,
      },
    };
    for (final id in widget.nodes.keys) {
      expandedNodes.putIfAbsent(id, () => false);
    }
    super.didUpdateWidget(oldWidget);
  }

  Node _nodeProvider(NodeId id) => widget.nodes[id]!;

  List<_NodeViewData> _buildChildren(NodeId id, int depth) {
    final node = _nodeProvider(id);
    return [
      for (final childId in node.children)
        if (widget.showDone || !(_nodeProvider(childId).done)) ...[
          _NodeViewData(node: _nodeProvider(childId), depth: depth),
          if (expandedNodes[childId] == true)
            ..._buildChildren(childId, depth + 1),
        ],
    ];
  }

  bool _isRecursiveChild(NodeId parent, NodeId? child) {
    if (parent == child) {
      return true;
    } else if (child == null) {
      return false;
    } else {
      return _isRecursiveChild(parent, parents[child]);
    }
  }

  void ensureExpanded(NodeId id) {
    expandedNodes[id] = true;
  }

  bool _areAllChildrenDone(NodeId id) {
    final node = _nodeProvider(id);
    for (final childId in node.children) {
      final child = _nodeProvider(childId);
      if (!child.done) return false;
      if (!_areAllChildrenDone(childId)) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final nodes = _buildChildren(currentBase, 0);
    final theme = Theme.of(context);
    final cp = theme.palette;

    return SliverMainAxisGroup(
      slivers: [
        SliverAppBar(
          pinned: true,
          elevation: 0,
          toolbarHeight: 40.0,
          backgroundColor: theme.appBarTheme.backgroundColor,
          titleSpacing: 0,
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentBase = parents[currentBase] ?? widget.treeRoot;
                });
              },
              child: Text(
                _nodeProvider(currentBase).description.content,
                overflow: TextOverflow.fade,
                style: TextStyle(color: cp.foreground),
              ),
            ),
          ),
          leading: Center(
            child: ClickableIcon(
              icon: Icons.home,
              color: cp.brightBlue,
              onTap: () {
                setState(() {
                  currentBase = widget.treeRoot;
                });
              },
            ),
          ),
          actions: [
            ClickableIcon(
              icon: widget.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: cp.yellow,
              onTap: widget.onToggleTheme,
            ),
            ClickableIcon(
              icon: widget.showDone ? Icons.visibility : Icons.visibility_off,
              color: cp.cyan,
              onTap: widget.onToggleShowDone,
            ),
            ClickableIcon(
              icon: widget.allowMultipleEdits
                  ? Icons.layers
                  : Icons.layers_clear,
              color: cp.magenta,
              onTap: widget.onToggleMultiEdit,
            ),
            ClickableIcon(
              icon: Icons.add_circle,
              color: cp.green,
              onTap: () {
                widget.onCreateNewAt(currentBase);
              },
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: nodes.length, (
            context,
            index,
          ) {
            final item = nodes[index];
            return DragTarget<String>(
              onWillAcceptWithDetails: (details) {
                final data = details.data;
                return !_isRecursiveChild(
                  NodeId.fromString(data),
                  item.node.id,
                );
              },
              onAcceptWithDetails: (details) {
                widget.onReparent(
                  NodeId.fromString(details.data),
                  item.node.id,
                );
                setState(() {
                  ensureExpanded(item.node.id);
                });
              },
              builder:
                  (
                    BuildContext context,
                    List<String?> candidateData,
                    List<dynamic> rejectedData,
                  ) {
                    final id = item.node.id;
                    final nodeView = NodeView(
                      nodeId: id,
                      nodeProvider: _nodeProvider,
                      level: item.depth,
                      levelPadding: levelPadding,
                      expanded:
                          item.node.children.isNotEmpty &&
                          (expandedNodes[id] ?? false),
                      isEditing: widget.nodesBeingEdited.contains(id),
                      onDescriptionChanged: (p0) {
                        widget.onDescriptionChanged(id, p0);
                      },
                      onDetailsChanged: (p0) {
                        widget.onDetailsChanged(id, p0);
                      },
                      onDoneChanged: (p0) {
                        widget.onDoneChanged(id, p0);
                      },
                      onAddTag: (p0) {
                        widget.onAddTag(id, p0);
                      },
                      onRemoveTag: (p0) {
                        widget.onRemoveTag(id, p0);
                      },
                      onSetTagColor: widget.onSetTagColor,
                      allTags: widget.allTags,
                      tagColors: widget.tagColors,
                      allChildrenDone: _areAllChildrenDone(id),
                      onExpand: item.node.children.isEmpty
                          ? null
                          : () {
                              setState(() {
                                expandedNodes[id] =
                                    !(expandedNodes[id] ?? false);
                              });
                            },
                      onEnter: () {
                        setState(() {
                          currentBase = id;
                        });
                      },
                      onCreateChild: () {
                        setState(() {
                          expandedNodes[id] = true;
                        });
                        widget.onCreateNewAt(id);
                      },
                      onPrune: () {
                        widget.onPrune(id);
                      },
                      onEdit: () {
                        widget.onEdit(id);
                      },
                    );
                    return LongPressDraggable(
                      delay: Duration(milliseconds: 200),
                      data: id.toString(),
                      feedback: Material(
                        elevation: 10,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                          ),
                          child: nodeView,
                        ),
                      ),
                      childWhenDragging: Opacity(opacity: 0.5, child: nodeView),
                      child: Container(
                        color: candidateData.isNotEmpty
                            ? cp.blue.withValues(alpha: 0.2)
                            : null,
                        child: nodeView,
                      ),
                    );
                  },
            );
          }),
        ),
      ],
    );
  }
}

class NodeView extends StatefulWidget {
  final NodeId nodeId;
  final NodeProvider nodeProvider;
  final int level;
  final double levelPadding;
  final bool expanded;
  final bool isEditing;
  final void Function()? onExpand;
  final void Function() onEnter;
  final void Function() onCreateChild;
  final void Function() onPrune;
  final void Function() onEdit;
  final void Function(NodeDescription) onDescriptionChanged;
  final void Function(NodeDetails) onDetailsChanged;
  final void Function(bool) onDoneChanged;
  final void Function(Tag) onAddTag;
  final void Function(Tag) onRemoveTag;
  final void Function(String, String) onSetTagColor;
  final Set<Tag> allTags;
  final Map<String, String> tagColors;
  final bool allChildrenDone;
  final Duration animationDuration;

  const NodeView({
    super.key,
    required this.nodeId,
    required this.nodeProvider,
    required this.level,
    required this.levelPadding,
    required this.expanded,
    required this.isEditing,
    required this.onExpand,
    required this.onEnter,
    required this.onCreateChild,
    required this.onPrune,
    required this.onEdit,
    required this.onDescriptionChanged,
    required this.onDetailsChanged,
    required this.onDoneChanged,
    required this.onAddTag,
    required this.onRemoveTag,
    required this.onSetTagColor,
    required this.allTags,
    required this.tagColors,
    required this.allChildrenDone,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<NodeView> createState() => _NodeViewState();
}

class _NodeViewState extends State<NodeView> {
  late final TextEditingController _descriptionController;
  late final TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    final node = widget.nodeProvider(widget.nodeId);
    _descriptionController = TextEditingController(
      text: node.description.content,
    );
    _detailsController = TextEditingController(text: node.details.content);
  }

  @override
  void didUpdateWidget(covariant NodeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final node = widget.nodeProvider(widget.nodeId);
    if (_descriptionController.text != node.description.content) {
      _descriptionController.text = node.description.content;
    }
    if (_detailsController.text != node.details.content) {
      _detailsController.text = node.details.content;
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = widget.nodeProvider(widget.nodeId);
    final theme = Theme.of(context);
    final cp = theme.palette;
    final effectiveIconTurns = widget.expanded ? 0.25 : 0.0;
    final opacity = node.done ? 0.5 : 1.0;

    final canBeMarkedDone = node.done || widget.allChildrenDone;

    return Padding(
      padding: EdgeInsets.only(left: widget.level * widget.levelPadding),
      child: Opacity(
        opacity: opacity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: theme.dividerColor, width: 1.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: widget.onExpand,
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedRotation(
                      turns: effectiveIconTurns,
                      duration: widget.animationDuration,
                      child:
                          widget.onExpand == null
                              ? Icon(Icons.remove, color: cp.brightBlack)
                              : Icon(Icons.chevron_right, color: cp.brightBlack),
                    ),
                    Checkbox(
                      value: node.done,
                      onChanged:
                          canBeMarkedDone
                              ? (value) {
                                if (value != null) {
                                  widget.onDoneChanged(value);
                                }
                              }
                              : null,
                    ),
                  ],
                ),
                title: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      children: [
                        Expanded(
                          child: DebouncedTextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            style: TextStyle(
                              color: cp.foreground,
                              decoration:
                                  node.done
                                      ? TextDecoration.lineThrough
                                      : null,
                              decorationColor: cp.brightBlack,
                            ),
                            onChanged: (value) {
                              widget.onDescriptionChanged(
                                NodeDescription(content: value),
                              );
                            },
                          ),
                        ),
                        if (node.tags.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth / 2,
                              ),
                              child: Wrap(
                                spacing: 4.0,
                                runSpacing: 2.0,
                                alignment: WrapAlignment.end,
                                children:
                                    node.tags.map((tag) {
                                      final tagColorStr = widget.tagColors[tag.name];
                                      final tagColor = tagColorStr != null 
                                          ? TagColor.fromStorageString(tagColorStr)
                                          : const TagColor(SemanticColor.blue);
                                      final color = TagPalette.resolveColor(
                                        context,
                                        tagColor,
                                      );
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                          vertical: 2.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: color,
                                          borderRadius: BorderRadius.circular(
                                            4.0,
                                          ),
                                        ),
                                        child: Text(
                                          tag.name,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: TagPalette.getContrastColor(
                                              color,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClickableIcon(
                      icon: widget.isEditing ? Icons.check : Icons.edit,
                      color: widget.isEditing ? cp.green : cp.blue,
                      onTap: widget.onEdit,
                    ),
                    ClickableIcon(
                      icon: Icons.add_circle,
                      color: cp.green,
                      onTap: widget.onCreateChild,
                    ),
                    ClickableIcon(
                      icon: Icons.folder_open,
                      color: cp.yellow,
                      onTap: widget.onEnter,
                    ),
                    ClickableIcon(
                      icon: Icons.delete,
                      color: cp.red,
                      onTap: widget.onPrune,
                    ),
                  ],
                ),
              ),
              if (widget.isEditing)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DebouncedTextField(
                        controller: _detailsController,
                        minLines: 3,
                        maxLines: null,
                        style: TextStyle(color: cp.foreground),
                        decoration: InputDecoration(
                          labelText: "Details",
                          labelStyle: TextStyle(color: cp.brightBlack),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cp.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cp.magenta),
                          ),
                        ),
                        onChanged: (value) {
                          widget.onDetailsChanged(NodeDetails(content: value));
                        },
                      ),
                      const SizedBox(height: 8.0),
                      TagEditor(
                        currentTags: node.tags,
                        allTags: widget.allTags,
                        tagColors: widget.tagColors,
                        onAddTag: widget.onAddTag,
                        onRemoveTag: widget.onRemoveTag,
                        onSetTagColor: widget.onSetTagColor,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
