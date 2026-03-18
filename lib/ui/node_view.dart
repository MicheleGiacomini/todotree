import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todotree/domain/element.dart';
import 'package:todotree/ui/actions.dart';
import 'package:todotree/ui/clickable_icon.dart';
import 'package:todotree/ui/debounced_text_field.dart';
import 'package:todotree/ui/default_keymaps.dart';
import 'package:todotree/ui/input_system.dart';
import 'package:todotree/ui/palette.dart';
import 'package:todotree/ui/tag_editor.dart';

typedef NodeProvider = Node Function(NodeId);

class NodeList extends StatefulWidget {
  final Map<NodeId, Node> nodes;
  final NodeId treeRoot;
  final void Function(NodeId, {int? index}) onCreateNewAt;
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

  NodeId? focusedNodeId;
  late FocusNode listFocusNode;

  @override
  void initState() {
    expandedNodes.addAll(widget.nodes.map((k, v) => MapEntry(k, false)));
    parents = {
      for (final node in widget.nodes.values) ...{
        for (final child in node.children) child: node.id,
      },
    };
    listFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    listFocusNode.dispose();
    super.dispose();
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

    // Combined KeyMap
    final keyMap = KeyMap([
      ...standardKeyMap.bindings,
      ...vimKeyMap.bindings,
    ]);

    return Actions(
      actions: {
        MoveFocusDownIntent: CallbackAction<MoveFocusDownIntent>(
          onInvoke: (_) {
            if (focusedNodeId == null) {
              if (nodes.isNotEmpty) {
                setState(() => focusedNodeId = nodes.first.node.id);
              }
              return null;
            }
            final index = nodes.indexWhere((n) => n.node.id == focusedNodeId);
            if (index != -1 && index < nodes.length - 1) {
              setState(() => focusedNodeId = nodes[index + 1].node.id);
            }
            return null;
          },
        ),
        MoveFocusUpIntent: CallbackAction<MoveFocusUpIntent>(
          onInvoke: (_) {
            if (focusedNodeId == null) {
              if (nodes.isNotEmpty) {
                setState(() => focusedNodeId = nodes.last.node.id);
              }
              return null;
            }
            final index = nodes.indexWhere((n) => n.node.id == focusedNodeId);
            if (index > 0) {
              setState(() => focusedNodeId = nodes[index - 1].node.id);
            }
            return null;
          },
        ),
        MoveFocusTopIntent: CallbackAction<MoveFocusTopIntent>(
          onInvoke: (_) {
            if (nodes.isNotEmpty) {
              setState(() => focusedNodeId = nodes.first.node.id);
            }
            return null;
          },
        ),
        MoveFocusBottomIntent: CallbackAction<MoveFocusBottomIntent>(
          onInvoke: (_) {
            if (nodes.isNotEmpty) {
              setState(() => focusedNodeId = nodes.last.node.id);
            }
            return null;
          },
        ),
        CollapseIntent: CallbackAction<CollapseIntent>(
          onInvoke: (_) {
            if (focusedNodeId == null) return null;
            if (expandedNodes[focusedNodeId] == true) {
              setState(() => expandedNodes[focusedNodeId!] = false);
            } else {
              // Move to parent
              final parentId = parents[focusedNodeId];
              if (parentId != null && parentId != currentBase) {
                setState(() => focusedNodeId = parentId);
              }
            }
            return null;
          },
        ),
        ExpandIntent: CallbackAction<ExpandIntent>(
          onInvoke: (_) {
            if (focusedNodeId == null) return null;
            if (expandedNodes[focusedNodeId] != true) {
              setState(() => expandedNodes[focusedNodeId!] = true);
            }
            return null;
          },
        ),
        ToggleExpandIntent: CallbackAction<ToggleExpandIntent>(
          onInvoke: (_) {
            if (focusedNodeId == null) return null;
            setState(() {
              expandedNodes[focusedNodeId!] =
                  !(expandedNodes[focusedNodeId!] ?? false);
            });
            return null;
          },
        ),
        EditNodeIntent: CallbackAction<EditNodeIntent>(
          onInvoke: (_) {
            if (focusedNodeId != null) {
              widget.onEdit(focusedNodeId!);
            }
            return null;
          },
        ),
        ToggleDoneIntent: CallbackAction<ToggleDoneIntent>(
          onInvoke: (_) {
            if (focusedNodeId != null) {
              final node = _nodeProvider(focusedNodeId!);
              widget.onDoneChanged(focusedNodeId!, !node.done);
            }
            return null;
          },
        ),
        DeleteNodeIntent: CallbackAction<DeleteNodeIntent>(
          onInvoke: (_) {
            if (focusedNodeId != null) {
              widget.onPrune(focusedNodeId!);
              // Correct focus?
              setState(() => focusedNodeId = null); // Or find next
            }
            return null;
          },
        ),
        IndentNodeIntent: CallbackAction<IndentNodeIntent>(
          onInvoke: (_) {
            if (focusedNodeId == null) return null;
            final parent = parents[focusedNodeId];
            if (parent == null) return null;
            final parentNode = _nodeProvider(parent);
            final children = parentNode.children;
            final index = children.indexOf(focusedNodeId!);
            if (index > 0) {
              final newParent = children[index - 1];
              widget.onReparent(focusedNodeId!, newParent);
              setState(() => ensureExpanded(newParent));
            }
            return null;
          },
        ),
        OutdentNodeIntent: CallbackAction<OutdentNodeIntent>(
          onInvoke: (_) {
            if (focusedNodeId == null) return null;
            final parent = parents[focusedNodeId];
            if (parent == null || parent == widget.treeRoot) return null;
            final grandParent = parents[parent];
            if (grandParent != null) {
              widget.onReparent(focusedNodeId!, grandParent);
            }
            return null;
          },
        ),
        CreateNodeIntent: CallbackAction<CreateNodeIntent>(
          onInvoke: (_) {
            if (focusedNodeId != null) {
              final parentId = parents[focusedNodeId!];
              if (parentId != null) {
                final parentNode = _nodeProvider(parentId);
                final index = parentNode.children.indexOf(focusedNodeId!);
                if (index != -1) {
                  widget.onCreateNewAt(parentId, index: index + 1);
                } else {
                  widget.onCreateNewAt(parentId);
                }
              }
            } else {
              widget.onCreateNewAt(currentBase);
            }
            return null;
          },
        ),
        CreateNodeAboveIntent: CallbackAction<CreateNodeAboveIntent>(
          onInvoke: (_) {
            if (focusedNodeId != null) {
              final parentId = parents[focusedNodeId!];
              if (parentId != null) {
                final parentNode = _nodeProvider(parentId);
                final index = parentNode.children.indexOf(focusedNodeId!);
                if (index != -1) {
                  widget.onCreateNewAt(parentId, index: index);
                } else {
                  widget.onCreateNewAt(parentId);
                }
              }
            }
            return null;
          },
        ),
      },
      child: InputManager(
        focusNode: listFocusNode,
        keyMap: keyMap,
        enabled: !widget.nodesBeingEdited.isNotEmpty, // Disable when editing
        child: CustomScrollView(
          slivers: [
            SliverMainAxisGroup(
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
                final id = item.node.id;
                final isEditing = widget.nodesBeingEdited.contains(id);
                final isFocused = id == focusedNodeId;

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
                        
                        final nodeView = NodeView(
                          key: ValueKey(id),
                          nodeId: id,
                          nodeProvider: _nodeProvider,
                          level: item.depth,
                          levelPadding: levelPadding,
                          expanded:
                              item.node.children.isNotEmpty &&
                              (expandedNodes[id] ?? false),
                          isEditing: isEditing,
                          isFocused: isFocused, // Passed down
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
                          onFocus: () {
                            setState(() {
                              focusedNodeId = id;
                              listFocusNode.requestFocus();
                            });
                          },
                        );
                        return TapRegion(
                          enabled: isEditing,
                          onTapOutside: (_) {
                            widget.onEdit(id);
                            // Return focus to list when stopping edit
                            listFocusNode.requestFocus();
                          },
                          child: CallbackShortcuts(
                            bindings: {
                              const SingleActivator(LogicalKeyboardKey.escape): () {
                                if (isEditing) {
                                   widget.onEdit(id);
                                   listFocusNode.requestFocus();
                                }
                              },
                            },
                            child: LongPressDraggable(
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
                            ),
                          ),
                        );
                      },
                );
              }),
            ),
          ],
        ),
          ],
        ),
      ),
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
  final bool isFocused;
  final void Function()? onExpand;
  final void Function() onEnter;
  final void Function() onCreateChild;
  final void Function() onPrune;
  final void Function() onEdit;
  final void Function() onFocus;
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
    required this.isFocused,
    required this.onExpand,
    required this.onEnter,
    required this.onCreateChild,
    required this.onPrune,
    required this.onEdit,
    required this.onFocus,
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
  late final FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    final node = widget.nodeProvider(widget.nodeId);
    _descriptionController = TextEditingController(
      text: node.description.content,
    );
    _detailsController = TextEditingController(text: node.details.content);
    _descriptionFocusNode = FocusNode();
    if (widget.isEditing) {
      _descriptionFocusNode.requestFocus();
    }
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
    if (widget.isEditing && !oldWidget.isEditing) {
      _descriptionFocusNode.requestFocus();
    } else if (!widget.isEditing && oldWidget.isEditing) {
      _descriptionFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _detailsController.dispose();
    _descriptionFocusNode.dispose();
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

    // Visual indication for focus
    final decoration = BoxDecoration(
      color: widget.isFocused ? cp.brightBlack.withValues(alpha: 0.3) : null,
      border: Border(
        bottom: BorderSide(color: theme.dividerColor, width: 1.0),
        left: widget.isFocused 
            ? BorderSide(color: cp.magenta, width: 4.0) 
            : BorderSide.none,
      ),
    );

    return Padding(
      padding: EdgeInsets.only(left: widget.level * widget.levelPadding),
      child: Opacity(
        opacity: opacity,
        child: DecoratedBox(
          decoration: decoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                   widget.onFocus();
                   if (widget.onExpand != null) widget.onExpand!();
                },
                onDoubleTap: widget.onEdit,
                behavior: HitTestBehavior.opaque,
                child: ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                         onTap: () {
                             widget.onFocus();
                             if(widget.onExpand != null) widget.onExpand!();
                         },
                         child: AnimatedRotation(
                           turns: effectiveIconTurns,
                           duration: widget.animationDuration,
                           child:
                               widget.onExpand == null
                                   ? Icon(Icons.remove, color: cp.brightBlack)
                                   : Icon(Icons.chevron_right, color: cp.brightBlack),
                         ),
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
                            child: IgnorePointer(
                              ignoring: !widget.isEditing,
                              child: DebouncedTextField(
                                controller: _descriptionController,
                                focusNode: _descriptionFocusNode,
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
                                onSubmitted: (_) {
                                  widget.onEdit();
                                },
                              ),
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
