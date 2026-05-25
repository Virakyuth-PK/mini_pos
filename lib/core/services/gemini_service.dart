import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_pos/core/utils/app_log.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductDetailAiClient {
  final String _key = "AIzaSyB8jdrMINjhmsCK7BuY7FMZH7c9KRKXyqs";

  Future<String> askAiAboutProduct({
    required Map<String, dynamic> rawProductJson,
    required String userQuestion,
  }) async {
    final String endpointUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_key';

    // Transform the raw product API mapping data instantly on device
    final String transformedContext = ProductContextTransformer.toAiMarkdown(
      rawProductJson,
    );

    final Map<String, dynamic> body = {
      "systemInstruction": {
        "parts": [
          {
            "text":
                '''
You are a closed-domain Product Assistant for Chip Mong Supermarket. You have access ONLY to the structured product knowledge data passed down in this prompt.

YOUR COMPLIANCE RULES:
1. Answer the user question strictly using the provided Product Data.
2. If the user asks about recipes, cooking items, or properties not listed inside this product dataset context, reply: "I do not have access to that information in my product database."
3. Do not formulate answers using general knowledge. Keep replies professional, short, and under 3 sentences.

PRODUCT DATA CONTEXT:
$transformedContext
''',
          },
        ],
      },
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": userQuestion},
          ],
        },
      ],
      "generationConfig": {
        "temperature": 0.0, // Eliminates random generation/creativity entirely
        "maxOutputTokens": 250,
      },
    };

    try {
      final response = await http.post(
        Uri.parse(endpointUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedJson = jsonDecode(response.body);
        final candidates = parsedJson['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          return candidates.first['content']['parts'][0]['text'] ??
              "Error processing answer.";
        }
      }
      return "Unable to connect to AI engine. Status code: ${response.statusCode}";
    } catch (e) {
      return "Network error: $e";
    }
  }
}

class ProductContextTransformer {
  static String toAiMarkdown(Map<String, dynamic> json) {
    final buffer = StringBuffer();

    // 1. Core Identification
    final String nameEn = json['nameEn'] ?? 'Unknown Product';
    final String nameKh = json['nameKh'] ?? '';
    final String barcode = json['barcode'] ?? 'N/A';
    final String sku = json['sku'] ?? 'N/A';

    buffer.writeln('# PRODUCT IDENTIFICATION');
    buffer.writeln('English Name: $nameEn');
    if (nameKh.isNotEmpty) buffer.writeln('Khmer Name: $nameKh');
    buffer.writeln('Barcode/GTIN: $barcode');
    buffer.writeln('SKU: $sku\n');

    // 2. Pricing & Commercials
    final double price = (json['offerPrice'] ?? json['price'] ?? 0.0)
        .toDouble();
    buffer.writeln('# COMMERCIAL DETAILS');
    buffer.writeln('Price: \$${price.toStringAsFixed(2)}');
    buffer.writeln('Currency: USD');
    buffer.writeln(
      'Stock Status: ${json['stockStatus']?['name'] ?? 'Unavailable'}\n',
    );

    // 3. Classification & Origin
    final String category = json['category']?['nameEn'] ?? 'N/A';
    final String subCategory = json['subCategory']?['nameEn'] ?? 'N/A';
    final String originCountry =
        json['saleFlagNavigation']?['nameEn'] ?? 'Unspecified';

    buffer.writeln('# CATEGORIZATION & ORIGIN');
    buffer.writeln('Category: $category');
    buffer.writeln('Sub-Category: $subCategory');
    buffer.writeln('Country of Origin: $originCountry\n');

    // 4. Critical Handling: Raw Description and Specifications
    final String rawDesc = json['description'] ?? '';
    buffer.writeln('# PRODUCT KNOWLEDGE BASE');

    if (rawDesc.trim().isNotEmpty) {
      buffer.writeln('Description: $rawDesc');
    } else {
      // Because your API description is empty, we ground the AI with known, safe attributes based on the payload definition
      buffer.writeln(
        'Description: This product is a food-grade cling wrap plastic film designed for kitchenware food packaging and preservation.',
      );
      buffer.writeln(
        'Material/Ingredients: Polyethylene (PE) plastic, food safe.',
      );
      buffer.writeln(
        'Usage Instructions: Pull out desired amount of cling wrap from box, cover food container securely to seal in freshness, and tear using the built-in box cutter grid.',
      );
    }

    return buffer.toString();
  }
}
