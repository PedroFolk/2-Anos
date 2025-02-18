import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeuBotao extends StatefulWidget {
  final String texto;
  final Color corDoBotao;
  final Color corDaBorda;

  const MeuBotao({
    super.key,
    required this.texto,
    required this.corDoBotao,
    required this.corDaBorda,
  });

  @override
  _MeuBotaoState createState() => _MeuBotaoState();
}

class _MeuBotaoState extends State<MeuBotao> {
  double escala = 1.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          escala = 1.1; // Aumenta um pouco o tamanho
        });
      },
      onExit: (event) {
        setState(() {
          escala = 1.0; // Volta ao tamanho normal
        });
      },
      child: AnimatedScale(
        scale: escala,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          child: Container(
            height: 100,
            width: 250,
            decoration: BoxDecoration(
              color: widget.corDoBotao,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.corDaBorda,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Text(
                widget.texto,
                style: GoogleFonts.amaranth(
                  fontSize: 48,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(136, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
