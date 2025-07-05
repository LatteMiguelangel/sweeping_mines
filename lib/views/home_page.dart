import 'package:buscando_minas/views/difficulty_selection_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'BUSCANDO MINAS',
                style: TextStyle(
                  fontFamily: 'PressStart2P',
                  fontSize: 20,
                  color: Colors.greenAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _menuButton(context, '🎮 JUGAR', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DifficultySelectionPage(),
                  ),
                );
              }),
              const SizedBox(height: 20),
              _menuButton(context, '❌ SALIR', () {
                // Aquí puedes cerrar la app o dejarlo vacío
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          backgroundColor: Colors.black,
          foregroundColor: Colors.greenAccent,
          side: const BorderSide(color: Colors.greenAccent, width: 2),
          elevation: 8,
          textStyle: const TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 12,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}