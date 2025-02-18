import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'package:projeto2anos/conts.dart';
import 'package:projeto2anos/pages/primeiros_passos.dart';
import 'package:projeto2anos/widgets/pagina_inicial.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late Ticker _ticker;
  final Random _random = Random();
  final List<Map<String, dynamic>> clouds = [];
  late AnimationController _flowerController;
  late Animation<double> _flowerAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Criar configurações aleatórias para as nuvens
    for (int i = 0; i < 10; i++) {
      bool moveLeft = i % 2 == 0;

      clouds.add({
        "x": _random.nextDouble() * 400,
        "y": _random.nextDouble() * 700,
        "size": 100 + _random.nextDouble() * 150,
        "speed": 0.2 + _random.nextDouble() * 1.2,
        "moveLeft": moveLeft,
        "flipHorizontally": moveLeft,
      });
    }

    // Criar um Ticker para animar as nuvens
    _ticker = createTicker((elapsed) {
      setState(() {
        for (var cloud in clouds) {
          if (cloud["moveLeft"]) {
            cloud["x"] -= cloud["speed"];
            if (cloud["x"] < -cloud["size"]) {
              cloud["x"] = MediaQuery.of(context).size.width;
            }
          } else {
            cloud["x"] += cloud["speed"];
            if (cloud["x"] > MediaQuery.of(context).size.width) {
              cloud["x"] = -cloud["size"];
            }
          }
        }
      });
    });

    _ticker.start();

    // Animação de subida (de fora da tela para a posição normal)
    _flowerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _flowerAnimation = Tween<double>(
      begin: 100, // Começa mais abaixo da tela
      end: 0, // Fica na posição normal
    ).animate(
      CurvedAnimation(parent: _flowerController, curve: Curves.easeOut),
    );

    _flowerController.forward();

    // Animação de pulsação suave corrigida
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    _pulseController.forward();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _flowerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  var textos = ["Cafeteria?", "Floricultura?", "Livraria?", "Espaço Mágico"];
  var i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corCeu,
      body: GestureDetector(
        onTap: _changeText,
        child: Stack(
          children: [
            // Fundo animado das nuvens
            Positioned.fill(
              child: Stack(
                children: clouds.map((cloud) {
                  return Positioned(
                    left: cloud["x"],
                    top: cloud["y"],
                    child: Transform(
                      alignment: Alignment.center,
                      transform: cloud["flipHorizontally"]
                          ? Matrix4.rotationY(pi)
                          : Matrix4.identity(),
                      child: SizedBox(
                        width: cloud["size"],
                        height: cloud["size"],
                        child: Image.asset("assets/nuvem.png"),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Conteúdo na frente das nuvens
            Center(
              child: PaginaInicial(
                  textos: textos,
                  i: i,
                  flowerController: _flowerController,
                  pulseController: _pulseController,
                  flowerAnimation: _flowerAnimation,
                  pulseAnimation: _pulseAnimation),
            ),
          ],
        ),
      ),
    );
  }

  void _changeText() {
    setState(() {
      if (i < 3) {
        i = (i + 1) % textos.length;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PrimeirosPassos()),
        );
      }
    });
  }
}
