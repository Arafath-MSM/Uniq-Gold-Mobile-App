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

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late final TextEditingController _controller;
  Timer? _debounce;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() {
          _query = value.trim();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultsAsync = _query.isEmpty
        ? const AsyncValue<List<WooProduct>>.data(<WooProduct>[])
        : ref.watch(searchProductsProvider(_query));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 12, 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      onChanged: _onChanged,
                      decoration: InputDecoration(
                        hintText: 'Search for products...',
                        hintStyle: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        suffixIcon: _query.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _controller.clear();
                                  setState(() {
                                    _query = '';
                                  });
                                },
                                icon: const Icon(Icons.close, size: 20),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: _query.isEmpty
                  ? const SizedBox.shrink()
                  : resultsAsync.when(
                      data: (results) {
                        if (results.isEmpty) {
                          return const Center(
                            child: Text(
                              'No products found',
                              style: TextStyle(color: AppColors.textMuted),
                            ),
                          );
                        }

                        return ListView.separated(
                          itemCount: results.length + 1,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == results.length) {
                              return InkWell(
                                onTap: () => context.go('/catalog'),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: Text(
                                      'SEE ALL PRODUCTS...',
                                      style: TextStyle(
                                        color: AppColors.textMuted,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }

                            final product = results[index];
                            return _SearchResultTile(product: product);
                          },
                        );
                      },
                      loading: () => const AppLoader(),
                      error: (_, __) => const Center(
                        child: Text('Unable to search products'),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({required this.product});

  final WooProduct product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/product/${product.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 54,
                height: 54,
                child: product.imageUrl.isEmpty
                    ? Container(
                        color: const Color(0xFFF4F1EA),
                        child: const Icon(Icons.diamond_outlined, size: 22),
                      )
                    : NetworkImageView(imageUrl: product.imageUrl),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    Formatters.formatPriceLabel(
                      product.price,
                      minorUnit: product.currencyMinorUnit,
                    ),
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
