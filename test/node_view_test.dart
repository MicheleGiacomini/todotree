import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todotree/domain/element.dart';
import 'package:todotree/ui/node_view.dart';

void main() {
  testWidgets('Checkbox is disabled if children are not done', (
    WidgetTester tester,
  ) async {
    final rootId = NodeId.random();
    final childId = NodeId.random();

    final nodes = {
      rootId: Node(
        id: rootId,
        description: NodeDescription(content: 'Root'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([childId]),
      ),
      childId: Node(
        id: childId,
        description: NodeDescription(content: 'Child'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([]),
      ),
    };

    Node nodeProvider(NodeId id) => nodes[id]!;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NodeView(
            nodeId: rootId,
            nodeProvider: nodeProvider,
            level: 0,
            levelPadding: 20,
            expanded: true,
            isEditing: false,
            onExpand: () {},
            onEnter: () {},
            onCreateChild: () {},
            onPrune: () {},
            onEdit: () {},
            onDescriptionChanged: (_) {},
            onDetailsChanged: (_) {},
            onDoneChanged: (_) {},
            onAddTag: (_) {},
            onRemoveTag: (_) {},
            onSetTagColor: (_, _) {},
            allTags: {},
            tagColors: {},
            allChildrenDone: false,
          ),
        ),
      ),
    );

    final checkboxFinder = find.byType(Checkbox);
    expect(checkboxFinder, findsOneWidget);

    final Checkbox checkbox = tester.widget(checkboxFinder);
    expect(checkbox.onChanged, isNull);
  });

  testWidgets('Checkbox is enabled if all children are done', (
    WidgetTester tester,
  ) async {
    final rootId = NodeId.random();
    final childId = NodeId.random();

    final nodes = {
      rootId: Node(
        id: rootId,
        description: NodeDescription(content: 'Root'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([childId]),
      ),
      childId: Node(
        id: childId,
        description: NodeDescription(content: 'Child'),
        details: NodeDetails(content: ''),
        done: true,
        tags: IList([]),
        children: IList([]),
      ),
    };

    Node nodeProvider(NodeId id) => nodes[id]!;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NodeView(
            nodeId: rootId,
            nodeProvider: nodeProvider,
            level: 0,
            levelPadding: 20,
            expanded: true,
            isEditing: false,
            onExpand: () {},
            onEnter: () {},
            onCreateChild: () {},
            onPrune: () {},
            onEdit: () {},
            onDescriptionChanged: (_) {},
            onDetailsChanged: (_) {},
            onDoneChanged: (_) {},
            onAddTag: (_) {},
            onRemoveTag: (_) {},
            onSetTagColor: (_, _) {},
            allTags: {},
            tagColors: {},
            allChildrenDone: true,
          ),
        ),
      ),
    );

    final checkboxFinder = find.byType(Checkbox);
    expect(checkboxFinder, findsOneWidget);

    final Checkbox checkbox = tester.widget(checkboxFinder);
    expect(checkbox.onChanged, isNotNull);
  });

  testWidgets('Checkbox is enabled if it has no children', (
    WidgetTester tester,
  ) async {
    final rootId = NodeId.random();

    final nodes = {
      rootId: Node(
        id: rootId,
        description: NodeDescription(content: 'Root'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([]),
      ),
    };

    Node nodeProvider(NodeId id) => nodes[id]!;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NodeView(
            nodeId: rootId,
            nodeProvider: nodeProvider,
            level: 0,
            levelPadding: 20,
            expanded: true,
            isEditing: false,
            onExpand: () {},
            onEnter: () {},
            onCreateChild: () {},
            onPrune: () {},
            onEdit: () {},
            onDescriptionChanged: (_) {},
            onDetailsChanged: (_) {},
            onDoneChanged: (_) {},
            onAddTag: (_) {},
            onRemoveTag: (_) {},
            onSetTagColor: (_, _) {},
            allTags: {},
            tagColors: {},
            allChildrenDone: true,
          ),
        ),
      ),
    );

    final checkboxFinder = find.byType(Checkbox);
    expect(checkboxFinder, findsOneWidget);

    final Checkbox checkbox = tester.widget(checkboxFinder);
    expect(checkbox.onChanged, isNotNull);
  });

  testWidgets(
    'Checkbox is enabled if node is already done, even if children are not done',
    (WidgetTester tester) async {
      final rootId = NodeId.random();
      final childId = NodeId.random();

      final nodes = {
        rootId: Node(
          id: rootId,
          description: NodeDescription(content: 'Root'),
          details: NodeDetails(content: ''),
          done: true,
          tags: IList([]),
          children: IList([childId]),
        ),
        childId: Node(
          id: childId,
          description: NodeDescription(content: 'Child'),
          details: NodeDetails(content: ''),
          done: false,
          tags: IList([]),
          children: IList([]),
        ),
      };

      Node nodeProvider(NodeId id) => nodes[id]!;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NodeView(
              nodeId: rootId,
              nodeProvider: nodeProvider,
              level: 0,
              levelPadding: 20,
              expanded: true,
              isEditing: false,
              onExpand: () {},
              onEnter: () {},
              onCreateChild: () {},
              onPrune: () {},
              onEdit: () {},
              onDescriptionChanged: (_) {},
              onDetailsChanged: (_) {},
              onDoneChanged: (_) {},
              onAddTag: (_) {},
              onRemoveTag: (_) {},
              onSetTagColor: (_, _) {},
              allTags: {},
              tagColors: {},
              allChildrenDone: false,
            ),
          ),
        ),
      );

      final checkboxFinder = find.byType(Checkbox);
      expect(checkboxFinder, findsOneWidget);

      final Checkbox checkbox = tester.widget(checkboxFinder);
      expect(checkbox.onChanged, isNotNull);
    },
  );
}
