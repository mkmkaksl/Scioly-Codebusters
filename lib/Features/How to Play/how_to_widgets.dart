import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.orbitron(
          color: Colors.lightGreenAccent.shade400,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class SubsectionTitle extends StatelessWidget {
  final String text;
  const SubsectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 4),
      child: Text(
        text,
        style: GoogleFonts.orbitron(
          color: Colors.lightGreenAccent.shade100,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  final String text;
  const Paragraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: GoogleFonts.shareTechMono(color: Colors.white, fontSize: 14),
      ),
    );
  }
}

class BulletPoints extends StatelessWidget {
  final List<String> items;
  const BulletPoints(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• ',
                style: TextStyle(color: Colors.lightGreenAccent, fontSize: 16),
              ),
              Expanded(
                child: Text(
                  item,
                  style: GoogleFonts.shareTechMono(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ExampleBlock extends StatelessWidget {
  final String ciphertext;
  final String solution;
  const ExampleBlock({
    required this.ciphertext,
    required this.solution,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.cyanAccent, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.lightGreenAccent.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Example:',
            style: GoogleFonts.orbitron(
              color: Colors.lightGreenAccent.shade100,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ciphertext,
            style: GoogleFonts.shareTechMono(
              color: Colors.greenAccent,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            solution,
            style: GoogleFonts.shareTechMono(
              color: Colors.orangeAccent,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
