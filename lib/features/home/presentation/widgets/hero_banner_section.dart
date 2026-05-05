import 'package:flutter/material.dart';
import '../../../../shared/widgets/badge_label.dart';
import '../../../../shared/widgets/image_placeholder.dart';
import '../../../../shared/widgets/section_header.dart';

/// Hero banner — full-width image placeholder with gradient overlay and text.
class HeroBannerSection extends StatelessWidget {
  const HeroBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Suggested Restock'),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: cs.primary, width: 2),
          ),
          child: Stack(
            children: [
              // Background image placeholder
              const ImagePlaceholder(height: 192, iconSize: 48),
              // Gradient + text overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        cs.primary.withValues(alpha: 0.8),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.6],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BadgeLabel(label: 'Trending'),
                    const SizedBox(height: 4),
                    Text(
                      'Headline Text',
                      style: tt.headlineMedium?.copyWith(color: cs.onPrimary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Subtext description goes here.',
                      style: tt.bodySmall?.copyWith(
                        color: cs.surfaceContainerLowest,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
