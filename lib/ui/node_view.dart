import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todotree/domain/element.dart';

typedef NodeProvider = Node Function(NodeId);

class NodeList extends StatefulWidget {
  final Map<NodeId, Node> nodes;
  final NodeId treeRoot;
  final void Function(NodeId) onCreateNewAt;
  final void Function(NodeId) onPrune;
  final void Function(NodeId child, NodeId newParent) onReparent;
  final void Function(NodeId) onEdit;

  const NodeList({
    super.key,
    required this.nodes,
    required this.treeRoot,
    required this.onCreateNewAt,
    required this.onPrune,
    required this.onReparent,
    required this.onEdit,
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
      for (final childId in node.children) ...[
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

  @override
  Widget build(BuildContext context) {
    final nodes = _buildChildren(currentBase, 0);
    return SliverMainAxisGroup(
      slivers: [
        SliverAppBar(
          pinned: true,
          elevation: 0,
          toolbarHeight: 40.0,
          backgroundColor: Colors.white,
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
              ),
            ),
          ),
          leading: Center(
            child: ClickableIcon(
              icon: Icons.home,
              onTap: () {
                setState(() {
                  currentBase = widget.treeRoot;
                });
              },
            ),
          ),
          actions: [
            ClickableIcon(
              icon: Icons.add_circle,
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
                            ? Colors.blue.withValues(alpha: 0.2)
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

class NodeView extends StatelessWidget {
  final NodeId nodeId;
  final NodeProvider nodeProvider;
  final int level;
  final double levelPadding;
  final bool expanded;
  final void Function()? onExpand;
  final void Function() onEnter;
  final void Function() onCreateChild;
  final void Function() onPrune;
  final void Function() onEdit;
  final Duration animationDuration;

  const NodeView({
    super.key,
    required this.nodeId,
    required this.nodeProvider,
    required this.level,
    required this.levelPadding,
    required this.expanded,
    required this.onExpand,
    required this.onEnter,
    required this.onCreateChild,
    required this.onPrune,
    required this.onEdit,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconTurns = expanded ? 0.25 : 0.0;
    final node = nodeProvider(nodeId);
    return Padding(
      padding: EdgeInsets.only(left: level * levelPadding),
      child: ListTile(
        onTap: onExpand,
        leading: AnimatedRotation(
          turns: effectiveIconTurns,
          duration: animationDuration,
          child: onExpand == null
              ? Icon(Icons.remove)
              : Icon(Icons.chevron_right),
        ),
        title: Text(node.description.content),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClickableIcon(icon: Icons.edit, onTap: onEdit),
            ClickableIcon(icon: Icons.add_circle, onTap: onCreateChild),
            ClickableIcon(icon: Icons.folder_open, onTap: onEnter),
            ClickableIcon(icon: Icons.delete, onTap: onPrune),
          ],
        ),
      ),
    );
  }
}

class ClickableIcon extends StatefulWidget {
  final void Function()? onTap;
  final IconData icon;
  const ClickableIcon({super.key, required this.icon, this.onTap});

  @override
  State<ClickableIcon> createState() => _ClickableIconState();
}

class _ClickableIconState extends State<ClickableIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        _hovered = true;
      }),
      onExit: (event) => setState(() {
        _hovered = false;
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Icon(widget.icon),
            if (_hovered)
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Icon(widget.icon),
              ),
          ],
        ),
      ),
    );
  }
}
