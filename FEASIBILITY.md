# WhatsApp Channel feasibility

Reviewed 23 November 2026. The repository initially had no refs, source or CI. The source phase delivers the channel shell and honest unavailable state while device evidence and production access remain open.

Channel under test: [Stickers 😀 🌹 Voot Book](https://whatsapp.com/channel/0029VbDZYJJAzNbwud92cP0Q).

| Check | Observation | Remaining evidence |
| --- | --- | --- |
| Public URL via web retrieval | Retrieval returned inaccessible in the research tool. | Signed-out Android Chrome observation of the actual page. |
| Public URL in hosted Chrome | Opening the HTTPS URL was rejected by the browser URL policy, which reported an unsupported protocol. No visible page was inspected. | Record final URL, landing or posts, media, scrolling, refresh and any handoff on signed-out Android Chrome. |
| Android System WebView | No device session or app packaging was available in this source phase. | Reproduce the same checks in a permitted test harness after approval. |
| Business Platform | Official documentation covers business-number messaging and related webhooks. No documented production WhatsApp Channel read feed was identified. | An authorized production contract covering channel updates, media and redistribution. |
| Meta Content Library | Meta documents channel/update data in approved research cleanrooms. Its update documentation lists a 30-day window. | Research access cannot establish a distribution contract for this app. |
| Automatic synchronization | No eligible production feed or verified on-device preview was established. | Demonstrate a newly published WhatsApp-only update appearing in app via an authorized source. |

The browser result does not establish what Android Chrome or WebView will display, whether WhatsApp initiates a handoff, or whether posts and stickers will render. Even a working public preview would not establish complete history or an automatic synchronization interface. The current app displays its local unavailable state and makes no content requests.

Sources: [WhatsApp Terms, Acceptable Use](https://www.whatsapp.com/legal/terms-of-service), [WhatsApp Business Platform](https://developers.facebook.com/documentation/business-messaging/whatsapp/overview/), [Meta Content Library overview](https://developers.facebook.com/docs/content-library-and-api/content-library-api/overview/), [WhatsApp channel updates in Content Library](https://developers.facebook.com/docs/content-library-and-api/content-library-api/guides/wa-channel-update/).
