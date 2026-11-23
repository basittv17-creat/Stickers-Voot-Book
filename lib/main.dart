import 'package:material_ui/material_ui.dart';

import 'channel_feed.dart';

void main() => runApp(const StickersApp());

class StickersApp extends StatelessWidget {
  const StickersApp({super.key, this.feed = const UnsupportedChannelFeed()});

  final ChannelFeed feed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stickers Voot Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffe89ba9),
          brightness: Brightness.dark,
          surface: const Color(0xff151318),
        ),
      ),
      home: ChannelScreen(feed: feed),
    );
  }
}

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key, required this.feed});

  final ChannelFeed feed;

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  static const _availabilityTimeout = Duration(seconds: 10);

  ChannelAvailability? _availability;
  Future<void>? _pending;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() => _pending ??= _checkAvailability();

  Future<void> _checkAvailability() async {
    setState(() => _availability = null);
    ChannelAvailability result;
    try {
      result = await Future.sync(widget.feed.checkAvailability)
          .timeout(_availabilityTimeout);
    } on Exception {
      result = ChannelAvailability.connectionError;
    } finally {
      _pending = null;
    }
    if (mounted) {
      setState(() => _availability = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final availability = _availability;
    final (heading, description, icon) = switch (availability) {
      null => ('Checking preview', '', Icons.hourglass_empty_rounded),
      ChannelAvailability.unavailable => (
        'Channel preview unavailable',
        'This app currently has no source for channel posts or stickers.',
        Icons.layers_outlined,
      ),
      ChannelAvailability.connectionError => (
        'Couldn’t check the preview',
        'Check your connection and try again.',
        Icons.cloud_off_outlined,
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(channelTitle, maxLines: 1),
        actions: [
          IconButton(
            tooltip: 'Refresh channel preview',
            onPressed: availability == null ? null : _refresh,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: colors.surfaceContainerLow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: colors.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: colors.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Icon(
                                icon,
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Semantics(
                            header: true,
                            liveRegion: true,
                            child: Text(
                              heading,
                              style: theme.textTheme.headlineSmall,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (availability == null)
                            const LinearProgressIndicator(
                              semanticsLabel: 'Checking preview availability',
                            )
                          else ...[
                            Text(
                              description,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 20),
                            OutlinedButton.icon(
                              onPressed: _refresh,
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Try again'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
