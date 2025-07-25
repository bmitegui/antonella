import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/product_info_widget.dart';
import 'package:flutter/material.dart';

class ProductsBySubcategoryWidget extends StatefulWidget {
  final String subCategory;
  final List<ProductEntity> products;

  const ProductsBySubcategoryWidget(
      {super.key, required this.subCategory, required this.products});

  @override
  State<ProductsBySubcategoryWidget> createState() =>
      _ProductsBySubcategoryWidgetState();
}

class _ProductsBySubcategoryWidgetState
    extends State<ProductsBySubcategoryWidget> {
  final ScrollController _scrollController = ScrollController();

  final double _scrollAmount = 200.0;

  bool _showLeftArrow = false;
  bool _showRightArrow = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateArrowVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateArrowVisibility();
    });
  }

  void _updateArrowVisibility() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;

    setState(() {
      _showLeftArrow = position.pixels > 0;
      _showRightArrow = position.pixels < position.maxScrollExtent;
    });
  }

  void _scrollRight() {
    final newOffset = (_scrollController.offset + _scrollAmount)
        .clamp(0.0, _scrollController.position.maxScrollExtent);
    _scrollController.animateTo(
      newOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollLeft() {
    final newOffset = (_scrollController.offset - _scrollAmount)
        .clamp(0.0, _scrollController.position.maxScrollExtent);
    _scrollController.animateTo(
      newOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: CustomTitle(title: widget.subCategory),
      ),
      const SizedBox(height: 8),
      Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(bottom: 16),
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: widget.products.map((product) {
                return ProductInfoWidget(productEntity: product);
              }).toList())),
        ),
        if (_showLeftArrow)
          Positioned(
            left: 0,
            top: 0,
            bottom: 30,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: _scrollLeft,
              ),
            ),
          ),
        if (_showRightArrow)
          Positioned(
            right: 0,
            top: 0,
            bottom: 30,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: _scrollRight,
                //color: Colors.white,
              ),
            ),
          ),
      ]),
    ]);
  }
}
