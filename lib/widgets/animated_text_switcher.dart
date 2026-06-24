import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedTextSwitcher extends HookWidget {
  const AnimatedTextSwitcher({
    super.key,
    required this.texts,
    this.initialDelay = Duration.zero,
    this.switchDuration = const Duration(seconds: 2),
    this.toWidget,
  });

  final List<String> texts;
  final Widget Function(String)? toWidget;
  final Duration switchDuration;
  final Duration initialDelay;

  @override
  Widget build(BuildContext context) {
    // Use a ValueNotifier for the current text index
    final currentIndex = useState(0);

    // Effect to handle the timer
    useEffect(() {
      if (texts.isEmpty || texts.length == 1) return null;

      Timer? timer;

      // Start the initial delay timer
      final delayTimer = Timer(initialDelay, () {
        // Start the periodic timer after initial delay
        timer = Timer.periodic(switchDuration, (timer) {
          currentIndex.value = (currentIndex.value + 1) % texts.length;
        });
      });

      // Cleanup both timers on dispose
      return () {
        delayTimer.cancel();
        timer?.cancel();
      };
    }, [texts.join(), initialDelay, switchDuration]);

    if (texts.isEmpty) return const SizedBox.shrink();

    return toWidget?.call(texts[currentIndex.value]) ??
        Text(
          key: ValueKey<String>(texts[currentIndex.value]),
          texts[currentIndex.value],
        );
  }
}
