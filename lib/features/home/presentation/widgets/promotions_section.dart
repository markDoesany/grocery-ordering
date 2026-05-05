import 'package:flutter/material.dart';
import '../../../../shared/data/mock_catalog.dart';
import '../../../../shared/utils/mock_actions.dart';
import '../../../../shared/widgets/section_header.dart';
import 'promo_card.dart';

/// Snapping promotions carousel with prev/next arrow buttons.
class PromotionsSection extends StatefulWidget {
  const PromotionsSection({super.key});

  @override
  State<PromotionsSection> createState() => _PromotionsSectionState();
}

class _PromotionsSectionState extends State<PromotionsSection> {
  late final PageController _pageController;
  int _currentPage = 0;

  static const _promotions = MockCatalog.promotions;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page.clamp(0, _promotions.length - 1),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Promotions',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ArrowButton(
                icon: Icons.arrow_back,
                borderColor: cs.primary,
                onTap: () => _goToPage(_currentPage - 1),
              ),
              const SizedBox(width: 4),
              _ArrowButton(
                icon: Icons.arrow_forward,
                borderColor: cs.primary,
                onTap: () => _goToPage(_currentPage + 1),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 176,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            padEnds: false,
            itemCount: _promotions.length,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemBuilder: (context, index) {
              final promotion = _promotions[index];
              return AnimatedBuilder(
                animation: _pageController,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == _promotions.length - 1 ? 0 : 12,
                  ),
                  child: PromoCard(
                    badge: promotion.badge,
                    headline: promotion.headline,
                    subtext: promotion.subtext,
                    actionLabel: promotion.actionLabel,
                    filled: promotion.filled,
                    onActionTap: () => showMockSnack(
                      context,
                      '${promotion.actionLabel} tapped',
                    ),
                  ),
                ),
                builder: (context, child) {
                  var scale = 1.0;
                  if (_pageController.hasClients &&
                      _pageController.position.haveDimensions) {
                    final page =
                        _pageController.page ?? _currentPage.toDouble();
                    scale = (1 - ((page - index).abs() * 0.04)).clamp(
                      0.96,
                      1.0,
                    );
                  }
                  return Transform.scale(
                    scale: scale,
                    alignment: Alignment.centerLeft,
                    child: child,
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(
            _promotions.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              width: index == _currentPage ? 18 : 6,
              height: 6,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: index == _currentPage ? cs.primary : cs.outlineVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.borderColor,
    this.onTap,
  });

  final IconData icon;
  final Color borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: cs.surfaceContainerLowest,
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Icon(icon, size: 16),
          ),
        ),
      ),
    );
  }
}
