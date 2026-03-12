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
}
