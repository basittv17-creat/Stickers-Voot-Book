import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stickers_voot_book/channel_feed.dart';
import 'package:stickers_voot_book/main.dart';

void main() {
  testWidgets('launches directly to the Unicode channel in one route', (
    tester,
  ) async {
    await tester.pumpWidget(const StickersApp());
    await tester.pumpAndSettle();

    expect(find.text(channelTitle), findsOneWidget);
    expect(find.text('Channel preview unavailable'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(ChannelScreen))).canPop(),
      isFalse,
    );
  });

  testWidgets('preserves the title in an RTL channel layout', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: ChannelScreen(feed: UnsupportedChannelFeed()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final title = tester.element(find.text(channelTitle));
    expect(Directionality.of(title), TextDirection.rtl);
    expect(find.text('Channel preview unavailable'), findsOneWidget);
  });

  testWidgets('shows progress, a recoverable error, and retry', (tester) async {
    final feed = ControlledFeed();
    await tester.pumpWidget(StickersApp(feed: feed));

    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    feed.requests.single.completeError(Exception('network unavailable'));
    await tester.pumpAndSettle();
    expect(find.text('Couldn’t check the preview'), findsOneWidget);

    await tester.tap(find.text('Try again'));
    await tester.pump();
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(feed.requests, hasLength(2));

    feed.requests.last.complete(ChannelAvailability.unavailable);
    await tester.pumpAndSettle();
    expect(find.text('Channel preview unavailable'), findsOneWidget);
  });

  testWidgets('pull to refresh and the toolbar stay on the channel', (
    tester,
  ) async {
    final feed = ControlledFeed();
    await tester.pumpWidget(StickersApp(feed: feed));
    feed.requests.single.complete(ChannelAvailability.unavailable);
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, 300));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(feed.requests, hasLength(2));

    feed.requests.last.complete(ChannelAvailability.unavailable);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Refresh channel preview'));
    await tester.pump();
    expect(feed.requests, hasLength(3));

    feed.requests.last.complete(ChannelAvailability.unavailable);
    await tester.pumpAndSettle();
    expect(find.text(channelTitle), findsOneWidget);
  });
}

class ControlledFeed implements ChannelFeed {
  final requests = <Completer<ChannelAvailability>>[];

  @override
  Future<ChannelAvailability> checkAvailability() {
    final request = Completer<ChannelAvailability>();
    requests.add(request);
    return request.future;
  }
}
