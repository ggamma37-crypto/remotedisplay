# Remote Display v1.0.16 FPS30 diagnostic

**Purpose:** Compare the Windows client's automatic FPS feedback against a
diagnostic mode that requests a 30 FPS *maximum* from the Mac. The Mac still
has separate QoS/network-delay controls: neither mode guarantees 30 displayed FPS.

## What changes?
- Only a freshly built `librustdesk.dll` from the same v1.0.16 source.
- NORMAL: original FPS control; `RD_FPS_DIAG_LOG=1` adds one measurement per second.
- FORCE30: `RD_FPS_DIAG_FORCE30=1` bypasses client auto-FPS feedback.
- Both modes log displayed FPS, estimated decoder processing capacity, queue
  occupancy, direct connection flag and the last auto-FPS value.
- These values **do not** measure Mac screen capture or host encode FPS.

## How to test safely
1. Keep the existing portable installation untouched. Exit Remote Display completely.
2. Copy the entire existing **v1.0.16 portable** folder to a new directory.
3. Only after the workflow build succeeds *and the export-check step passes*, put
   the artifact's DLL and both CMD files next to `remotedisplay.exe` inside
   that copied directory, replacing the copied DLL only.
4. Run `run-fps30-normal.cmd`. Connect to the same Mac virtual display.
   For ~30 seconds make consistent motion, e.g. continuously move a window.
   Record displayed FPS, input latency, codec, resolution.
5. Exit Remote Display completely. Run `run-fps30-force30.cmd` and repeat
   the same test for ~15–30 seconds.
6. **If delay, memory usage, or queue size grows, disconnect immediately.**
7. Inspect the Windows Remote Display client logs under
   `%APPDATA%\RemoteDisplay`, searching for `RD_FPS_DIAG` and
   `Set fps to`. In FORCE30 you should see the bypass log once.
8. Restore original behavior by exiting the diagnostic copy and starting
   the original portable; nothing is installed or changed on the Mac.

## Interpreting results
- FORCE30 yields 20–30 FPS without lag: client auto-FPS feedback was limiting.
- FORCE30 stays ~5–11 FPS: check Mac capture/encoder and client processing.
- FORCE30 FPS rises but queue/delay climbs: genuine processing/transport bottleneck.
- The Mac's separate VideoQoS can limit FPS based on delay and frame acknowledgements;
  a client request for 30 FPS is only a ceiling, not a forced frame-production rate.

## Important limitations
- This is a **diagnostic build**, not a permanent fix.
- Exported-function matching cannot guarantee runtime compatibility; test only
  with a separate portable copy, never with the original folder.
- GitHub Actions builds and step validation must succeed before replacing any DLL.
- If the workflow fails, do not substitute a partial DLL or skip validation.
