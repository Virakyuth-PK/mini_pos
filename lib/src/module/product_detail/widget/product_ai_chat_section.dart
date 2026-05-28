import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mini_pos/core/global_widgets/x_button.dart';
import 'package:mini_pos/core/utils/app_style.dart';
import 'package:mini_pos/core/utils/text_size.dart';
import 'package:mini_pos/translation/app_locale.dart';

import '../../../../core/global_widgets/dash_divider.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../gen/assets.gen.dart';
import 'product_ai_service.dart';

class ProductAiChatSection extends StatefulWidget {
  const ProductAiChatSection({
    super.key,
    required this.productName,
    required this.productInfo,
    required this.onReady,
  });

  final String productName;
  final String productInfo;
  final void Function(void Function(String value) send)? onReady;

  @override
  State<ProductAiChatSection> createState() => ProductAiChatSectionState();
}

class ProductAiChatSectionState extends State<ProductAiChatSection> {
  late final ProductAiService aiService;

  final TextEditingController controller = TextEditingController();
  final List<_ChatMessage> messages = [];
  final ScrollController scrollController = ScrollController();

  bool loading = false;

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.onReady?.call(sendMessage);

    aiService = ProductAiService(
      productName: widget.productName,
      productInfo: widget.productInfo,
    );
  }

  Future<void> sendMessage([String? customMessage]) async {
    final text = customMessage ?? controller.text.trim();

    if (text.isEmpty || loading) return;

    setState(() {
      messages.add(_ChatMessage(text: text, isUser: true));
      messages.add(_ChatMessage(
        text: text,
        isUser: false,
        isLoading: true,
      ));

      loading = true;

      if (customMessage == null) {
        controller.clear();
      }
    });

    scrollToBottom();

    try {
      final answer = await aiService.ask(text);

      setState(() {
        messages.removeWhere((element) => element.isLoading == true);
      });

      setState(() {
        messages.add(_ChatMessage(text: answer, isUser: false));
      });

      scrollToBottom();
    } catch (e) {
      setState(() {
        messages.add(
          _ChatMessage(text: 'AI error: $e', isUser: false),
        );
      });

      scrollToBottom();
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .max,
      children: [
        Padding(
          padding: .symmetric(horizontal: 20),
          child: Row(
            spacing: 20,
            children: [
              SvgPicture.asset(Assets.svg.siAiIcon, width: 20),
              Text(
                "Ask Product Assistance",
                style: XTextStyle.bold(color: AppColor.primaryColor),
              ),
              Expanded(
                child: DashedDivider(
                  color: AppColor.primaryColor.withValues(alpha: .5),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: messages.isNotEmpty ? _buildChatUI() : _buildSuggestion(),
        ),
      ],
    );
  }

  _buildChatUI() {
    return Scrollbar(radius: .circular(5),
      child: ListView.separated(
        controller: scrollController,
        shrinkWrap: true,
        padding: .fromLTRB(20, 0, 20, 100),
        itemBuilder: (context, index) {
          final message = messages[index];
          return Align(
            alignment: message.isUser
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Row(
              mainAxisSize: .min,
              mainAxisAlignment: message.isUser
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              spacing: message.isUser ? 0 : 5,
              crossAxisAlignment: .end,
              children: [
                if (message.isUser == false)
                  Container(
                    decoration: xBoxDecoration(
                      color: AppColor.primaryColor,
                      shape: .circle,
                    ),
                    padding: .all(5),
                    child: SvgPicture.asset(
                      Assets.svg.siAiIcon,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                Flexible(fit: FlexFit.loose,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: xBoxDecoration(
                      color: message.isUser
                          ? AppColor.primaryColor
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                        bottomLeft: message.isUser
                            ? const Radius.circular(10)
                            : const Radius.circular(5),
                        bottomRight: message.isUser
                            ? const Radius.circular(5)
                            : const Radius.circular(10),
                      ),
                    ),
                    child: message.isLoading
                        ? const ThinkingDots()
                        : Text(
                      message.text,
                      style: XTextStyle.regular(
                        color: message.isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => xSpaceV(size: 5),
        itemCount: messages.length,
      ),
    );
  }

  _buildSuggestion() {
    return Padding(
      padding: EdgeInsets.only(bottom: 100, left: 20, right: 20),
      child: Column(
        mainAxisSize: .min,
        mainAxisAlignment: .end,
        children: [
          Container(
            decoration: xBoxDecoration(
              hasShadow: true,
              hasBorder: true,
              borderColor: AppColor.primaryColor.withValues(alpha: .5),
              borderWidth: 1,
              color: AppColor.primaryColor.withValues(alpha: .02),
            ),
            padding: .all(10),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 10,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    SvgPicture.asset(Assets.svg.suggestedAiIcon, width: 20),
                    Text(
                      "Suggested Question",
                      style: XTextStyle.bold(color: AppColor.primaryColor),
                    ),
                  ],
                ),
                Text(
                  "💡Ask me anything else or use the buttons above!",
                  style: XTextStyle.regular(),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    _suggestedQuestion("Recipe Ideas"),
                    _suggestedQuestion("How to keep fresh"),
                    _suggestedQuestion("Nutrition Facts"),
                    _suggestedQuestion("Where is it from?"),
                    _suggestedQuestion("Calories?"),
                    _suggestedQuestion("Expired date"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _suggestedQuestion(String value) {
    return XButton(
      onPress: () => sendMessage(value),
      child: Container(
        decoration: xBoxDecoration(
          hasBorder: true,
          borderColor: AppColor.primaryColor.withValues(alpha: .1),
          color: Colors.white,
          borderWidth: 1,
        ),
        padding: .symmetric(vertical: 5, horizontal: 10),
        child: Text(value, style: XTextStyle.regular(fontSize: 10)),
      ),
    );
  }
}

class _ChatMessage {
  _ChatMessage({
    required this.text,
    required this.isUser,
    this.isLoading = false,
  });

  final String text;
  final bool isUser;
  final bool isLoading;
}
class ThinkingDots extends StatefulWidget {
  const ThinkingDots({super.key});

  @override
  State<ThinkingDots> createState() => _ThinkingDotsState();
}

class _ThinkingDotsState extends State<ThinkingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildDot(int index) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = (controller.value - (index * 0.2))
            .clamp(0.0, 1.0);

        final offset = (value < 0.5)
            ? value * 12
            : (1 - value) * 12;

        return Transform.translate(
          offset: Offset(0, -offset),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildDot(0),
          buildDot(1),
          buildDot(2),
        ],
      ),
    );
  }
}
