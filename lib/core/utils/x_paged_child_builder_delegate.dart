import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'app_ext.dart';
import 'app_style.dart';
import 'center_loading.dart';
import 'empty_data.dart';
import 'loading_shimmer.dart';

class XPagedChildBuilderDelegate<ItemType>
    extends PagedChildBuilderDelegate<ItemType> {
  XPagedChildBuilderDelegate({
    required super.itemBuilder,
    super.firstPageErrorIndicatorBuilder,
    super.newPageErrorIndicatorBuilder,
    super.firstPageProgressIndicatorBuilder,
    super.newPageProgressIndicatorBuilder,
    super.noItemsFoundIndicatorBuilder,
    super.noMoreItemsIndicatorBuilder,
    super.animateTransitions,
    super.transitionDuration,
  });

  factory XPagedChildBuilderDelegate.list({
    required ItemWidgetBuilder<ItemType> itemBuilder,
    WidgetBuilder? firstPageErrorIndicatorBuilder,
    WidgetBuilder? newPageErrorIndicatorBuilder,
    WidgetBuilder? firstPageProgressIndicatorBuilder,
    WidgetBuilder? newPageProgressIndicatorBuilder,
    WidgetBuilder? noItemsFoundIndicatorBuilder,
    WidgetBuilder? noMoreItemsIndicatorBuilder,
    bool animateTransitions = false,
    Duration transitionDuration = const Duration(milliseconds: 250),
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    bool isNeedShowFullScreenNoItemsFoundIndicatorBuilder = false,
  }) => XPagedChildBuilderDelegate(
    itemBuilder: itemBuilder,
    firstPageErrorIndicatorBuilder:
        firstPageErrorIndicatorBuilder ??
        (context) => EmptyData(
          isNeedShowFullScreen:
              isNeedShowFullScreenNoItemsFoundIndicatorBuilder,
        ),
    newPageErrorIndicatorBuilder: newPageErrorIndicatorBuilder,
    firstPageProgressIndicatorBuilder:
        firstPageProgressIndicatorBuilder ??
        (context) => LoadingShimmer.list(scrollDirection: scrollDirection),
    newPageProgressIndicatorBuilder:
        newPageProgressIndicatorBuilder ??
        (context) => ClipRRect(
          borderRadius: BorderRadius.circular(10..d),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 100.0,
              decoration: xBoxDecoration(color: Colors.white, hasShadow: true),
            ),
          ),
        ),
    noItemsFoundIndicatorBuilder:
        noItemsFoundIndicatorBuilder ??
        (context) => EmptyData(
          isNeedShowFullScreen:
              isNeedShowFullScreenNoItemsFoundIndicatorBuilder,
        ),
    noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder,
    animateTransitions: animateTransitions,
    transitionDuration: transitionDuration,
  );

  factory XPagedChildBuilderDelegate.grid({
    required ItemWidgetBuilder<ItemType> itemBuilder,
    WidgetBuilder? firstPageErrorIndicatorBuilder,
    WidgetBuilder? newPageErrorIndicatorBuilder,
    WidgetBuilder? firstPageProgressIndicatorBuilder,
    WidgetBuilder? newPageProgressIndicatorBuilder,
    WidgetBuilder? noItemsFoundIndicatorBuilder,
    WidgetBuilder? noMoreItemsIndicatorBuilder,
    bool animateTransitions = false,
    Duration transitionDuration = const Duration(milliseconds: 250),
    int crossAxisCount = 2,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    double childAspectRatio = 1.0,
    bool isNeedShowFullScreenNoItemsFoundIndicatorBuilder = false,
  }) => XPagedChildBuilderDelegate(
    itemBuilder: itemBuilder,
    firstPageErrorIndicatorBuilder:
        firstPageErrorIndicatorBuilder ??
        (context) => EmptyData(
          isNeedShowFullScreen:
              isNeedShowFullScreenNoItemsFoundIndicatorBuilder,
        ),
    newPageErrorIndicatorBuilder: newPageErrorIndicatorBuilder,
    firstPageProgressIndicatorBuilder:
        firstPageProgressIndicatorBuilder ??
        (context) => LoadingShimmer.grid(crossAxisCount: crossAxisCount),
    newPageProgressIndicatorBuilder:
        newPageProgressIndicatorBuilder ??
        (context) => ClipRRect(
          borderRadius: BorderRadius.circular(10..d),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              decoration: xBoxDecoration(
                color: Colors.white,
                hasShadow: true,
                borderRadius: BorderRadius.circular(10..d),
              ),
            ),
          ),
        ),
    noItemsFoundIndicatorBuilder:
        noItemsFoundIndicatorBuilder ??
        (context) => EmptyData(
          isNeedShowFullScreen:
              isNeedShowFullScreenNoItemsFoundIndicatorBuilder,
        ),
    noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder,
    animateTransitions: animateTransitions,
    transitionDuration: transitionDuration,
  );
}
