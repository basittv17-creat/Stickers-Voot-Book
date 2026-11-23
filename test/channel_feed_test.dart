import 'package:flutter_test/flutter_test.dart';
import 'package:stickers_voot_book/channel_feed.dart';

void main() {
  test('the default source consistently reports unavailable', () async {
    const feed = UnsupportedChannelFeed();

    expect(await feed.checkAvailability(), ChannelAvailability.unavailable);
    expect(await feed.checkAvailability(), ChannelAvailability.unavailable);
  });
}
