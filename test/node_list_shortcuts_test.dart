import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todotree/domain/element.dart';
import 'package:todotree/ui/node_view.dart';
import 'package:todotree/ui/palette.dart';

void main() {
  testWidgets('NodeList keyboard navigation (j/k)', (WidgetTester tester) async {
    final rootId = NodeId.fromString('root');
    final child1Id = NodeId.fromString('child1');
    final child2Id = NodeId.fromString('child2');

    final nodes = {
      rootId: Node(
        id: rootId,
        description: NodeDescription(content: 'Root'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([child1Id, child2Id]),
      ),
      child1Id: Node(
        id: child1Id,
        description: NodeDescription(content: 'Child 1'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([]),
      ),
      child2Id: Node(
        id: child2Id,
        description: NodeDescription(content: 'Child 2'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([]),
      ),
    };

    await tester.pumpWidget(
      MaterialApp(
        theme: Catppuccin.latteTheme,
        home: Scaffold(
          body: NodeList(
            nodes: nodes,
            treeRoot: rootId,
            onCreateNewAt: (_, {index}) {},
            onPrune: (_) {},
            onReparent: (_, __) {},
            onEdit: (_) {},
            onDescriptionChanged: (_, __) {},
            onDetailsChanged: (_, __) {},
            onDoneChanged: (_, __) {},
            showDone: true,
            onToggleShowDone: () {},
            onAddTag: (_, __) {},
            onRemoveTag: (_, __) {},
            onSetTagColor: (_, __) {},
            allTags: {},
            tagColors: {},
            nodesBeingEdited: {},
            allowMultipleEdits: false,
            onToggleMultiEdit: () {},
            themeMode: ThemeMode.light,
            onToggleTheme: () {},
          ),
        ),
      ),
    );

    // Initial state: Focus on first item (Child 1)
    final child1ViewWidget = tester.widget<NodeView>(find.byKey(ValueKey(child1Id)));
    child1ViewWidget.onFocus();
    await tester.pump();

    // Verify Child 1 is focused
    var child1View = tester.widget<NodeView>(find.byKey(ValueKey(child1Id)));
    expect(child1View.isFocused, isTrue);

    // Press 'j' -> Move down to Child 2
    await tester.sendKeyEvent(LogicalKeyboardKey.keyJ);
    await tester.pump();

    var child2View = tester.widget<NodeView>(find.byKey(ValueKey(child2Id)));
    expect(child2View.isFocused, isTrue);
    child1View = tester.widget<NodeView>(find.byKey(ValueKey(child1Id)));
    expect(child1View.isFocused, isFalse);

    // Press 'k' -> Move up to Child 1
    await tester.sendKeyEvent(LogicalKeyboardKey.keyK);
    await tester.pump();

    child1View = tester.widget<NodeView>(find.byKey(ValueKey(child1Id)));
    expect(child1View.isFocused, isTrue);
  });

  testWidgets('NodeList vim sequences (gg)', (WidgetTester tester) async {
    final rootId = NodeId.fromString('root');
    final child1Id = NodeId.fromString('child1');
    final child2Id = NodeId.fromString('child2');

    final nodes = {
      rootId: Node(
        id: rootId,
        description: NodeDescription(content: 'Root'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([child1Id, child2Id]),
      ),
      child1Id: Node(
        id: child1Id,
        description: NodeDescription(content: 'Child 1'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([]),
      ),
      child2Id: Node(
        id: child2Id,
        description: NodeDescription(content: 'Child 2'),
        details: NodeDetails(content: ''),
        done: false,
        tags: IList([]),
        children: IList([]),
      ),
    };

    await tester.pumpWidget(
      MaterialApp(
        theme: Catppuccin.latteTheme,
        home: Scaffold(
          body: NodeList(
            nodes: nodes,
            treeRoot: rootId,
            onCreateNewAt: (_, {index}) {},
            onPrune: (_) {},
            onReparent: (_, __) {},
            onEdit: (_) {},
            onDescriptionChanged: (_, __) {},
            onDetailsChanged: (_, __) {},
            onDoneChanged: (_, __) {},
            showDone: true,
            onToggleShowDone: () {},
            onAddTag: (_, __) {},
            onRemoveTag: (_, __) {},
            onSetTagColor: (_, __) {},
            allTags: {},
            tagColors: {},
            nodesBeingEdited: {},
            allowMultipleEdits: false,
            onToggleMultiEdit: () {},
            themeMode: ThemeMode.light,
            onToggleTheme: () {},
          ),
        ),
      ),
    );

    // Focus Child 2
    final child2ViewWidget = tester.widget<NodeView>(find.byKey(ValueKey(child2Id)));
    child2ViewWidget.onFocus();
    await tester.pump();
    expect(tester.widget<NodeView>(find.byKey(ValueKey(child2Id))).isFocused, isTrue);

    // Type 'gg' -> Move to top (Child 1)
    await tester.sendKeyEvent(LogicalKeyboardKey.keyG);
    await tester.pump(); 
    // Need to send second key within 1 second.
    await tester.sendKeyEvent(LogicalKeyboardKey.keyG);
    await tester.pumpAndSettle();

    expect(tester.widget<NodeView>(find.byKey(ValueKey(child1Id))).isFocused, isTrue);
  });
}
