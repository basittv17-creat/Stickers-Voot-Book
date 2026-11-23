# Architecture

The Android launcher starts `MainActivity` in the standard Flutter embedding. `StickersApp` opens a single dark Material channel screen. The screen checks its injected `ChannelFeed` on launch and supports retry, toolbar refresh and pull-to-refresh. Concurrent refresh requests share one pending check. An unavailable result or an exception gets its own visible state with a screen-reader announcement.

`UnsupportedChannelFeed` is the bundled adapter. It answers locally, so the current app works offline and has no Android Internet permission, credential handling, WebView, or external-launch code. The manifest disables backup and cleartext traffic.

A future authorized implementation can use the `ChannelFeed` boundary. Add pageable items only when an approved contract is known, keeping stable post IDs, chronological ordering, media rights, cursor expiry and cache retention explicit. A successfully tested public WebView would be a separate experimental surface with an exact main-frame HTTPS allowlist, no privileged JS bridge or external intents, and explicit loading and error states. Its presence would establish only the behavior reproduced on Android.
