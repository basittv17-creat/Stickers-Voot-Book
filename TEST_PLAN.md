# Test plan

Run the source checks in the README. CI additionally invokes `:app:help` to exercise Gradle project configuration without packaging. The unit test checks the bundled adapter. Widget tests exercise Unicode, startup, loading, failure, retry, pull-to-refresh and the single-route UI. There is no URL allowlist to exercise in the current app because it does not open URLs.

Once an Android installation is separately approved, run the smoke test in `integration_test/channel_app_test.dart` on the target device. Device execution installs an app and is therefore outside the no-APK source phase.

For preview feasibility, use a signed-out Android Chrome session and record the device, Android/Chrome/WebView versions and UTC observation time. Open the exact channel URL. Record the visible page, final URL and any handoff. If posts are visible, test scroll, media rendering, refresh, and repeat with a newly published update. Repeat in an approved Android WebView harness with external navigation disabled. Verify Android back, offline/reconnect, rotation, TalkBack, large text, and RTL. Record whether the same content is visible on each surface and which behavior depends on a WhatsApp session.
