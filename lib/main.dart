import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:todotree/storage/element_repository.dart';
import 'package:todotree/storage/json_repository.dart';
import 'package:todotree/ui/palette.dart';
import 'package:todotree/utils/random_string.dart';

import 'domain/element.dart';
import 'ui/node_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeModeNotifier = ValueNotifier(ThemeMode.system);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'TodoTree',
          theme: Catppuccin.latteTheme,
          darkTheme: Catppuccin.mochaTheme,
          themeMode: themeMode,
          home: MyHomePage(
            title: 'TodoTree',
            themeMode: themeMode,
            onToggleTheme: () {
              themeModeNotifier.value =
                  themeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            },
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final String title;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<JsonRepository> _repositoryFuture;

  @override
  void initState() {
    super.initState();
    _repositoryFuture = JsonRepository.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<JsonRepository>(
      future: _repositoryFuture,
      builder: (context, repoSnapshot) {
        if (repoSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (repoSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: SelectableText(
                "Error initializing repository: ${repoSnapshot.error}",
              ),
            ),
          );
        }

        final repository = repoSnapshot.data!;

        return FutureBuilder(
          future: Future.wait([
            repository.getElements(),
            repository.getRootId(),
            repository.getTags(),
            repository.getTagColors(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error loading data: ${snapshot.error}"),
                ),
              );
            } else {
              final data = snapshot.data!;
              final elements = data[0] as Map<NodeId, Node>;
              final rootId = data[1] as NodeId;
              final tags = data[2] as ISet<Tag>;
              final tagColors = data[3] as Map<String, String>;

              return _MainPageContent(
                repository: repository,
                initialNodes: elements,
                rootNode: rootId,
                initialTagList: tags.toSet(),
                initialTagColors: tagColors,
                themeMode: widget.themeMode,
                onToggleTheme: widget.onToggleTheme,
              );
            }
          },
        );
      },
    );
  }
}

class _MainPageContent extends StatefulWidget {
  final ElementRepository repository;
  final Map<NodeId, Node> initialNodes;
  final NodeId rootNode;
  final Set<Tag> initialTagList;
  final Map<String, String> initialTagColors;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const _MainPageContent({
    required this.repository,
    required this.initialNodes,
    required this.rootNode,
    required this.initialTagList,
    required this.initialTagColors,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  State<_MainPageContent> createState() => __MainPageContentState();
}

class __MainPageContentState extends State<_MainPageContent> {
  late Map<NodeId, Node> nodes;
  Set<NodeId> nodesBeingEdited = {};
  bool allowMultipleEdits = false;
  bool showDone = false;
  static final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Set<Tag> tags;
  late Map<String, String> tagColors;

  @override
  void initState() {
    nodes = {...widget.initialNodes};
    tags = {...widget.initialTagList};
    tagColors = {...widget.initialTagColors};
    super.initState();
  }

  Future<void> _createNewAt(NodeId id) async {
    final result = await widget.repository.createNewAt(id);
    nodes[result.updatedParent.id] = result.updatedParent;
    final updatedChild = await widget.repository.updateDesription(
      result.newChild.id,
      NodeDescription(content: getRandomString(5)),
    );
    nodes[result.newChild.id] = updatedChild;
    setState(() {});
  }

  Future<void> _prune(NodeId id) async {
    final result = await widget.repository.pruneNode(id);
    setState(() {
      nodes = result;
    });
  }

  Future<void> _reparent(NodeId child, NodeId newParent) async {
    final result = await widget.repository.reparent(child, newParent);
    nodes[result.updatedNewParent.id] = result.updatedNewParent;
    nodes[result.updatedOldParent.id] = result.updatedOldParent;
    setState(() {});
  }

  Future<void> _updateDescription(
    NodeId id,
    NodeDescription description,
  ) async {
    final result = await widget.repository.updateDesription(id, description);
    nodes[result.id] = result;
    setState(() {});
  }

  Future<void> _updateDetails(NodeId id, NodeDetails details) async {
    final result = await widget.repository.updateDetails(id, details);
    nodes[result.id] = result;
    setState(() {});
  }

  Future<void> _updateDone(NodeId id, bool done) async {
    final result = await widget.repository.updateDone(id, done);
    nodes.addAll(result);
    setState(() {});
  }

  Future<void> _addTag(NodeId id, Tag tag) async {
    final result = await widget.repository.addTag(id, tag);
    setState(() {
      nodes[result.id] = result;
      tags.add(tag);
    });
  }

  Future<void> _removeTag(NodeId id, Tag tag) async {
    final result = await widget.repository.removeTag(id, tag);
    setState(() {
      nodes[result.id] = result;
    });
  }

  Future<void> _setTagColor(String tagName, String color) async {
    await widget.repository.setTagColor(tagName, color);
    setState(() {
      tagColors[tagName] = color;
    });
  }

  void _onEditNode(NodeId id) {
    setState(() {
      if (nodesBeingEdited.contains(id)) {
        nodesBeingEdited.remove(id);
      } else {
        if (!allowMultipleEdits) {
          nodesBeingEdited.clear();
        }
        nodesBeingEdited.add(id);
      }
    });
  }

  void _onToggleMultiEdit() {
    setState(() {
      allowMultipleEdits = !allowMultipleEdits;
      if (!allowMultipleEdits && nodesBeingEdited.length > 1) {
        final first = nodesBeingEdited.first;
        nodesBeingEdited.clear();
        nodesBeingEdited.add(first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          NodeList(
            nodes: nodes,
            treeRoot: widget.rootNode,
            onCreateNewAt: _createNewAt,
            onPrune: _prune,
            onReparent: _reparent,
            onEdit: _onEditNode,
            onDescriptionChanged: _updateDescription,
            onDetailsChanged: _updateDetails,
            onDoneChanged: _updateDone,
            showDone: showDone,
            onToggleShowDone: () {
              setState(() {
                showDone = !showDone;
              });
            },
            onAddTag: _addTag,
            onRemoveTag: _removeTag,
            onSetTagColor: _setTagColor,
            allTags: tags,
            tagColors: tagColors,
            nodesBeingEdited: nodesBeingEdited,
            allowMultipleEdits: allowMultipleEdits,
            onToggleMultiEdit: _onToggleMultiEdit,
            themeMode: widget.themeMode,
            onToggleTheme: widget.onToggleTheme,
          ),
        ],
      ),
    );
  }
}
