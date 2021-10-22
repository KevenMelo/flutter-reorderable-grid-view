import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/reorderable_type.dart';
import 'package:flutter_reorderable_grid_view/widgets/animated_draggable_item.dart';
import 'package:flutter_reorderable_grid_view/widgets/draggable_item.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'GIVEN reorderableType = wrap '
      'WHEN pumping [Reorderable] '
      'THEN should show expected widgets and have default values',
      (WidgetTester tester) async {
    // given
    const givenChildren = <Widget>[
      Text('hallo1'),
      Text('hallo2'),
      Text('hallo3'),
      Text('hallo4'),
    ];

    // when
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            onReorder: (_, __) {},
          ),
        ),
      ),
    );

    // then
    const expectedSpacing = 8;
    const expectedRunSpacing = 8;

    expect(find.byWidget(givenChildren[0]), findsOneWidget);
    expect(find.byWidget(givenChildren[1]), findsOneWidget);
    expect(find.byWidget(givenChildren[2]), findsOneWidget);
    expect(find.byWidget(givenChildren[3]), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is Reorderable &&
            widget.enableLongPress &&
            widget.enableAnimation &&
            widget.spacing == expectedSpacing &&
            widget.runSpacing == expectedRunSpacing &&
            widget.lockedChildren.isEmpty &&
            widget.gridDelegate ==
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ) &&
            widget.reorderableType == ReorderableType.wrap &&
            widget.physics == null &&
            widget.crossAxisCount == null &&
            widget.maxCrossAxisExtent == 0.0 &&
            widget.mainAxisSpacing == 0 &&
            widget.crossAxisSpacing == 0.0),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is DraggableItem && widget.enableLongPress),
        findsNWidgets(givenChildren.length));

    expect(
        find.byWidgetPredicate((widget) =>
            widget is Wrap &&
            widget.runSpacing == expectedRunSpacing &&
            widget.spacing == expectedSpacing),
        findsOneWidget);
  });

  testWidgets(
      'GIVEN reorderableType = gridView '
      'WHEN pumping [Reorderable] '
      'THEN should show expected widgets and have default values',
      (WidgetTester tester) async {
    // given
    const givenChildren = <Widget>[
      Text('hallo1'),
      Text('hallo2'),
    ];
    const givenGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
    );
    const givenPadding = EdgeInsets.all(20);
    const givenClipBehavior = Clip.antiAliasWithSaveLayer;

    // when
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.gridView,
            gridDelegate: givenGridDelegate,
            onReorder: (_, __) {},
            clipBehavior: givenClipBehavior,
            padding: givenPadding,
          ),
        ),
      ),
    );

    // then
    expect(find.byWidget(givenChildren[0]), findsOneWidget);
    expect(find.byWidget(givenChildren[1]), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is GridView &&
            widget.gridDelegate == givenGridDelegate &&
            widget.shrinkWrap &&
            widget.padding == givenPadding &&
            widget.clipBehavior == givenClipBehavior),
        findsOneWidget);
  });

  testWidgets(
      'GIVEN reorderableType = gridViewCount '
      'WHEN pumping [Reorderable] '
      'THEN should show expected widgets and have default values',
      (WidgetTester tester) async {
    // given
    const givenChildren = <Widget>[
      Text('hallo1'),
      Text('hallo2'),
    ];
    const givenCrossAxisCount = 3;
    const givenMainAxisSpacing = 20.0;
    const givenPhysics = AlwaysScrollableScrollPhysics();
    const givenPadding = EdgeInsets.all(10);
    const givenClipBehavior = Clip.antiAliasWithSaveLayer;

    // when
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.gridViewCount,
            crossAxisCount: givenCrossAxisCount,
            mainAxisSpacing: givenMainAxisSpacing,
            physics: givenPhysics,
            onReorder: (_, __) {},
            padding: givenPadding,
            clipBehavior: givenClipBehavior,
          ),
        ),
      ),
    );

    // then
    expect(find.byWidget(givenChildren[0]), findsOneWidget);
    expect(find.byWidget(givenChildren[1]), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is GridView &&
            widget.shrinkWrap &&
            widget.physics == givenPhysics &&
            (widget.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount)
                    .crossAxisCount ==
                givenCrossAxisCount &&
            (widget.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount)
                    .mainAxisSpacing ==
                givenMainAxisSpacing &&
            widget.clipBehavior == givenClipBehavior &&
            widget.padding == givenPadding),
        findsOneWidget);
  });

  testWidgets(
      'GIVEN reorderableType = gridViewExtent '
      'WHEN pumping [Reorderable] '
      'THEN should show expected widgets and have default values',
      (WidgetTester tester) async {
    // given
    const givenChildren = <Widget>[
      Text('hallo1'),
      Text('hallo2'),
    ];
    const givenMaxCrossAxisExtent = 100.0;
    const givenClipBehavior = Clip.none;
    const givenMainAxisSpacing = 12.0;
    const givenCrossAxisSpacing = 13.0;
    const givenChildAspectRatio = 3.5;
    const givenPadding = EdgeInsets.all(25);

    // when
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.gridViewExtent,
            maxCrossAxisExtent: givenMaxCrossAxisExtent,
            clipBehavior: givenClipBehavior,
            mainAxisSpacing: givenMainAxisSpacing,
            crossAxisSpacing: givenCrossAxisSpacing,
            onReorder: (_, __) {},
            childAspectRatio: givenChildAspectRatio,
            padding: givenPadding,
          ),
        ),
      ),
    );

    // then
    expect(find.byWidget(givenChildren[0]), findsOneWidget);
    expect(find.byWidget(givenChildren[1]), findsOneWidget);

    expect(find.byWidgetPredicate((widget) {
      if (widget is GridView &&
          widget.shrinkWrap &&
          widget.clipBehavior == givenClipBehavior &&
          widget.padding == givenPadding) {
        final delegate =
            widget.gridDelegate as SliverGridDelegateWithMaxCrossAxisExtent;
        if (delegate.maxCrossAxisExtent == givenMaxCrossAxisExtent &&
            delegate.mainAxisSpacing == givenMainAxisSpacing &&
            delegate.crossAxisSpacing == givenCrossAxisSpacing &&
            delegate.childAspectRatio == givenChildAspectRatio) {
          return true;
        }
      }
      return false;
    }), findsOneWidget);
  });

  testWidgets(
      'GIVEN children, enableLongPress = false, spacing = 24.0, '
      'longPressDelay = 5s, runSpacing 20.0 and lockedChildren = [0, 1]'
      'WHEN pumping [Reorderable] '
      'THEN should show expected widgets and have default values',
      (WidgetTester tester) async {
    // given
    const givenChildren = <Widget>[
      Text('hallo1'),
      Text('hallo2'),
      Text('hallo3'),
      Text('hallo4'),
    ];
    const givenRunSpacing = 20.0;
    const givenSpacing = 24.0;
    const givenLongPressDelay = Duration(days: 10);
    const givenLockedChildren = [0, 1];

    // when
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            enableLongPress: false,
            enableAnimation: false,
            runSpacing: givenRunSpacing,
            spacing: givenSpacing,
            longPressDelay: givenLongPressDelay,
            lockedChildren: givenLockedChildren,
            onReorder: (_, __) {},
          ),
        ),
      ),
    );

    // then
    expect(find.byWidget(givenChildren[0]), findsOneWidget);
    expect(find.byWidget(givenChildren[1]), findsOneWidget);
    expect(find.byWidget(givenChildren[2]), findsOneWidget);
    expect(find.byWidget(givenChildren[3]), findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => widget is DraggableItem && !widget.enableLongPress),
        findsNWidgets(givenChildren.length));

    expect(
        find.byWidgetPredicate((widget) =>
            widget is Reorderable &&
            !widget.enableLongPress &&
            !widget.enableAnimation &&
            widget.spacing == givenSpacing &&
            widget.runSpacing == givenRunSpacing &&
            widget.longPressDelay == givenLongPressDelay &&
            widget.lockedChildren == givenLockedChildren),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is Wrap &&
            widget.runSpacing == givenRunSpacing &&
            widget.spacing == givenSpacing),
        findsOneWidget);
  });

  testWidgets(
      'GIVEN children and fully added children to idMap and orderIdMap '
      'WHEN pumping [Reorderable] finished '
      'THEN should show expected widgets and have default values',
      (WidgetTester tester) async {
    // given
    const givenChildren = <Widget>[
      Text('hallo1'),
      Text('hallo2'),
      Text('hallo3'),
      Text('hallo4'),
    ];
    const givenRunSpacing = 20.0;
    const givenSpacing = 24.0;

    // when
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            enableLongPress: false,
            enableAnimation: false,
            runSpacing: givenRunSpacing,
            spacing: givenSpacing,
            onReorder: (_, __) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // then
    expect(find.byWidget(givenChildren[0]), findsOneWidget);
    expect(find.byWidget(givenChildren[1]), findsOneWidget);
    expect(find.byWidget(givenChildren[2]), findsOneWidget);
    expect(find.byWidget(givenChildren[3]), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            widget is AnimatedDraggableItem &&
            !widget.enableLongPress &&
            !widget.enableAnimation),
        findsNWidgets(givenChildren.length));
    expect(
        find.byWidgetPredicate((widget) =>
            widget is AnimatedDraggableItem && widget.key == const Key('0')),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is AnimatedDraggableItem && widget.key == const Key('1')),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is AnimatedDraggableItem && widget.key == const Key('2')),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is AnimatedDraggableItem && widget.key == const Key('3')),
        findsOneWidget);

    expect(find.byType(Wrap), findsNothing);
  });

  testWidgets(
      'GIVEN pumped [Reorderable] with enableLongPress = false '
      'WHEN dragging text1 to text2 without releasing drag '
      'THEN should swap position between text1 and text2',
      (WidgetTester tester) async {
    // given
    const givenText1 = 'hallo1';
    const givenText2 = 'hallo2';
    const givenText3 = 'hallo3';
    const givenText4 = 'hallo4';

    const givenChildren = <Widget>[
      Text(givenText1),
      Text(givenText2),
      Text(givenText3),
      Text(givenText4),
    ];

    late int actualOldIndex;
    late int actualNewIndex;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            enableLongPress: false,
            onReorder: (oldIndex, newIndex) {
              actualOldIndex = oldIndex;
              actualNewIndex = newIndex;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // when
    // start dragging
    final firstLocation = tester.getCenter(find.text(givenText1));
    final gesture = await tester.startGesture(
      firstLocation,
      pointer: 7,
    );
    await tester.pump();

    // move dragged object
    final secondLocation = tester.getCenter(find.text(givenText2));
    await gesture.moveTo(secondLocation);
    await tester.pump();
    await tester.pumpAndSettle();

    // then
    expect(tester.getCenter(find.text(givenText1)), equals(secondLocation));
    expect(tester.getCenter(find.text(givenText2)), equals(firstLocation));

    expect(actualOldIndex, equals(0));
    expect(actualNewIndex, equals(1));
  });

  testWidgets(
      'GIVEN pumped [Reorderable] with enableLongPress = false '
      'WHEN dragging text1 to text4 without releasing drag '
      'THEN should change swap position of all given texts',
      (WidgetTester tester) async {
    // given
    const givenText1 = 'hallo1';
    const givenText2 = 'hallo2';
    const givenText3 = 'hallo3';
    const givenText4 = 'hallo4';

    const givenChildren = <Widget>[
      Text(givenText1),
      Text(givenText2),
      Text(givenText3),
      Text(givenText4),
    ];

    List<int> actualOldIndexList = <int>[];
    List<int> actualNewIndexList = <int>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            enableLongPress: false,
            onReorder: (oldIndex, newIndex) {
              actualOldIndexList.add(oldIndex);
              actualNewIndexList.add(newIndex);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // when
    // start dragging
    final givenText1StartLocation = tester.getCenter(find.text(givenText1));
    final givenText2StartLocation = tester.getCenter(find.text(givenText2));
    final givenText3StartLocation = tester.getCenter(find.text(givenText3));
    final givenText4StartLocation = tester.getCenter(find.text(givenText4));

    final gesture = await tester.startGesture(
      givenText1StartLocation,
      pointer: 7,
    );
    await tester.pump();

    // move dragged object
    await gesture.moveTo(givenText4StartLocation);
    await tester.pumpAndSettle();

    // then
    final givenText1EndLocation = tester.getCenter(find.text(givenText1));
    final givenText2EndLocation = tester.getCenter(find.text(givenText2));
    final givenText3EndLocation = tester.getCenter(find.text(givenText3));
    final givenText4EndLocation = tester.getCenter(find.text(givenText4));

    expect(givenText1EndLocation, equals(givenText4StartLocation));
    expect(givenText2EndLocation, equals(givenText1StartLocation));
    expect(givenText3EndLocation, equals(givenText2StartLocation));
    expect(givenText4EndLocation, equals(givenText3StartLocation));

    expect(actualOldIndexList, equals([0, 1, 2]));
    expect(actualNewIndexList, equals([1, 2, 3]));
  });

  testWidgets(
      'GIVEN pumped [Reorderable] with enableLongPress = false '
      'WHEN dragging text4 to text2 without releasing drag '
      'THEN should change swap position of all given texts',
      (WidgetTester tester) async {
    // given
    const givenText1 = 'hallo1';
    const givenText2 = 'hallo2';
    const givenText3 = 'hallo3';
    const givenText4 = 'hallo4';

    const givenChildren = <Widget>[
      Text(givenText1),
      Text(givenText2),
      Text(givenText3),
      Text(givenText4),
    ];

    List<int> actualOldIndexList = <int>[];
    List<int> actualNewIndexList = <int>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            enableLongPress: false,
            onReorder: (oldIndex, newIndex) {
              actualOldIndexList.add(oldIndex);
              actualNewIndexList.add(newIndex);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // when
    // start dragging
    final givenText1StartLocation = tester.getCenter(find.text(givenText1));
    final givenText2StartLocation = tester.getCenter(find.text(givenText2));
    final givenText3StartLocation = tester.getCenter(find.text(givenText3));
    final givenText4StartLocation = tester.getCenter(find.text(givenText4));

    final gesture = await tester.startGesture(
      givenText4StartLocation,
      pointer: 7,
    );
    await tester.pump();

    // move dragged object
    await gesture.moveTo(givenText2StartLocation);
    await tester.pumpAndSettle();

    // then
    final givenText1EndLocation = tester.getCenter(find.text(givenText1));
    final givenText2EndLocation = tester.getCenter(find.text(givenText2));
    final givenText3EndLocation = tester.getCenter(find.text(givenText3));
    final givenText4EndLocation = tester.getCenter(find.text(givenText4));

    expect(givenText1EndLocation, equals(givenText1StartLocation));
    expect(givenText2EndLocation, equals(givenText3StartLocation));
    expect(givenText3EndLocation, equals(givenText4StartLocation));
    expect(givenText4EndLocation, equals(givenText2StartLocation));

    expect(actualOldIndexList, equals([3, 2]));
    expect(actualNewIndexList, equals([2, 1]));
  });

  testWidgets(
      'GIVEN pumped [Reorderable] with enableLongPress = false and '
      'lockedChildren containing text2 index '
      'WHEN dragging text1 to text2 without releasing drag '
      'THEN should not swap position between text1 and text2',
      (WidgetTester tester) async {
    // given
    const givenText1 = 'hallo1';
    const givenText2 = 'hallo2';
    const givenText3 = 'hallo3';
    const givenText4 = 'hallo4';

    const givenChildren = <Widget>[
      Text(givenText1),
      Text(givenText2),
      Text(givenText3),
      Text(givenText4),
    ];

    List<int> actualOldIndexList = <int>[];
    List<int> actualNewIndexList = <int>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            lockedChildren: const [1],
            enableLongPress: false,
            onReorder: (oldIndex, newIndex) {
              actualOldIndexList.add(oldIndex);
              actualNewIndexList.add(newIndex);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // when
    // start dragging
    final firstLocation = tester.getCenter(find.text(givenText1));
    final gesture = await tester.startGesture(
      firstLocation,
      pointer: 7,
    );
    await tester.pump();

    // move dragged object and release
    final secondLocation = tester.getCenter(find.text(givenText2));
    await gesture.moveTo(secondLocation);
    await gesture.up();
    await tester.pumpAndSettle();

    // then
    expect(tester.getCenter(find.text(givenText1)), equals(firstLocation));
    expect(tester.getCenter(find.text(givenText2)), equals(secondLocation));

    // because item is locked, the var should still be null
    expect(actualOldIndexList, isEmpty);
    expect(actualNewIndexList, isEmpty);
  });

  testWidgets(
      'GIVEN pumped [Reorderable] with enableLongPress = false and'
      'text2 index is in lockedChildren '
      'WHEN dragging text1 to text4 without releasing drag '
      'THEN should change swap position of all given texts but text2',
      (WidgetTester tester) async {
    // given
    const givenText1 = 'hallo1';
    const givenText2 = 'hallo2';
    const givenText3 = 'hallo3';
    const givenText4 = 'hallo4';

    const givenChildren = <Widget>[
      Text(givenText1),
      Text(givenText2),
      Text(givenText3),
      Text(givenText4),
    ];

    List<int> actualOldIndexList = <int>[];
    List<int> actualNewIndexList = <int>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            enableLongPress: false,
            lockedChildren: const [1],
            onReorder: (oldIndex, newIndex) {
              actualOldIndexList.add(oldIndex);
              actualNewIndexList.add(newIndex);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // when
    // start dragging
    final givenText1StartLocation = tester.getCenter(find.text(givenText1));
    final givenText2StartLocation = tester.getCenter(find.text(givenText2));
    final givenText3StartLocation = tester.getCenter(find.text(givenText3));
    final givenText4StartLocation = tester.getCenter(find.text(givenText4));

    final gesture = await tester.startGesture(
      givenText1StartLocation,
      pointer: 7,
    );
    await tester.pump();

    // move dragged object
    await gesture.moveTo(givenText4StartLocation);
    await tester.pumpAndSettle();

    // then
    final givenText1EndLocation = tester.getCenter(find.text(givenText1));
    final givenText2EndLocation = tester.getCenter(find.text(givenText2));
    final givenText3EndLocation = tester.getCenter(find.text(givenText3));
    final givenText4EndLocation = tester.getCenter(find.text(givenText4));

    expect(givenText1EndLocation, equals(givenText4StartLocation));
    expect(givenText2EndLocation, equals(givenText2StartLocation));
    expect(givenText3EndLocation, equals(givenText1StartLocation));
    expect(givenText4EndLocation, equals(givenText3StartLocation));

    expect(actualOldIndexList, equals([0, 2]));
    expect(actualNewIndexList, equals([2, 3]));
  });

  testWidgets(
      'GIVEN pumped [Reorderable] with enableLongPress = false and '
      'text1 and text3 are locked '
      'WHEN dragging text4 to text2 without releasing drag '
      'THEN should swap only position of text4 and text2',
      (WidgetTester tester) async {
    // given
    const givenText1 = 'hallo1';
    const givenText2 = 'hallo2';
    const givenText3 = 'hallo3';
    const givenText4 = 'hallo4';

    const givenChildren = <Widget>[
      Text(givenText1),
      Text(givenText2),
      Text(givenText3),
      Text(givenText4),
    ];

    List<int> actualOldIndexList = <int>[];
    List<int> actualNewIndexList = <int>[];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            enableLongPress: false,
            lockedChildren: const [0, 2],
            onReorder: (oldIndex, newIndex) {
              actualOldIndexList.add(oldIndex);
              actualNewIndexList.add(newIndex);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // when
    // start dragging
    final givenText1StartLocation = tester.getCenter(find.text(givenText1));
    final givenText2StartLocation = tester.getCenter(find.text(givenText2));
    final givenText3StartLocation = tester.getCenter(find.text(givenText3));
    final givenText4StartLocation = tester.getCenter(find.text(givenText4));

    final gesture = await tester.startGesture(
      givenText4StartLocation,
      pointer: 7,
    );
    await tester.pump();

    // move dragged object
    await gesture.moveTo(givenText2StartLocation);
    await tester.pumpAndSettle();

    // then
    final givenText1EndLocation = tester.getCenter(find.text(givenText1));
    final givenText2EndLocation = tester.getCenter(find.text(givenText2));
    final givenText3EndLocation = tester.getCenter(find.text(givenText3));
    final givenText4EndLocation = tester.getCenter(find.text(givenText4));

    expect(givenText1EndLocation, equals(givenText1StartLocation));
    expect(givenText2EndLocation, equals(givenText4StartLocation));
    expect(givenText3EndLocation, equals(givenText3StartLocation));
    expect(givenText4EndLocation, equals(givenText2StartLocation));

    expect(actualOldIndexList, equals([3]));
    expect(actualNewIndexList, equals([1]));
  });

  testWidgets(
      'GIVEN [Reorderable] with functionality to add new child '
      'WHEN tapping add new child button '
      'THEN should update [Reorderable] with new child',
      (WidgetTester tester) async {
    // given
    const givenNewText = 'hi im new';

    await tester.pumpWidget(
      const MaterialApp(
        home: _TestAddOrUpdateChildWidget(
          newText: givenNewText,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // when
    await tester.tap(find.text('add child'));
    await tester.pumpAndSettle();

    // then
    expect(find.text(givenNewText), findsOneWidget);
  });

  testWidgets(
      'GIVEN [Reorderable] with functionality to update current child '
      'WHEN tapping update child button '
      'THEN should update [Reorderable] with updated child',
      (WidgetTester tester) async {
    // given
    const givenUpdatedText = 'its me an update!';

    await tester.pumpWidget(
      const MaterialApp(
        home: _TestAddOrUpdateChildWidget(
          updatedText: givenUpdatedText,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // when
    await tester.tap(find.text('update child'));
    await tester.pumpAndSettle();

    // then
    expect(find.text(givenUpdatedText), findsOneWidget);
  });

  testWidgets(
      'GIVEN [Reorderable] with enableLongPress = false and 4 texts '
      'WHEN changing orientation '
      'THEN should still display all texts', (WidgetTester tester) async {
    // given
    // rotate to portrait
    tester.binding.window.physicalSizeTestValue = const Size(400, 1600);
    tester.binding.window.devicePixelRatioTestValue = 1;

    const givenText1 = 'hallo1';
    const givenText2 = 'hallo2';
    const givenText3 = 'hallo3';
    const givenText4 = 'hallo4';

    const givenChildren = <Widget>[
      Text(givenText1),
      Text(givenText2),
      Text(givenText3),
      Text(givenText4),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Reorderable(
            children: givenChildren,
            reorderableType: ReorderableType.wrap,
            enableLongPress: false,
            onReorder: (_, __) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // when
    // rotate to landscape
    tester.binding.window.physicalSizeTestValue = const Size(1600, 400);
    tester.binding.window.devicePixelRatioTestValue = 1;

    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    // then
    expect(find.text(givenText1), findsOneWidget);
    expect(find.text(givenText2), findsOneWidget);
    expect(find.text(givenText3), findsOneWidget);
    expect(find.text(givenText4), findsOneWidget);
  });
}

class _TestAddOrUpdateChildWidget extends StatefulWidget {
  final String? newText;
  final String? updatedText;

  const _TestAddOrUpdateChildWidget({
    this.newText,
    this.updatedText,
    Key? key,
  }) : super(key: key);

  @override
  State<_TestAddOrUpdateChildWidget> createState() =>
      _TestAddOrUpdateChildWidgetState();
}

class _TestAddOrUpdateChildWidgetState
    extends State<_TestAddOrUpdateChildWidget> {
  List<String> children = <String>['test'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                children.add(widget.newText!);
              });
            },
            child: const Text('add child'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                children[0] = widget.updatedText!;
              });
            },
            child: const Text('update child'),
          ),
          Reorderable(
            children: children.map((e) => Text(e)).toList(),
            reorderableType: ReorderableType.wrap,
            enableLongPress: false,
            onReorder: (_, __) {},
          ),
        ],
      ),
    );
  }
}