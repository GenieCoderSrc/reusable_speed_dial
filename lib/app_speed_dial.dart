import 'package:flutter/material.dart';

import 'speed_dial_child.dart';

class SpeedDial extends StatefulWidget {
  const SpeedDial({
    super.key,
    this.childOnOpen,
    this.speedDialChildren,
    this.labelsStyle,
    this.controller,
    this.closedForegroundColor,
    this.openForegroundColor,
    this.closedBackgroundColor,
    this.openBackgroundColor,
    this.childOnClose,
    this.onCloseIcon,
    this.onOpenIcon,
  });

  final Widget? childOnOpen;
  final Widget? childOnClose;
  final IconData? onOpenIcon;
  final IconData? onCloseIcon;

  final List<SpeedDialChild>? speedDialChildren;

  final TextStyle? labelsStyle;

  final AnimationController? controller;

  final Color? closedForegroundColor;

  final Color? openForegroundColor;

  final Color? closedBackgroundColor;

  final Color? openBackgroundColor;

  @override
  State<StatefulWidget> createState() {
    return _SpeedDialState();
  }
}

@override
class _SpeedDialState extends State<SpeedDial>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Animation<double>> _speedDialChildAnimations =
      <Animation<double>>[];

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        widget.controller ??
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 250),
        );
    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _setupAnimations();

    super.initState();
  }

  void _setupAnimations() {
    final double fractionOfOneSpeedDialChild =
        1.0 / widget.speedDialChildren!.length;
    for (
      int speedDialChildIndex = 0;
      speedDialChildIndex < widget.speedDialChildren!.length;
      ++speedDialChildIndex
    ) {
      final List<TweenSequenceItem<double>> tweenSequenceItems =
          <TweenSequenceItem<double>>[];

      final double firstWeight =
          fractionOfOneSpeedDialChild * speedDialChildIndex;
      if (firstWeight > 0.0) {
        tweenSequenceItems.add(
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(0.0),
            weight: firstWeight,
          ),
        );
      }

      tweenSequenceItems.add(
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: fractionOfOneSpeedDialChild,
        ),
      );

      final double lastWeight =
          fractionOfOneSpeedDialChild *
          (widget.speedDialChildren!.length - 1 - speedDialChildIndex);
      if (lastWeight > 0.0) {
        tweenSequenceItems.add(
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(1.0),
            weight: lastWeight,
          ),
        );
      }

      _speedDialChildAnimations.insert(
        0,
        TweenSequence<double>(tweenSequenceItems).animate(_animationController),
      );
    }
  }

  //  build method

  @override
  Widget build(BuildContext context) {
    int speedDialChildAnimationIndex = 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (!_animationController.isDismissed)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  widget.speedDialChildren?.map<Widget>((
                    SpeedDialChild speedDialChild,
                  ) {
                    final Widget speedDialChildWidget = Opacity(
                      opacity:
                          _speedDialChildAnimations[speedDialChildAnimationIndex]
                              .value,
                      child: ScaleTransition(
                        scale:
                            _speedDialChildAnimations[speedDialChildAnimationIndex],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: FloatingActionButton(
                            heroTag: speedDialChildAnimationIndex,
                            mini: true,
                            foregroundColor: speedDialChild.foregroundColor,
                            backgroundColor: speedDialChild.backgroundColor,
                            onPressed: () {
                              if (speedDialChild.closeSpeedDialOnPressed) {
                                _animationController.reverse();
                              }
                              speedDialChild.onPressed?.call();
                            },
                            child: speedDialChild.child,
                          ),
                        ),
                      ),
                    );
                    speedDialChildAnimationIndex++;
                    return speedDialChildWidget;
                  }).toList() ??
                  <Widget>[],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(
            icon: Icon(
              _animationController.isDismissed
                  ? widget.onCloseIcon ?? Icons.call
                  : widget.onCloseIcon ?? Icons.cancel,
            ),
            color: Colors.white,
            onPressed: () => _animationController.isDismissed
                ? _animationController.forward()
                : _animationController.reverse(),
          ),
        ),
      ],
    );
  }
}
