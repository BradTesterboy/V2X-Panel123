
✨ Change Log v1.5.2:
- **UI Overhaul:** Fundamental redesign of the panel UI and frontend code.
- **Inbound Fallback Redirect:** Set a custom redirect URL (e.g., https://google.com) for non‑matching requests.
- **Stealth Address (Reverse Proxy):** Use a reverse proxy address as camouflage.
- **Subscription Filename:** Rename the subscription file as needed.
- **Admin Panel Prefix:** Define a hidden admin path for the panel.
- **Blocked Domains:** Specify blocked domains (one per line).
- **Clash & Sing‑box Sub Links:** Generate subscription links for Clash and Sing‑box clients.
- **Mobile/Tablet Compatibility:** Enhanced responsiveness for mobile and tablet views.
- **Logging Accuracy:** Improved precision of inbound/outbound logs and user usage data.
- **Anti‑Sleep Reinforcement:** Major reinforcement of the Keep‑Alive system.
- **DOH Link:** Added DNS‑over‑HTTPS link (works on some services).
- **IP Profiles:** Assign specific IP profiles to each inbound.

✨ Change Log v1.5.0 (beta):
- **XHTTP Protocol:** Full SplitHTTP transport with packet‑up, stream‑up, and stream‑one modes.
- **Adaptive Quota Gate:** Batches bandwidth checks based on real‑time speed, reducing database load.
- **Raw Downlink Response:** GET responses without chunked encoding for full Xray‑core compatibility.
- **Dynamic XHTTP Router:** Automatic request dispatch using inbound’s custom path – no extra config.
- **Auto ALPN Injection:** Adds `alpn=http/1.1` automatically for XHTTP links when ALPN is missing.
- **XHTTP Diagnostic Tool:** Standalone script (`xhttp_diag.py`) simulates a client to test latency and throughput.
- **Security Enhancement:** Public IP scanner WebSocket endpoint disabled by default to avoid abuse.
- **Performance Optimizations:** Added `uvloop`, updated Dockerfile and platform settings for smoother deployments.

✨ Change Log v1.1.0:
- **UI & UX:** Glass‑morphism interface polished, Blue Theme bug fixed, mobile responsiveness improved.
- **Performance:** Periodic link‑cache cleaning, scanner tasks correctly cancelled on WebSocket close.
- **Anti‑Sleep:** Redesigned Keep‑Alive engine with two modes (Simple/Advanced) switchable in real time.
- **Inbounds:** Fragment (FRAG) support added for DPI bypass, country flags assignable to each inbound.
- **User Dashboard:** Live usage progress bar with color‑coded thresholds (green→yellow→red).
- **Telegram:** Language toggle (EN/FA) fixed, now saves and restores correctly.
- **Database:** Automatic schema migration adds `flag` and `fragment` columns without manual intervention.
- **Bug Fixes:** Settings status cards sync with actual configs, time‑zone/language selectors harmonised.


<p align="center">
  <sub>Dedicated to the people of my homeland Iran, from <a href="https://github.com/SulgX">SulgX</a></sub>
</p>
