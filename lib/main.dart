import 'package:flutter/material.dart';
import 'package:todotree/storage/element_repository.dart';
import 'package:todotree/storage/in_memory_repository.dart';
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final repository = InMemoryRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([repository.getElements(), repository.getRootId()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final data = snapshot.data!;
            final elements = data[0] as Map<NodeId, Node>;
            final rootId = data[1] as NodeId;
            return _MainPageContent(
              repository: repository,
              initialNodes: elements,
              rootNode: rootId,
            );
          }
        },
      ),
    );
  }
}

class _MainPageContent extends StatefulWidget {
  final ElementRepository repository;
  final Map<NodeId, Node> initialNodes;
  final NodeId rootNode;

  const _MainPageContent({
    required this.repository,
    required this.initialNodes,
    required this.rootNode,
  });

  @override
  State<_MainPageContent> createState() => __MainPageContentState();
}

class __MainPageContentState extends State<_MainPageContent> {
  late Map<NodeId, Node> nodes;

  @override
  void initState() {
    nodes = widget.initialNodes;
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        NodeList(
          nodes: nodes,
          treeRoot: widget.rootNode,
          onCreateNewAt: _createNewAt,
          onPrune: _prune,
          onReparent: _reparent,
        ),
      ],
    );
  }
}
