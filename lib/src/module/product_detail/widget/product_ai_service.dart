import 'package:firebase_ai/firebase_ai.dart';

class ProductAiService {
  ProductAiService({required this.productName, required this.productInfo});

  final String productName;
  final String productInfo;

  late final GenerativeModel _model = FirebaseAI.vertexAI().generativeModel(
    model: 'gemini-2.5-pro',
    systemInstruction: Content.text('''
You are a product assistant.
Answer only questions related to this product.
  
Product name: $productName
Product information:
$productInfo

Rules:
- If user asks unrelated question, politely say you can only answer about this product.
- Keep answer short and easy to understand.
- If you do not know, say you do not know.
'''),
  );

  ChatSession? _chat;

  ChatSession get chat {
    _chat ??= _model.startChat();
    return _chat!;
  }

  Future<String> ask(String question) async {
    final response = await chat.sendMessage(Content.text(question));
    return response.text ?? 'No response';
  }
}
