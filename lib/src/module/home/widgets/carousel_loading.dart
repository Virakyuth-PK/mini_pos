import 'package:flutter/material.dart';
import 'package:mini_pos/core/utils/app_color.dart';
import 'package:mini_pos/core/utils/app_ext.dart';
import 'package:mini_pos/core/utils/app_style.dart';

class CarouselLoading extends StatelessWidget {
  const CarouselLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final horizontalInset = width.isFinite ? width * 0.05 : 20.d;

        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: -18.d,
              top: 18.d,
              bottom: 18.d,
              child: _CarouselPeek(width: 42.d),
            ),
            Positioned(
              right: -18.d,
              top: 18.d,
              bottom: 18.d,
              child: _CarouselPeek(width: 42.d),
            ),
            Positioned.fill(
              left: horizontalInset,
              right: horizontalInset,
              child: const _CarouselSlide(),
            ),
          ],
        );
      },
    );
  }
}

class _CarouselSlide extends StatelessWidget {
  const _CarouselSlide();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: xBoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.d),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.08),
            blurRadius: 28.d,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.d),
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: AppColor.white).toShimmer),
            Positioned(
              left: 22.d,
              right: 60.d,
              top: 28.d,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.d,
                children: [
                  _LoadingLine(width: 140.d, height: 14.d),
                  _LoadingLine(width: 220.d, height: 28.d),
                  _LoadingLine(width: 175.d, height: 12.d),
                ],
              ),
            ),
            Positioned(
              right: 18.d,
              top: 24.d,
              child: Container(
                width: 74.d,
                height: 74.d,
                decoration: xBoxDecoration(
                  color: AppColor.primaryColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
              ).toShimmer,
            ),
            Positioned(
              left: 22.d,
              right: 22.d,
              bottom: 36.d,
              child: Row(
                children: [
                  Expanded(child: _LoadingLine(height: 9.d)),
                  xSpaceH(size: 8.d),
                  _LoadingLine(width: 44.d, height: 9.d),
                ],
              ),
            ),
            Positioned(
              bottom: 10.d,
              right: 10.d,
              child: Container(
                width: 48.d,
                height: 24.d,
                decoration: xBoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10.d),
                ),
              ).toShimmer,
            ),
          ],
        ),
      ),
    );
  }
}

class _CarouselPeek extends StatelessWidget {
  final double width;

  const _CarouselPeek({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: xBoxDecoration(
        color: AppColor.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(12.d),
      ),
    ).toShimmer;
  }
}

class _LoadingLine extends StatelessWidget {
  final double? width;
  final double height;

  const _LoadingLine({this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: xBoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(50.d),
      ),
    ).toShimmer;
  }
}
