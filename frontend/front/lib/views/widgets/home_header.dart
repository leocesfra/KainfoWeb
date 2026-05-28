import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class HeaderWidget extends StatelessWidget {
  final bool isMenuOpen;
  final VoidCallback onCategoryTap;
  final String currentLanguage;
  final ValueChanged<String?> onLanguageChanged;

  const HeaderWidget({
    super.key,
    required this.isMenuOpen,
    required this.onCategoryTap,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CategoryMenuButton(
                isOpen: isMenuOpen,
                onTap: onCategoryTap,
              ),
              const SizedBox(width: 16),
              const Text(
                'LOGO',
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(top: isMobile ? 16 : 0),
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    offset: Offset(0, 6),
                    blurRadius: 14,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 18),
                  const Icon(Icons.search, color: AppColors.neutralColorDark),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Que estás buscando?',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0xCC606161),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LanguageDropdown(
                currentLanguage: currentLanguage,
                onChanged: onLanguageChanged,
              ),
              const SizedBox(width: 12),
              _HeaderIcon(icon: Icons.person_outline),
              const SizedBox(width: 8),
              _HeaderIcon(icon: Icons.shopping_cart_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatefulWidget {
  final IconData icon;

  const _HeaderIcon({required this.icon});

  @override
  State<_HeaderIcon> createState() => _HeaderIconState();
}

class _HeaderIconState extends State<_HeaderIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Icon(
        widget.icon,
        color: _hovered ? AppColors.neutralColorLight : AppColors.blackColor,
        size: 28,
      ),
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  final String currentLanguage;
  final ValueChanged<String?> onChanged;

  const _LanguageDropdown({
    required this.currentLanguage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColorDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: AppColors.secondaryColorDark,
          value: currentLanguage,
          items: const [
            DropdownMenuItem(value: 'ES', child: Text('ES', style: TextStyle(color: AppColors.whiteColor))),
            DropdownMenuItem(value: 'EN', child: Text('EN', style: TextStyle(color: AppColors.whiteColor))),
          ],
          onChanged: onChanged,
          iconEnabledColor: AppColors.whiteColor,
          style: const TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _CategoryMenuButton extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onTap;

  const _CategoryMenuButton({required this.isOpen, required this.onTap});

  @override
  State<_CategoryMenuButton> createState() => _CategoryMenuButtonState();
}

class _CategoryMenuButtonState extends State<_CategoryMenuButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _pressed ? 2 : 0, 0),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primaryColorLight60 : AppColors.secondaryColorDark,
            boxShadow: _pressed
                ? [
                    const BoxShadow(
                      color: AppColors.secondaryColorDark,
                      offset: Offset(0, 1),
                      blurRadius: 8,
                      spreadRadius: -1,
                    ),
                  ]
                : [
                    const BoxShadow(
                      color: AppColors.secondaryColorDark,
                      offset: Offset(-6, 6),
                      blurRadius: 14,
                    ),
                  ],
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu, color: AppColors.whiteColor),
              const SizedBox(width: 10),
              Text(
                'Categorías',
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
