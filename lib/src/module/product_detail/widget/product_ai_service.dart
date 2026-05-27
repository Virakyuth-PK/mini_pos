import 'package:firebase_ai/firebase_ai.dart';

class ProductAiService {
  ProductAiService({required this.productName, required this.productInfo});

  final String productName;
  final String productInfo;

  late final GenerativeModel _model = FirebaseAI.vertexAI().generativeModel(
    model: 'gemini-2.5-pro',
      systemInstruction: Content.text(systemInstruction));

  ChatSession? _chat;

  ChatSession get chat {
    _chat ??= _model.startChat();
    return _chat!;
  }

  String get systemInstruction => '''
You are a smart product assistant for customer support.

Your job is to answer customer questions related ONLY to this product.

Product Name:
$productName

Product Information:
$productInfo

Instructions:
- Answer clearly, naturally, and helpfully.
- Keep answers short, simple, and customer-friendly.
- Maximum line should not more than 15 lines.
- Use the provided product information as the main source of truth.
- If the answer exists in the provided product information, prioritize that answer.
- If the provided product information does not contain enough details:
  - You may use general knowledge or internet research to help answer.
  - Clearly mention that the information is from external/internet sources.
  - Do NOT make up fake references or links.
  - Example:
    "Based on general internet sources, this ingredient is commonly used for..."
- If you are not confident about the answer, say:
  "I’m not fully sure about that information."
- If the customer asks something unrelated to this product, politely respond:
  "I can only help with questions related to this product."
- Never answer harmful, unsafe, medical, legal, or inappropriate questions as facts.
- Do not invent product specifications, ingredients, certifications, or health claims.
- If product data conflicts with internet information, prioritize the provided product information.
- Format answers in a clean and readable way.
- Use bullet points when helpful.
''';

  Future<String> ask(String question) async {
    final response = await chat.sendMessage(Content.text(question));
    return response.text ?? 'No response';
  }
}
