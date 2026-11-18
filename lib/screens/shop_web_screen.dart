import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../core/app_drawer.dart';
import '../core/app_routes.dart';
import '../core/app_theme.dart';

/// Uses the existing Lab 9 webview_flutter 4.x dependency. Requires internet
/// permission (already supplied in android/app/src/main/AndroidManifest.xml).
class ShopWebScreen extends StatefulWidget {
  const ShopWebScreen({super.key});

  @override
  State<ShopWebScreen> createState() => _ShopWebScreenState();
}

class _ShopWebScreenState extends State<ShopWebScreen> {
  static const _website = 'https://www.wikipedia.org/';
  WebViewController? _controller;
  int _progress = 0;
  bool _failed = false;

  bool get _isMobile => !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
       defaultTargetPlatform == TargetPlatform.iOS);

  @override
  void initState() {
    super.initState();
    if (!_isMobile) return;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) {
          if (mounted) setState(() { _progress = 0; _failed = false; });
        },
        onProgress: (value) {
          if (mounted) setState(() => _progress = value);
        },
        onWebResourceError: (error) {
          if (error.isForMainFrame == false) return;
          if (mounted) setState(() => _failed = true);
        },
        onNavigationRequest: (request) =>
            request.url.startsWith('https://')
                ? NavigationDecision.navigate
                : NavigationDecision.prevent,
      ))
      ..loadRequest(Uri.parse(_website));
  }

  void _retry() {
    setState(() { _failed = false; _progress = 0; });
    _controller?.loadRequest(Uri.parse(_website));
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
        actions: [
          IconButton(
            tooltip: 'Reload website',
            onPressed: controller == null ? null : _retry,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      drawer: const AppDrawer(currentRoute: AppRoutes.web),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Website inside the app', style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w800, color: AppTheme.navy)),
            const SizedBox(height: 3),
            const Text(_website,
              style: TextStyle(fontSize: 12, color: AppTheme.muted)),
            const SizedBox(height: 12),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ColoredBox(
                  color: Colors.white,
                  child: controller == null
                    ? const Center(child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('WebView is available on Android and iOS. '
                          'Open this screen in the Android emulator.',
                          textAlign: TextAlign.center),
                      ))
                    : _failed
                      ? Center(child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.wifi_off_rounded,
                              size: 46, color: AppTheme.teal),
                            const SizedBox(height: 12),
                            const Text('Could not load website. Check internet.'),
                            const SizedBox(height: 12),
                            FilledButton.icon(onPressed: _retry,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry')),
                          ],
                        ))
                      : Stack(
                          children: [
                            WebViewWidget(controller: controller),
                            if (_progress < 100)
                              const Positioned(
                                top: 0, left: 0, right: 0,
                                child: LinearProgressIndicator(minHeight: 3),
                              ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
