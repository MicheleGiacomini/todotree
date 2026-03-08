import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:todotree/storage/element_repository.dart';
import 'package:todotree/storage/in_memory_repository.dart';
import 'package:todotree/ui/node_editor.dart';
import 'package:todotree/utils/random_string.dart';

import 'domain/element.dart';
import 'ui/node_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final repository = InMemoryRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        repository.getElements(),
        repository.getRootId(),
        repository.getTags(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          final data = snapshot.data!;
          final elements = data[0] as Map<NodeId, Node>;
          final rootId = data[1] as NodeId;
          final tags = data[2] as ISet<Tag>;

          return _MainPageContent(
            repository: repository,
            initialNodes: elements,
            rootNode: rootId,
            initialTagList: tags.toSet(),
          );
        }
      },
    );
  }
}

class _MainPageContent extends StatefulWidget {
  final ElementRepository repository;
  final Map<NodeId, Node> initialNodes;
  final NodeId rootNode;
  final Set<Tag> initialTagList;

  const _MainPageContent({
    required this.repository,
    required this.initialNodes,
    required this.rootNode,
    required this.initialTagList,
  });

  @override
  State<_MainPageContent> createState() => __MainPageContentState();
}

class __MainPageContentState extends State<_MainPageContent> {
  late Map<NodeId, Node> nodes;
  NodeId? nodeBeingEdited;
  static final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Set<Tag> tags;

  @override
  void initState() {
    nodes = {...widget.initialNodes};
    tags = {...widget.initialTagList};
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

  void _onEditNode(NodeId id) {
    setState(() {
      nodeBeingEdited = id;
    });
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: nodeBeingEdited == null
          ? null
          : Drawer(
              child: NodeEditor(
                nodeId: nodeBeingEdited!,
                nodeProvider: (NodeId p1) => nodes[p1]!,
                onUpdateDescription: (desc) =>
                    _updateDescription(nodeBeingEdited!, desc),
                onUpdateDetails: (details) =>
                    _updateDetails(nodeBeingEdited!, details),
                onUpdateTags: (tags) {},
                tagList: tags.toISet(),
              ),
            ),
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
          ),
        ],
      ),
    );
  }
}
