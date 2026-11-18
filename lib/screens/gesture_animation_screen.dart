import 'package:flutter/material.dart';
import '../core/app_drawer.dart';
import '../core/app_routes.dart';
import '../core/app_theme.dart';

/// This screen demonstrates the two drag gestures, an interactive animated
/// widget and a setState counter. The remaining three gestures (tap, double
/// tap and long press) are implemented directly on each product card.
class GestureAnimationScreen extends StatefulWidget {
  const GestureAnimationScreen({super.key});

  @override
  State<GestureAnimationScreen> createState() => _GestureAnimationScreenState();
}

class _GestureAnimationScreenState extends State<GestureAnimationScreen> {
  int _counter = 0;
  bool _expanded = false;
  String _horizontalStatus = 'Swipe left or right in this box';
  String _verticalStatus = 'Swipe up or down in this box';
  double _horizontalMovement = 0;
  double _verticalMovement = 0;

  void _finishHorizontal() {
    if (_horizontalMovement.abs() >= 24) {
      setState(() => _horizontalStatus = _horizontalMovement > 0
          ? 'Horizontal drag: swiped RIGHT'
          : 'Horizontal drag: swiped LEFT');
    }
    _horizontalMovement = 0;
  }

  void _finishVertical() {
    if (_verticalMovement.abs() >= 24) {
      setState(() => _verticalStatus = _verticalMovement > 0
          ? 'Vertical drag: swiped DOWN'
          : 'Vertical drag: swiped UP');
    }
    _verticalMovement = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestures & Animation')),
      drawer: const AppDrawer(currentRoute: AppRoutes.gestures),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const Text('Try all five gestures', style: TextStyle(
            color: AppTheme.navy, fontWeight: FontWeight.w800, fontSize: 21)),
          const SizedBox(height: 5),
          const Text('Tap, double-tap and long-press any product card on Home. '
            'Try both drag areas below.',
            style: TextStyle(color: AppTheme.muted)),
          const SizedBox(height: 18),
          _DemoCard(
            heading: '4. Horizontal drag',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: (_) => _horizontalMovement = 0,
              onHorizontalDragUpdate: (details) =>
                  _horizontalMovement += details.delta.dx,
              onHorizontalDragEnd: (_) => _finishHorizontal(),
              child: Container(
                width: double.infinity,
                height: 88,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.mint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.swap_horiz_rounded,
                      color: AppTheme.teal, size: 31),
                    const SizedBox(height: 4),
                    Text(_horizontalStatus, textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w700,
                        color: AppTheme.navy)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          _DemoCard(
            heading: '5. Vertical drag',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragStart: (_) => _verticalMovement = 0,
              onVerticalDragUpdate: (details) =>
                  _verticalMovement += details.delta.dy,
              onVerticalDragEnd: (_) => _finishVertical(),
              child: Container(
                width: double.infinity,
                height: 88,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECDA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.swap_vert_rounded,
                      color: AppTheme.navy, size: 31),
                    const SizedBox(height: 4),
                    Text(_verticalStatus, textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w700,
                        color: AppTheme.navy)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          _DemoCard(
            heading: 'AnimatedContainer - tap to transform',
            child: Center(
              child: GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: AnimatedContainer(
                  key: const Key('animated-product'),
                  duration: const Duration(milliseconds: 480),
                  curve: Curves.easeInOut,
                  width: _expanded ? 200 : 112,
                  height: 94,
                  decoration: BoxDecoration(
                    color: _expanded ? AppTheme.orange : AppTheme.teal,
                    borderRadius: BorderRadius.circular(_expanded ? 45 : 16),
                  ),
                  child: const Center(
                    child: Icon(Icons.shopping_bag_rounded,
                      color: Colors.white, size: 43),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          _DemoCard(
            heading: 'Counter (setState)',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filledTonal(
                  key: const Key('decrement-counter'),
                  tooltip: 'Decrement',
                  onPressed: () => setState(() => _counter--),
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 24),
                Text('$_counter', key: const Key('counter-value'),
                  style: const TextStyle(fontSize: 36,
                    fontWeight: FontWeight.w800, color: AppTheme.navy)),
                const SizedBox(width: 24),
                IconButton.filled(
                  key: const Key('increment-counter'),
                  tooltip: 'Increment',
                  onPressed: () => setState(() => _counter++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  final String heading;
  final Widget child;
  const _DemoCard({required this.heading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading, style: const TextStyle(color: AppTheme.navy,
              fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 15),
            child,
          ],
        ),
      ),
    );
  }
}
