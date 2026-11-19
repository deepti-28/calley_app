import 'package:flutter/material.dart';

/// Shows assets/images/whats_star_logo.png (WhatsApp button + "Star Calling Now"
/// button in one image) and makes the two parts tappable.
class WhatsStarBar extends StatelessWidget {
  final VoidCallback? onWhatsApp;
  final VoidCallback? onStart;
  const WhatsStarBar({super.key, this.onWhatsApp, this.onStart});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/whats_star_logo.png',
          width: double.infinity,
          fit: BoxFit.fitWidth,
          errorBuilder: (_, __, ___) => const SizedBox(
            height: 52,
            child: Center(child: Text('Add assets/images/whats_star_logo.png')),
          ),
        ),
        // Tap zones laid over the image (left = WhatsApp, right = Star Calling Now).
        // If the split feels off, change the two flex numbers (14 / 86).
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                flex: 14,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onWhatsApp,
                ),
              ),
              Expanded(
                flex: 86,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onStart,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}