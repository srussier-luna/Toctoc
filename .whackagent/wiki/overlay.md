# Overlay

- `ClippyOverlay` owns two panels built by `NSPanel.overlay(content:size:isClickThrough:)`: borderless, non-activating, level `.statusBar`, clear, no shadow.
- Collection behavior `[.canJoinAllSpaces, .canJoinAllApplications, .stationary, .ignoresCycle, .fullScreenAuxiliary]`. `.canJoinAllApplications` added against the flash on Space switch (agent app windows belong to its own set only; cause not proven). Plan B if it flashes again: level `.screenSaver` (also above menus and alerts).
- Character panel 64×136: clickable, hosts `ClippyView`. `FirstClickHostingView` accepts the first mouse.
- Bubble panel 320×144: hosts `BubbleStackView` in a `FirstClickHostingView`; `ignoresMouseEvents` toggled from mouse monitors so only bubbles take clicks (`BubbleHitRegion`), rest passes through (up to 3 `BubbleView`, newest nearest the paperclip, panel grows upward).

## Placement and drag

- Pure math in `Core/Overlay/Models/` (`OverlayLayout`, `OverlayPlacement`, `OverlayScreen`, `ClippyPosition`, `ClippyDrag`, `BubbleSide`), unit-tested.
- Paperclip always fully inside the screen's `visibleFrame` (never under menu bar or Dock).
- Saved position: `ClippyPositionStorage`, UserDefaults key `clippyPosition`, JSON `{screenID, relativePoint}` (screen = `NSScreenNumber`, point 0…1 within the room left for the paperclip).
- Nothing saved → bottom right of the main screen, margin 12. Saved screen gone → same relative point on the main screen.
- Drag: `ClippyView` `highPriorityGesture(DragGesture(minimumDistance: 3))` → `ClippyOverlay.follow` (position from `NSEvent.mouseLocation`, nearest screen, clamped live) → `drop` saves. A click under 3 pt still hits the `Button` (opens Claude). Not proven with a real mouse yet.
- Bubble stack left of the paperclip; right when there is no room on the left (`BubbleSide`), always fully on screen.
- Screen change (`didChangeScreenParametersNotification`) → saved position applied again.
- Hosting views use `sizingOptions = []`: panels keep their size.
