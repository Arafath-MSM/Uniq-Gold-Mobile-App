import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_loader.dart';
import '../../../../shared/widgets/network_image_view.dart';
import '../../../catalog/domain/entities/woo_product.dart';
import '../../../catalog/presentation/controllers/catalog_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    const _PromoBar(),
                    _HeaderRow(
                      onMenuTap: () => scaffoldKey.currentState?.openDrawer(),
                      onSearchTap: () => context.push('/search'),
                      onProfileTap: () => context.go('/profile'),
                      onWishlistTap: () => context.push('/wishlist'),
                    ),
                    const SizedBox(height: 6),
                    const _HeroSection(),
                    const SizedBox(height: 14),
                    _StoryCard(
                      title: 'تأنّقي في الرفاهية بأسعار معقولة دون المساومة على الجودة',
                      body:
                          'استمتعي بجمال الذهب عيار 18 والإحساس الحقيقي في كل قطعة مصممة لأنوثة ناعمة وأناقة يومية.',
                    ),
                    const SizedBox(height: 20),
                    const _SectionTitle(title: 'SHOP BY CATEGORY'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                        childAspectRatio: 0.74,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          _CategoryCard(
                            title: 'NECKLACES',
                            imageAssetPath: 'assets/necklaces.jpg',
                            onTap: () => context.go('/catalog?category=necklaces'),
                          ),
                          _CategoryCard(
                            title: 'BRACELETS',
                            imageAssetPath: 'assets/bracelts.jpg',
                            onTap: () => context.go('/catalog?category=braclets'),
                          ),
                          _CategoryCard(
                            title: 'EARRINGS',
                            imageAssetPath: 'assets/earring.jpg',
                            onTap: () => context.go('/catalog?category=earrings'),
                          ),
                          _CategoryCard(
                            title: 'RINGS',
                            imageAssetPath: 'assets/rings.jpg',
                            onTap: () => context.go('/catalog?category=rings'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const _SectionTitle(title: 'NEW ARRIVED'),
                    _NewArrivalsSection(
                      onProductTap: (WooProduct product) {
                        context.push('/product/${product.id}');
                      },
                    ),
                    const SizedBox(height: 26),
                    const _FooterSection(),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 92,
            child: _FloatingActions(
              onContactTap: () => context.go('/profile'),
            ),
          ),
        ],
      ),
      drawer: _SideMenuDrawer(
        onHomeTap: () {
          Navigator.of(context).pop();
          context.go('/home');
        },
        onShopNowTap: () {
          Navigator.of(context).pop();
          context.go('/catalog');
        },
        onGalleryTap: () {
          Navigator.of(context).pop();
        },
        onGiftCardTap: () {
          Navigator.of(context).pop();
        },
        onContactTap: () {
          Navigator.of(context).pop();
          context.go('/profile');
        },
      ),
    );
  }
}

class _PromoBar extends StatelessWidget {
  const _PromoBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: const Center(
        child: Text(
          '✨ ضيفونا في سنابلنا الجديد ✨',
          style: TextStyle(
            color: Color(0xFFF6D565),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.onMenuTap,
    required this.onSearchTap,
    required this.onProfileTap,
    required this.onWishlistTap,
  });

  final VoidCallback onMenuTap;
  final VoidCallback onSearchTap;
  final VoidCallback onProfileTap;
  final VoidCallback onWishlistTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      child: Column(
        children: <Widget>[
          const Text(
            'AR  EN',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(Icons.menu, size: 24),
              ),
              IconButton(
                onPressed: onSearchTap,
                icon: const Icon(Icons.search, size: 24),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/ug_logo.png',
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              IconButton(
                onPressed: onProfileTap,
                icon: const Icon(Icons.person_outline, size: 22),
              ),
              IconButton(
                onPressed: onWishlistTap,
                icon: const Icon(Icons.favorite_border, size: 22),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  IconButton(
                    onPressed: () => context.go('/cart'),
                    icon: const Icon(Icons.shopping_bag_outlined, size: 22),
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE35C56),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SideMenuDrawer extends StatelessWidget {
  const _SideMenuDrawer({
    required this.onHomeTap,
    required this.onShopNowTap,
    required this.onGalleryTap,
    required this.onGiftCardTap,
    required this.onContactTap,
  });

  final VoidCallback onHomeTap;
  final VoidCallback onShopNowTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onGiftCardTap;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.82,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 28, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'HOME MENU',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 6,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 20,
                      height: 20,
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              _DrawerMenuItem(
                title: 'HOME PAGE',
                highlighted: true,
                onTap: onHomeTap,
              ),
              const SizedBox(height: 10),
              _DrawerMenuItem(
                title: 'SHOP NOW',
                onTap: onShopNowTap,
              ),
              _DrawerMenuItem(
                title: 'GALLERY',
                onTap: onGalleryTap,
              ),
              _DrawerMenuItem(
                title: 'GIFT CARD',
                onTap: onGiftCardTap,
              ),
              _DrawerMenuItem(
                title: 'CONTACT US',
                onTap: onContactTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  const _DrawerMenuItem({
    required this.title,
    required this.onTap,
    this.highlighted = false,
  });

  final String title;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: highlighted ? const Color(0xFF4B4F57) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            title,
            style: TextStyle(
              color: highlighted ? Colors.white : AppColors.secondary,
              fontSize: 14,
              letterSpacing: 4,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: AspectRatio(
              aspectRatio: 0.82,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    'assets/hero_image.png',
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          Color(0x29000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFFF3F0EA),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: const Text(
              'تأنّقي في الرفاهية بأسعار معقولة دون المساومة على الجودة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              body,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.imageAssetPath,
    required this.onTap,
  });

  final String title;
  final String imageAssetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.asset(
                imageAssetPath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF858177),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrivalCard extends StatelessWidget {
  const _ArrivalCard({
    required this.product,
    required this.onTap,
  });

  final WooProduct product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 190,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Container(
                  color: Colors.white,
                  child: product.imageUrl.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.diamond_outlined,
                            size: 38,
                            color: AppColors.textMuted,
                          ),
                        )
                      : NetworkImageView(imageUrl: product.imageUrl),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              Formatters.formatPriceLabel(
                product.price,
                minorUnit: product.currencyMinorUnit,
              ),
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewArrivalsSection extends ConsumerStatefulWidget {
  const _NewArrivalsSection({required this.onProductTap});

  final ValueChanged<WooProduct> onProductTap;

  @override
  ConsumerState<_NewArrivalsSection> createState() => _NewArrivalsSectionState();
}

class _NewArrivalsSectionState extends ConsumerState<_NewArrivalsSection> {
  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.58);
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll(int itemCount) {
    _autoScrollTimer?.cancel();
    if (itemCount <= 1) {
      return;
    }

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || !_pageController.hasClients) {
        return;
      }

      final int nextPage = (_currentPage + 1) % itemCount;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(catalogProductsProvider);

    return SizedBox(
      height: 260,
      child: productsAsync.when(
        data: (products) {
          final List<WooProduct> arrivals = products.take(8).toList();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _startAutoScroll(arrivals.length);
            }
          });

          if (arrivals.isEmpty) {
            return const Center(child: Text('No new arrivals yet'));
          }

          return Column(
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  padEnds: false,
                  itemCount: arrivals.length,
                  onPageChanged: (int index) {
                    if (mounted) {
                      setState(() {
                        _currentPage = index;
                      });
                    }
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final product = arrivals[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 16 : 9,
                        right: index == arrivals.length - 1 ? 16 : 9,
                      ),
                      child: _ArrivalCard(
                        product: product,
                        onTap: () => widget.onProductTap(product),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(arrivals.length, (int index) {
                  final bool isActive = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 28 : 10,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF7D7D7D)
                          : const Color(0xFFD8D8D8),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  );
                }),
              ),
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (_, __) => const Center(
          child: Text('Unable to load new arrivals'),
        ),
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  static const List<IconData> _icons = <IconData>[
    Icons.public,
    Icons.camera_alt_outlined,
    Icons.music_note,
    Icons.chat_bubble_outline,
    Icons.send_outlined,
    Icons.mail_outline,
  ];

  static const List<String> _links = <String>[
    'Customer Services',
    'Return & Exchange',
    'Shipping Policy',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF1F1F1),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 30),
      child: Column(
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            children: _icons.map((IconData icon) {
              return Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFDADDE0),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: AppColors.secondary),
              );
            }).toList(),
          ),
          const SizedBox(height: 22),
          ..._links.map((String text) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
            );
          }),
          const SizedBox(height: 14),
          const Text(
            'Copyright©2026 UniqGold. All rights reserved.',
            style: TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _FloatingActions extends StatelessWidget {
  const _FloatingActions({required this.onContactTap});

  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: TextButton(
            onPressed: onContactTap,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Contact us',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 54,
          height: 54,
          decoration: const BoxDecoration(
            color: AppColors.whatsapp,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.call, color: Colors.white, size: 26),
        ),
      ],
    );
  }
}
