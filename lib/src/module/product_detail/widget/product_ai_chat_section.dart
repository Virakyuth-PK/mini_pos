import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_color.dart';
import 'product_ai_service.dart';

class ProductAiChatSection extends StatefulWidget {
  const ProductAiChatSection({
    super.key,
    required this.productName,
    required this.productInfo,
  });

  final String productName;
  final String productInfo;

  @override
  State<ProductAiChatSection> createState() => _ProductAiChatSectionState();
}

class _ProductAiChatSectionState extends State<ProductAiChatSection> {
  late final ProductAiService aiService;

  final TextEditingController controller = TextEditingController();
  final List<_ChatMessage> messages = [];

  bool loading = false;

  @override
  void initState() {
    super.initState();

    aiService = ProductAiService(
      productName: widget.productName,
      productInfo: widget.productInfo,
    );
  }

  Future<void> sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty || loading) return;

    setState(() {
      messages.add(_ChatMessage(text: text, isUser: true));
      loading = true;
      controller.clear();
    });

    try {
      final answer = await aiService.ask(text);

      setState(() {
        messages.add(_ChatMessage(text: answer, isUser: false));
      });
    } catch (e) {
      setState(() {
        messages.add(
          _ChatMessage(
            text: 'AI error: $e',
            isUser: false,
          ),
        );
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
padding: .symmetric(vertical: 20),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.smart_toy_outlined),
              SizedBox(width: 8),
              Text(
                'Ask AI about this product',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 260,
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg.isUser
                          ? AppColor.primaryColor.withOpacity(.1)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.text),
                  ),
                );
              },
            ),
          ),

          if (loading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: LinearProgressIndicator(borderRadius: .all(Radius.circular(5)),),
            ),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onSubmitted: (_) => sendMessage(),
                  decoration: InputDecoration(
                    hintText: 'Ask how to use, ingredient, origin...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),

                    prefixIcon: Icon(Icons.star_border_purple500_rounded),

                    suffixIcon: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ChatMessage {
  _ChatMessage({
    required this.text,
    required this.isUser,
  });

  final String text;
  final bool isUser;
}