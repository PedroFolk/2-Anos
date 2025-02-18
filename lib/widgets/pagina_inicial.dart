import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto2anos/conts.dart';

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({
    super.key,
    required this.textos,
    required this.i,
    required AnimationController flowerController,
    required AnimationController pulseController,
    required Animation<double> flowerAnimation,
    required Animation<double> pulseAnimation,
  }) : _flowerController = flowerController, _pulseController = pulseController, _flowerAnimation = flowerAnimation, _pulseAnimation = pulseAnimation;

  final List<String> textos;
  final int i;
  final AnimationController _flowerController;
  final AnimationController _pulseController;
  final Animation<double> _flowerAnimation;
  final Animation<double> _pulseAnimation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textos[i],
              style: GoogleFonts.amaranth(
                fontSize: 64,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                color: corLetra,
              ),
            ),
            Text(
              "Da Amanda",
              style: GoogleFonts.amaranth(
                fontSize: 64,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                color: corLetra,
              ),
            ),
          ],
        ),
    
        // Animação das flores surgindo e pulsando suavemente
        AnimatedBuilder(
          animation:
              Listenable.merge([_flowerController, _pulseController]),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _flowerAnimation.value),
              child: Transform.scale(
                scale: _pulseAnimation.value.clamp(
                    0.98, 1.02), // Garante que não passe de 1.02
                child: child,
              ),
            );
          },
          child: Image.asset("assets/flores.png"),
        ),
      ],
    );
  }
}
