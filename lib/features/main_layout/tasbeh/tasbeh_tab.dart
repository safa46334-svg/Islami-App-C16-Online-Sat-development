
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:islami_app_online_sat/core/resources/colors_manager.dart';
import 'package:islami_app_online_sat/core/resources/assets_manager.dart';

class TasbehTab extends StatefulWidget {
  const TasbehTab({super.key});

  @override
  State<TasbehTab> createState() => _TasbehTabState();
}

class _TasbehTabState extends State<TasbehTab>
    with SingleTickerProviderStateMixin {
  final int beadsCount = 33;
  final List<String> azkar = ['سبحان الله', 'الحمد لله', 'الله أكبر'];

  int zikrIndex = 0;
  int counter = 0;

  late AnimationController _controller;
  double _rotationBase = 0.0;
  double _rotationTarget = 0.0;

  double get _step => 2 * pi / beadsCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 220));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotationBase = _rotationTarget;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapSebha() {
    setState(() {
      counter++;
      if (counter > beadsCount) {
        counter = 1;
        zikrIndex = (zikrIndex + 1) % azkar.length;
      }
      _rotationTarget = _rotationBase + _step;
      _controller.forward(from: 0);
    });
  }

  void _reset() {
    setState(() {
      counter = 0;
      zikrIndex = 0;
      _rotationBase = 0;
      _rotationTarget = 0;
      _controller.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.45),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),

              Image.asset(
                ImageAssets.islamiLogo,
                width: 291,
              ),

              const SizedBox(height: 16),

              const Text(
                'سَبِّحِ اسْمَ رَبِّكَ الْأَعْلَى',
                style: TextStyle(
                  color: ColorsManager.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  height: 4,
                ),
                textAlign: TextAlign.center,
              ),

              Expanded(
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final size =
                          min(constraints.maxWidth, constraints.maxHeight) * 0.90;
                      final beadSize = size * 0.085;
                      final radius = size / 2 - beadSize - 6;

                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (_, __) {
                          final rotation = _rotationBase +
                              (_rotationTarget - _rotationBase) *
                                  _controller.value;

                          List<Widget> beads = [];
                          for (int i = 0; i < beadsCount; i++) {
                            final angle = 2 * pi * i / beadsCount + rotation;
                            final x = (size / 2) +
                                radius * cos(angle) -
                                beadSize / 2;
                            final y = (size / 2) +
                                radius * sin(angle) -
                                beadSize / 2;
                            beads.add(Positioned(
                              left: x,
                              top: y,
                              child: Container(
                                width: beadSize,
                                height: beadSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorsManager.gold,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.45),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          }

                          return SizedBox(
                            width: size,
                            height: size,
                            child: Transform.translate(
                              offset: Offset(0, size * 0.05),
                              child: Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  ...beads,

                                  Positioned(
                                    top: -size * 0.280,
                                    left: size * 0.5 - (size * 0.01),
                                    child: Image.asset(
                                      ImageAssets.sebhaHead,
                                      width: size * 0.3,
                                      fit: BoxFit.contain,
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: _onTapSebha,
                                    onLongPress: _reset,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          azkar[zikrIndex],
                                          style: const TextStyle(
                                            color: ColorsManager.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '$counter',
                                          style: const TextStyle(
                                            color: ColorsManager.white,
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
