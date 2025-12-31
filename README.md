# DumbBrowser (iOS)

A minimal SwiftUI iOS app that **only** displays web links in a `WKWebView` and **does not** include a search bar. It is intended to be a simple link viewer.

## What this app does (and does not) do

- ✅ Opens `http`/`https` links inside the app.
- ✅ Shows a basic empty state when no link has been opened.
- ❌ Does **not** provide a search bar.
- ❌ Cannot programmatically disable Safari (iOS does not allow third‑party apps to disable it).

If you want to prevent Safari usage on a device, use **Screen Time** restrictions:

1. Open **Settings → Screen Time → Content & Privacy Restrictions**.
2. Enable **Content & Privacy Restrictions**.
3. Go to **Allowed Apps** and toggle **Safari** off.

## Opening links in DumbBrowser

The app listens for incoming URLs via `onOpenURL`. You can open links using a custom URL scheme by registering one in the app’s **Info.plist** and then passing a URL like:

```
dumbbrowser://open?url=https://example.com
```

In Xcode, add a URL Type in **Info → URL Types** with the scheme `dumbbrowser`, then open links from Shortcuts or other apps.

## Project files

- `DumbBrowserApp/DumbBrowserApp.swift` — App entry point and link handling.
- `DumbBrowserApp/ContentView.swift` — No-search-bar UI and empty state.
- `DumbBrowserApp/WebView.swift` — `WKWebView` wrapper with navigation policy.
- `DumbBrowserApp/AppState.swift` — URL state holder.

## Notes

This repo contains only the core Swift source files. Create a new Xcode iOS App project and drop these files in (or use them as a reference) to get a buildable app.
