import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../shared/data/mock_catalog.dart';
import '../../../../shared/utils/mock_actions.dart';
import '../../../../shared/widgets/section_header.dart';
import 'promo_card.dart';

/// Compact snapping promotions carousel — auto-slides, dot indicators only.
/// Deliberately secondary: placed below the operational restock sections.
class PromotionsSection extends StatefulWidget {
  const PromotionsSection({super.key});

  @override
  State<PromotionsSection> createState() => _PromotionsSectionState();
}

class _PromotionsSectionState extends State<PromotionsSection> {
  late final PageController _pageController;
  Timer? _autoSlideTimer;
  int _currentPage = 0;

  static const _promotions = MockCatalog.promotions;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _startAutoSlide();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (!mounted || !_pageController.hasClients || _promotions.length < 2) {
        return;
      }
      final nextPage = (_currentPage + 1) % _promotions.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Mga promo'),
        SizedBox(
          height: 148,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            padEnds: false,
            itemCount: _promotions.length,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemBuilder: (context, index) {
              final promo = _promotions[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == _promotions.length - 1 ? 0 : 10,
                ),
                child: PromoCard(
                  badge: promo.badge,
                  headline: promo.headline,
                  subtext: promo.subtext,
                  actionLabel: promo.actionLabel,
                  filled: promo.filled,
                  onActionTap: () => showMockSnack(
                    context,
                    '${promo.actionLabel} tapped',
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Dot indicators — no arrows, less chrome
        Row(
          children: List.generate(
            _promotions.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: index == _currentPage ? 16 : 5,
              height: 5,
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: index == _currentPage
                    ? cs.primary
                    : cs.outlineVariant,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
