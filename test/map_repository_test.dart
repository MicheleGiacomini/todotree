import 'package:flutter_test/flutter_test.dart';
import 'package:todotree/domain/element.dart';
import 'package:todotree/storage/in_memory_repository.dart';

void main() {
  late InMemoryRepository repository;
  late NodeId rootId;

  setUp(() async {
    repository = InMemoryRepository();
    rootId = await repository.getRootId();
  });

  test('Cannot mark done if children are not done', () async {
    await repository.createNewAt(rootId);

    // Try to mark root as done while child is not done
    expect(
      () => repository.updateDone(rootId, true),
      throwsA(isA<Exception>()),
    );
  });

  test('Can mark done if all children are done', () async {
    final result = await repository.createNewAt(rootId);
    final childId = result.newChild.id;

    // Mark child as done
    await repository.updateDone(childId, true);

    // Now root can be marked as done
    final updatedNodes = await repository.updateDone(rootId, true);
    expect(updatedNodes[rootId]!.done, isTrue);
  });

  test('Unmarking a child as todo unmarks all parents', () async {
    // Structure: root -> child -> grandchild
    final res1 = await repository.createNewAt(rootId);
    final childId = res1.newChild.id;
    final res2 = await repository.createNewAt(childId);
    final grandchildId = res2.newChild.id;

    // Mark all as done
    await repository.updateDone(grandchildId, true);
    await repository.updateDone(childId, true);
    await repository.updateDone(rootId, true);

    // Verify they are done
    final elements = await repository.getElements();
    expect(elements[rootId]!.done, isTrue);
    expect(elements[childId]!.done, isTrue);
    expect(elements[grandchildId]!.done, isTrue);

    // Unmark grandchild
    final updatedNodes = await repository.updateDone(grandchildId, false);

    // Verify all parents are unmarked
    expect(updatedNodes[grandchildId]!.done, isFalse);
    expect(updatedNodes[childId]!.done, isFalse);
    expect(updatedNodes[rootId]!.done, isFalse);

    final finalElements = await repository.getElements();
    expect(finalElements[rootId]!.done, isFalse);
    expect(finalElements[childId]!.done, isFalse);
    expect(finalElements[grandchildId]!.done, isFalse);
  });

  test('createNewAt with index inserts at correct position', () async {
    // Create 3 children: A, B, C
    final resA = await repository.createNewAt(rootId);
    final idA = resA.newChild.id;
    await repository.updateDesription(idA, NodeDescription(content: 'A'));

    final resB = await repository.createNewAt(rootId);
    final idB = resB.newChild.id;
    await repository.updateDesription(idB, NodeDescription(content: 'B'));

    final resC = await repository.createNewAt(rootId);
    final idC = resC.newChild.id;
    await repository.updateDesription(idC, NodeDescription(content: 'C'));

    // Verify initial order: A, B, C
    var elements = await repository.getElements();
    var root = elements[rootId]!;
    expect(root.children[0], equals(idA));
    expect(root.children[1], equals(idB));
    expect(root.children[2], equals(idC));

    // Insert D at index 0 (Before A)
    final resD = await repository.createNewAt(rootId, index: 0);
    final idD = resD.newChild.id;
    await repository.updateDesription(idD, NodeDescription(content: 'D'));

    // Verify order: D, A, B, C
    elements = await repository.getElements();
    root = elements[rootId]!;
    expect(root.children[0], equals(idD));
    expect(root.children[1], equals(idA));
    expect(root.children[2], equals(idB));
    expect(root.children[3], equals(idC));

    // Insert E at index 2 (Between A and B)
    // Current indices: D(0), A(1), B(2), C(3)
    // Insert E at 2 -> D, A, E, B, C
    final resE = await repository.createNewAt(rootId, index: 2);
    final idE = resE.newChild.id;
    await repository.updateDesription(idE, NodeDescription(content: 'E'));

    elements = await repository.getElements();
    root = elements[rootId]!;
    expect(root.children[0], equals(idD));
    expect(root.children[1], equals(idA));
    expect(root.children[2], equals(idE));
    expect(root.children[3], equals(idB));
    expect(root.children[4], equals(idC));
    
    // Insert F at end (index 5 or null)
    final resF = await repository.createNewAt(rootId); // Default (append)
    final idF = resF.newChild.id;
    
    elements = await repository.getElements();
    root = elements[rootId]!;
    expect(root.children.last, equals(idF));
  });
}
