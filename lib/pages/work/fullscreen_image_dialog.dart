import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/delayed_display.dart';

class FullscreenImageDialog extends ConsumerWidget {
  FullscreenImageDialog({
    super.key,
    required this.item,
  });

  final ShowcaseItem item;

  final uiShowcaseManager = sl<UiShowcaseManager>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          child: ValueListenableBuilder<int>(
            valueListenable: uiShowcaseManager.currentImageIndex,
            builder: (context, value, _) {
              final path = item.imageAssets[value];
              return InteractiveViewer(
                panAxis: PanAxis.aligned,
                child: Hero(
                  tag: path,
                  child: Center(
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        path,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 24,
          right: 24,
          child: IconButton(
            iconSize: 48,
            highlightColor: Colors.transparent,
            color: context.backgroundColor,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
            icon: const Center(
              child: Icon(CupertinoIcons.xmark, size: 24, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          left: 24,
          child: IconButton(
            iconSize: 48,
            style: IconButton.styleFrom(backgroundColor: themeColor),
            onPressed: () =>
                uiShowcaseManager.previousImageItemCommand.execute(),
            icon: const Center(
              child: Icon(CupertinoIcons.chevron_left,
                  size: 24, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          right: 24,
          child: IconButton(
            iconSize: 48,
            style: IconButton.styleFrom(backgroundColor: themeColor),
            onPressed: () => uiShowcaseManager.nextImageItemCommand.execute(),
            icon: const Center(
              child: Icon(CupertinoIcons.chevron_right,
                  size: 24, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class MobileFullscreenImageDialog extends HookWidget {
  const MobileFullscreenImageDialog({
    super.key,
    required this.item,
    required this.image,
  });

  final ShowcaseItem item;
  final String image;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final width = context.width;
    final height = context.height;
    final images = item.imageAssets;

    // Create transformation controllers for each image
    final transformationControllers = useMemoized(
      () => List.generate(
        images.length,
        (index) => TransformationController(),
      ),
      [images.length],
    );

    // Track if we're applying custom transformation to avoid loops
    final isApplyingTransform = useRef(<bool>[]);

    // Track if animation is in progress for each image
    final isAnimating = useRef(<bool>[]);

    // Initialize the flag list
    useEffect(() {
      isApplyingTransform.value = List.filled(images.length, false);
      isAnimating.value = List.filled(images.length, false);
      return null;
    }, [images.length]);

    // Dispose controllers when widget is disposed
    useEffect(() {
      return () {
        for (final tc in transformationControllers) {
          tc.dispose();
        }
      };
    }, [transformationControllers]);

    final disabledScroll = useState(false);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        height: height,
        width: width,
        child: SafeArea(
          child: Column(
            spacing: 12,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DelayedDisplay(
                      child: Text(
                        item.projectName,
                        style: context.bodyText1,
                      ),
                    ),
                    IconButton(
                      iconSize: 32,
                      highlightColor: Colors.transparent,
                      style: IconButton.styleFrom(
                        backgroundColor: context.theme.primaryColor,
                        iconSize: 24,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      splashColor: Colors.transparent,
                      onPressed: () => Navigator.pop(context),
                      icon: const SizedBox(
                        height: 24,
                        width: 24,
                        child: Center(
                          child: Icon(CupertinoIcons.xmark,
                              size: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RawScrollbar(
                  controller: controller,
                  thumbVisibility: true,
                  thickness: 24,
                  
                  thumbColor: context.theme.primaryColor,
                  trackColor: context.theme.primaryColor.withAlpha(100),
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    physics: disabledScroll.value
                        ? const NeverScrollableScrollPhysics()
                        : const PageScrollPhysics(),
                    child: Row(
                      children: images.asMap().entries.map((entry) {
                        final image = entry.value;
                        return ZoomOnDoubleTapImage(
                          image: image,
                          width: width,
                          height: width * 12 / 16,
                          isZoomed: (isZoomed) {
                            disabledScroll.value = isZoomed;
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ZoomOnDoubleTapImage extends StatefulWidget {
  const ZoomOnDoubleTapImage({
    super.key,
    required this.image,
    required this.width,
    required this.height,
    required this.isZoomed,
  });
  final String image;
  final double width;
  final double height;
  final Function(bool) isZoomed;
  @override
  State<ZoomOnDoubleTapImage> createState() => _ZoomOnDoubleTapImageState();
}

class _ZoomOnDoubleTapImageState extends State<ZoomOnDoubleTapImage>
    with SingleTickerProviderStateMixin {
  late TransformationController _controller;
  AnimationController? _animationController;
  Animation<Matrix4>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  void _runAnimation(Matrix4 endMatrix) {
    _animation = Matrix4Tween(
      begin: _controller.value,
      end: endMatrix,
    ).animate(CurveTween(curve: Curves.easeOut).animate(_animationController!));

    _animationController!.addListener(() {
      _controller.value = _animation!.value;
      if (_animationController!.value == 1.0) {
        widget.isZoomed(true);
      } else if (_animationController!.value == 0.0) {
        widget.isZoomed(false);
      }
    });

    _animationController!.forward();
  }

  void _onDoubleTap(TapDownDetails details, BuildContext context) {
    // If currently zoomed → reset
    if (_controller.value != Matrix4.identity()) {
      _animationController!.reverse();
      return;
    }

    // Zoom around tap position
    final tapPos = details.localPosition;
    final zoomed = Matrix4.identity()
      ..translate(-tapPos.dx * 2, -tapPos.dy * 2)
      ..scale(3.0);

    _runAnimation(zoomed);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (details) => _onDoubleTap(details, context),
      child: AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) {
            final panEnabled = _animationController!.value == 1.0;
            return InteractiveViewer(
              transformationController: _controller,
              minScale: 1,
              maxScale: 3,
              panEnabled: panEnabled,
              scaleEnabled: true,
              child: Image.asset(
                widget.image,
                width: lerpDouble(widget.width, context.width * 3,
                    _animationController!.value),
                height: lerpDouble(
                    widget.height, context.height, _animationController!.value),
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }
}
