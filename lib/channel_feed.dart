const channelTitle = 'Stickers 😀 🌹 Voot Book';

/// A source for the in-app channel. Implementations must have permission to
/// display the content they return.
abstract interface class ChannelFeed {
  Future<ChannelAvailability> checkAvailability();
}

enum ChannelAvailability { unavailable, connectionError }

final class UnsupportedChannelFeed implements ChannelFeed {
  const UnsupportedChannelFeed();

  @override
  Future<ChannelAvailability> checkAvailability() async {
    return ChannelAvailability.unavailable;
  }
}
