import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:intl/intl.dart';
import 'package:mini_pos/core/utils/screen_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../flavors.dart';
import '../../translation/app_translation.dart';
import '../config/network/typedefs.dart';
import 'app_color.dart';
import 'app_log.dart';

///#region EmptyString Extension
/// Extension on nullable String to handle empty strings and URL formatting.
extension EmptyString on String? {
  String get ets {
    return this ?? "";
  }

  String? toImageUrl({String? baseUrl}) {
    var result = this == null || (this?.isEmpty ?? true)
        ? null
        : "${baseUrl ?? FConfig?.baseUrl}/${(this?.replaceAll("\\", "/"))}";
    return result;
  }
}

///#endregion EmptyString Extension

///#region ShimmerWidget Extension
/// Extension on Widget to apply a shimmer effect.
extension ShimmerWidget on Widget {
  Widget get toShimmer {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0.d),
      child: Shimmer.fromColors(
        baseColor: Get.isDarkMode ? Colors.white38 : Colors.grey.shade300,
        highlightColor: Get.isDarkMode ? Colors.white12 : Colors.grey.shade100,
        child: this,
      ),
    );
  }
}

///#endregion ShimmerWidget Extension

///#region ImagePngToUint8List Extension
/// Extension on String to convert PNG image asset paths to Uint8List.
extension ImagePngToUint8List on String {
  Future<Uint8List> get toUint8List async {
    ByteData data = await rootBundle.load(this);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: 100,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }
}

///#endregion

///#region ModelToJson Extension
/// Extension on dynamic types to convert objects to JSON.
extension ModelToJson on dynamic {
  JSON get toJSON {
    return const JsonDecoder().convert(jsonEncode(this));
  }
}

///#endregion

///#region IntToSeparateCommaExt Extension
/// Extension on int to add comma separators and convert to boolean.
extension IntToSeparateCommaExt on int {
  String get separateComma {
    return NumberFormat('#,##,000').format(this);
  }

  bool get boolFromInt {
    return this == 1;
  }
}

///#endregion

///#region ScreenUtil Extension
/// Extension on double for screen size calculations.
extension ScreenUtilDouble on double {
  double get d {
    final util = ScreenUtilHelper();
    var deviceDiagonal = sqrt(pow(Get.height, 2) + pow(Get.width, 2));
    var size = Get.size;
    var di = util.deviceDiagonal * (this / 1000);
    var dii = double.parse(di.roundToDouble().toStringAsFixed(2));
    var ar = (util.deviceArea / 4) * (this / 100000);
    return dii;
  }
}

extension ScreenUtilInt on int {
  double get d {
    final util = ScreenUtilHelper();
    var di = util.deviceDiagonal * (this.toDouble() / 1000);
    var ar = (util.deviceArea / 4) * (this.toDouble() / 100000);
    var dii = double.parse(di.roundToDouble().toStringAsFixed(2));
    return dii;
  }
}

///#endregion

///#region GetWidth Extension
/// Extension on Widget to get the rendered width.
extension GetWidth on Widget {
  double getWidth(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    return renderBox.size.width;
  }
}

///#endregion

///#region DateTimeExtension Extension
/// Extension on nullable DateTime for various date operations.
extension DateTimeExtension on DateTime? {
  DateTime? setTimeOfDay(TimeOfDay time) {
    if (this == null) return null;
    return DateTime(this!.year, this!.month, this!.day, time.hour, time.minute);
  }

  DateTime? setTime({
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliSeconds = 0,
    int microSeconds = 0,
  }) {
    if (this == null) return null;
    return DateTime(
      this!.year,
      this!.month,
      this!.day,
      hours,
      minutes,
      seconds,
      milliSeconds,
      microSeconds,
    );
  }

  DateTime? clearTime() {
    if (this == null) return null;
    return DateTime(this!.year, this!.month, this!.day, 0, 0, 0, 0, 0);
  }

  String get formatToString {
    return DateFormat("dd, MMMM, yyyy").format(this!.toLocal());
  }

  bool get isBirthday {
    if (this?.day == DateTime.now().day &&
        this?.month == DateTime.now().month) {
      return true;
    }
    return false;
  }

  String get formatDateMallToString {
    return DateFormat("dd/MM/yyyy").format(this!);
  }

  String get formatServicePeriod {
    return DateFormat("MMM dd, yyyy").format(this!);
  }

  String get formatTimeNoSpaceToString {
    var thisStr = toString().endsWith('Z') ? toString() : "${this}Z";
    var thisDate = DateTime.parse(thisStr);
    return DateFormat("d-MMMM-yyyy, h:mm a").format(thisDate.toLocal());
  }

  String formatDateTimeCustomFormat(String format, {ifNeedZone = true}) {
    var thisStr = toString().endsWith('Z') ? toString() : "${this}Z";
    var thisDate = DateTime.parse(thisStr);
    return DateFormat(
      format,
    ).format(ifNeedZone ? thisDate.toLocal() : this!.toLocal());
  }

  String get formatTimeToString {
    var thisStr = toString().endsWith('Z') ? toString() : "${this}Z";
    var thisDate = DateTime.parse(thisStr);
    return DateFormat("d, MMMM, yyyy ' | ' h:mm a").format(thisDate.toLocal());
  }

  String get formatTimeMallToString {
    var thisStr = toString().endsWith('Z') ? toString() : "${this}Z";
    var thisDate = DateTime.parse(thisStr);
    return DateFormat("MMM dd, yyyy ' - ' h:mm a").format(thisDate.toLocal());
  }

  String get formatMallToString {
    var thisStr = toString().endsWith('Z') ? toString() : "${this}Z";
    var thisDate = DateTime.parse(thisStr);
    return DateFormat("MMM dd, yyyy").format(thisDate.toLocal());
  }
}

extension SapDateFormatter on String? {
  /// Converts 'YYYYMMDD' to 'DD-MM-YYYY'
  String toDisplayDate() {
    // 1. Handle null or empty
    if (this == null || this!.isEmpty) return '--';

    // 2. Validate format (must be 8 digits)
    final date = this!;
    final dateRegex = RegExp(r'^\d{8}$');

    if (!dateRegex.hasMatch(date)) {
      return date; // Return original if it's not a standard SAP date
    }

    // 3. Extract and format
    final year = date.substring(0, 4);
    final month = date.substring(4, 6);
    final day = date.substring(6, 8);
    return '$year-$month-$day';
    //return "$day-$month-$year";
  }
}

extension KhmerDateFormat on DateTime {
  String get khmerWeekday {
    final weekday = DateFormat('EEEE').format(this); // English name
    switch (weekday) {
      case 'Monday':
        return 'ថ្ងៃចន្ទ';
      case 'Tuesday':
        return 'ថ្ងៃអង្គារ';
      case 'Wednesday':
        return 'ថ្ងៃពុធ';
      case 'Thursday':
        return 'ថ្ងៃព្រហស្បតិ៍';
      case 'Friday':
        return 'ថ្ងៃសុក្រ';
      case 'Saturday':
        return 'ថ្ងៃសៅរ៍';
      case 'Sunday':
        return 'ថ្ងៃអាទិត្យ';
      default:
        return weekday; // fallback
    }
  }
}

extension KhmerDateFormatt on DateTime {
  String formatDateTimeCustomFormatKM(String format, {bool ifNeedZone = true}) {
    var thisStr = toString().endsWith('Z') ? toString() : "${this}Z";
    var thisDate = DateTime.parse(thisStr);

    // Format normally (English)
    String formatted = DateFormat(
      format,
    ).format(ifNeedZone ? thisDate.toLocal() : thisDate.toUtc());

    // Replace weekday
    if (format.contains("EEEE")) {
      final engWeekday = DateFormat(
        "EEEE",
      ).format(ifNeedZone ? thisDate.toLocal() : thisDate.toUtc());
      formatted = formatted.replaceFirst(
        engWeekday,
        _mapWeekdayToKhmer(engWeekday),
      );
    }

    // Replace month (full and short)
    if (format.contains("MMMM")) {
      final engMonth = DateFormat(
        "MMMM",
      ).format(ifNeedZone ? thisDate.toLocal() : thisDate.toUtc());
      formatted = formatted.replaceFirst(engMonth, _mapMonthToKhmer(engMonth));
    } else if (format.contains("MMM")) {
      final engMonth = DateFormat(
        "MMM",
      ).format(ifNeedZone ? thisDate.toLocal() : thisDate.toUtc());
      formatted = formatted.replaceFirst(engMonth, _mapMonthToKhmer(engMonth));
    }

    return formatted;
  }

  String _mapWeekdayToKhmer(String eng) {
    switch (eng) {
      case 'Monday':
        return 'ថ្ងៃចន្ទ';
      case 'Tuesday':
        return 'ថ្ងៃអង្គារ';
      case 'Wednesday':
        return 'ថ្ងៃពុធ';
      case 'Thursday':
        return 'ថ្ងៃព្រហស្បតិ៍';
      case 'Friday':
        return 'ថ្ងៃសុក្រ';
      case 'Saturday':
        return 'ថ្ងៃសៅរ៍';
      case 'Sunday':
        return 'ថ្ងៃអាទិត្យ';
      default:
        return eng;
    }
  }

  String _mapMonthToKhmer(String eng) {
    switch (eng) {
      case 'January':
      case 'Jan':
        return 'មករា';
      case 'February':
      case 'Feb':
        return 'កុម្ភៈ';
      case 'March':
      case 'Mar':
        return 'មិនា';
      case 'April':
      case 'Apr':
        return 'មេសា';
      case 'May':
        return 'ឧសភា';
      case 'June':
      case 'Jun':
        return 'មិថុនា';
      case 'July':
      case 'Jul':
        return 'កក្កដា';
      case 'August':
      case 'Aug':
        return 'សីហា';
      case 'September':
      case 'Sep':
        return 'កញ្ញា';
      case 'October':
      case 'Oct':
        return 'តុលា';
      case 'November':
      case 'Nov':
        return 'វិច្ឆិកា';
      case 'December':
      case 'Dec':
        return 'ធ្នូ';
      default:
        return eng;
    }
  }
}

///#endregion

///#region SumExtension Extension
/// Extension on List to calculate the sum of a property.
extension SumExtension<T> on List<T> {
  double sum<N extends num>(N? Function(T element) selector) {
    return fold<N>(
      (0.0 as N),
      (previousValue, element) =>
          previousValue + (selector(element) ?? (0.0 as N)) as N,
    ).toDouble();
  }
}

///#endregion

///#region IsolateFunction Extension
/// Extension on Function to run in an isolate.
extension IsolateFunction on Function {
  Future<dynamic> runAsIsolate(List<dynamic> args) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      _isolateEntryPoint,
      receivePort.sendPort,
    );

    final sendPort = await receivePort.first as SendPort;
    final resultPort = ReceivePort();
    sendPort.send([this, args, resultPort.sendPort]);

    final result = await resultPort.first;
    isolate.kill();
    return result;
  }

  static void _isolateEntryPoint(SendPort sendPort) {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    port.listen((message) {
      final function = message[0] as Function;
      final args = message[1] as List;
      final resultPort = message[2] as SendPort;

      final result = Function.apply(function, args);
      resultPort.send(result);
    });
  }
}

///#endregion

///#region ImageBase64Extensions Extension
/// Extension on File to convert an image file to a Base64 string.
extension ImageBase64Extensions on File {
  Future<String> imageToBase64() async {
    final bytes = await readAsBytes();
    return base64Encode(bytes);
  }
}

///#endregion

///#region Base64ImageExtensions Extension
/// Extension on String to convert Base64 string to Image widget.
extension Base64ImageExtensions on String {
  Image base64ToImage() {
    return Image.memory(base64Decode(this), fit: BoxFit.cover);
  }
}

///#endregion

///#region Base64FileExtensions Extension
/// Extension on String to convert Base64 string to a File.
extension Base64FileExtensions on String {
  Future<File> base64ToFile() async {
    // Extract MIME type and extension if available
    final regex = RegExp(r'data:image/(\w+);base64,');
    String extension = 'jpg'; // Default extension if not found

    String base64String = this;
    if (regex.hasMatch(this)) {
      final match = regex.firstMatch(this);
      extension = match?.group(1) ?? 'jpg';
      base64String = split(',').last; // Strip MIME info if present
    }

    // Decode the Base64 string to bytes
    final bytes = base64Decode(base64String);

    // Generate a unique file name
    final directory = await getTemporaryDirectory();
    final fileName =
        'image_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}.$extension';
    final file = File(path.join(directory.path, fileName));

    // Write the bytes to the file
    await file.writeAsBytes(bytes);

    xPrettyLog(message: file.path);
    return file;
  }
}

///#endregion Base64FileExtensions Extension

///#region Base64ToFileSVG Extension
/// Extension on String to convert a Base64 string to an SVG [File].
extension Base64ToFileSVG on String {
  /// Converts a Base64-encoded SVG string to a [File].
  ///
  /// The input string must be in the format `data:image/svg+xml;base64,...`.
  Future<File> base64ToFileSVG() async {
    // Ensure the string starts with the SVG MIME type
    final svgRegex = RegExp(
      r'data:image/svg\+xml;base64,',
      caseSensitive: false,
    );

    // Check if the string matches the SVG format
    if (!svgRegex.hasMatch(this)) {
      throw FormatException(
        "Provided string is not a valid SVG Base64 encoded string.",
      );
    }

    // Remove the MIME info to get the actual Base64 string
    String base64String = split(',').last;

    // Decode the Base64 string to bytes
    final bytes = base64Decode(base64String);

    // Get the temporary directory and create a unique file name
    final directory = await getTemporaryDirectory();
    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.svg';
    final file = File(path.join(directory.path, fileName));

    // Write the bytes to the file
    await file.writeAsBytes(bytes);

    xPrettyLog(message: file.path);
    return file;
  }
}

///#endregion

///#region Asset to File Extension
/// Extension to convert asset paths to files.
extension AssetToFileExtensions on String {
  /// Converts the asset at the specified path to a File.
  ///
  /// This method loads the asset as bytes and saves it to a file
  /// in the specified directory. If no directory is provided,
  /// it defaults to the temporary directory.
  ///
  /// [fileName] is the name of the file to be created.
  /// [directory] is the optional Directory where the file will be saved.
  /// If not provided, the file will be saved in the temporary directory.
  Future<File> assetToFile(String fileName, {Directory? directory}) async {
    // Load asset as bytes
    final byteData = await rootBundle.load(this);
    final bytes = byteData.buffer.asUint8List();

    // If no directory is specified, use the temporary directory
    directory ??= await getTemporaryDirectory();

    // Create a file in the specified directory
    final file = File('${directory.path}/$fileName');

    // Write the bytes to the file
    await file.writeAsBytes(bytes);

    return file;
  }
}

///#endregion Asset to File Extension

///#region Asset to Base64 Extension
/// Extension to convert an asset path to a Base64-encoded string.
extension AssetToBase64Extension on String {
  /// Loads the asset at the specified path and encodes it as a Base64 string.
  ///
  /// This is useful for converting images or other binary files to Base64 format
  /// for embedding, storage, or sending over a network.
  ///
  /// Returns a Base64-encoded [String] of the asset data.
  Future<String> assetToBase64() async {
    // Load asset as bytes
    final byteData = await rootBundle.load(this);
    final bytes = byteData.buffer.asUint8List();

    // Encode bytes as Base64
    final base64String = base64Encode(bytes);

    return base64String;
  }
}

///#endregion Asset to Base64 Extension
///

/// ########################################################
/// #region Hex Color Extension
/// ########################################################

/// An extension on [String] to convert hex color codes to [Color] objects.
extension HexColorExtension on String {
  /// Converts a hex color string to a [Color] object.
  ///
  /// The string can be in various formats:
  /// - Short form: `"#fff"` (which expands to `"#ffffff"`)
  /// - Full form: `"#ffffff"`
  /// - Without the hash prefix: `"fff"` or `"ffffff"`
  ///
  /// Additionally, if the alpha channel is not provided, it defaults to `FF` (fully opaque).
  ///
  /// ### Example:
  /// ```dart
  /// "#fff".toColor();        // Returns Color(0xFFFFFFFF)
  /// "#abcdef".toColor();     // Returns Color(0xFFABCDEF)
  /// "123456".toColor();      // Returns Color(0xFF123456)
  /// ```
  ///
  /// Throws a [FormatException] if the string is not a valid hex color.
  Color toColor() {
    // #region Removing the hash sign if present
    String hexColor = replaceAll('#', '');
    // #endregion

    // #region Handle short form (#fff) by expanding it to #ffffff
    if (hexColor.length == 3) {
      hexColor = hexColor.split('').map((char) => char * 2).join();
    }
    // #endregion

    // #region Add alpha if not present (default to fully opaque)
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    // #endregion

    // Convert the hex string to a Color object
    return Color(int.parse(hexColor, radix: 16));
  }
}

/// ########################################################
/// #endregion
/// ########################################################

/// ########################################################
/// #region Color to Hex Extension
/// ########################################################

/// An extension on the [Color] class to convert a [Color] object to a hex color string.
extension ColorToHex on Color {
  /// Converts the [Color] object to a hex string.
  ///
  /// This method can return the hex string with or without the alpha channel:
  /// - If [includeAlpha] is set to `true` (default), the output will include the alpha channel.
  /// - If [includeAlpha] is set to `false`, the output will exclude the alpha channel.
  ///
  /// ### Example Usage:
  /// ```dart
  /// Color myColor = Color(0xffE54686);
  ///
  /// print(myColor.toHex()); // Output: "#ffe54686"
  /// print(myColor.toHex(includeAlpha: false)); // Output: "#e54686"
  /// ```
  ///
  /// ### Parameters:
  /// - [includeAlpha]: A boolean flag to include the alpha channel in the output. Default is `true`.
  ///
  /// ### Returns:
  /// - A [String] representing the hex color code.
  String toHex({bool includeAlpha = true}) {
    // #region Convert color to hex string
    return includeAlpha
        ? '#${value.toRadixString(16).padLeft(8, '0')}'
        : '#${value.toRadixString(16).substring(2).padLeft(6, '0')}';
    // #endregion
  }
}

/// ########################################################
/// #endregion
/// ########################################################

extension TranslateExtension on String {
  /// Get the translation for a specific locale
  String translate(Locale locale) {
    return AppTranslation().keys[locale.toString()]?[this] ?? this;
  }
}

/// This is useful for debugging or replicating requests outside of your application.
extension CurlCommandExtension on http.BaseRequest {
  /// Generates a cURL command that replicates the HTTP request.
  String get getCURL {
    // Start with the HTTP method and URL
    String curlCommand = 'curl -X $method \'$url\'';

    // Add request headers
    headers.forEach((key, value) {
      curlCommand += ' -H "${_escape(key)}: ${_escape(value)}"';
    });

    // If the request is a MultipartRequest, add fields and files
    if (this is http.MultipartRequest) {
      final multipartRequest = this as http.MultipartRequest;

      // Add form fields
      multipartRequest.fields.forEach((key, value) {
        curlCommand += ' -F "${_escape(key)}=${_escape(value)}"';
      });

      // Add files
      for (final file in multipartRequest.files) {
        final filename = file.filename ?? 'file';
        curlCommand += ' -F "${file.field}=@$filename"';
      }
    }
    // If the request is a standard Request with a body, include the body
    else if (this is http.Request) {
      final normalRequest = this as http.Request;

      if (normalRequest.body.isNotEmpty) {
        // Add content type if not present
        if (!headers.containsKey('Content-Type')) {
          curlCommand += ' -H "Content-Type: application/json"';
        }
        curlCommand += " --data '${_escapeSingleQuotes(normalRequest.body)}'";
      }
    }

    return curlCommand;
  }

  /// Escapes double quotes in headers
  String _escape(String input) => input.replaceAll('"', r'\"');

  /// Escapes single quotes for safe use in shell command
  String _escapeSingleQuotes(String input) => input.replaceAll("'", "'\\''");
}

extension ApiEndpointExtension on String {
  /// Extracts everything after '/api/' if found, otherwise returns full path.
  String get apiEndpointPath {
    final uri = Uri.tryParse(this);
    if (uri == null) return '';

    final segments = uri.pathSegments;
    final apiIndex = segments.indexOf('api');

    final path = (apiIndex != -1 && apiIndex + 1 < segments.length)
        ? segments.sublist(apiIndex + 1).join('/')
        : segments.join('/');

    return path + (uri.hasQuery ? '?${uri.query}' : '');
  }

  /// Converts the endpoint path to a hashtag-safe format
  String get apiHashtag {
    return '#${apiEndpointPath.replaceAll('/', '_').replaceAll('?', '_').replaceAll('&', '_').replaceAll('=', '_')}';
  }
}

// Extension to convert endpoint path to valid hashtag format
extension StringHashtag on String {
  String get apiEndpointHashtag {
    return replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  }
}

extension FileSizeExtension on num {
  String toReadableSize() {
    if (this < 1024) {
      return '${toStringAsFixed(2)} KB';
    } else if (this < 1024 * 1024) {
      final sizeInMB = this / 1024;
      return '${sizeInMB.toStringAsFixed(2)} MB';
    } else if (this < 1024 * 1024 * 1024) {
      final sizeInGB = this / (1024 * 1024);
      return '${sizeInGB.toStringAsFixed(2)} GB';
    } else {
      final sizeInTB = this / (1024 * 1024 * 1024);
      return '${sizeInTB.toStringAsFixed(2)} TB';
    }
  }
}

extension StringExtensions on String {
  String toPhoneFormat() {
    // Ensure the string only contains digits
    String cleanedString = replaceAll(RegExp(r'[^0-9]'), '');

    // Check if the string length is valid for a phone number
    if (cleanedString.length != 8 && cleanedString.length != 9) {
      return this; // Return the original string if it's not a valid length
    }

    // Replace leading 0 with +855(0)
    if (cleanedString.startsWith('0')) {
      cleanedString = '+855$cleanedString';
    }

    // Format the string as a phone number
    if (cleanedString.length == 10) {
      // For 9-digit numbers after adding +855
      return '${cleanedString.substring(0, 5)} ${cleanedString.substring(5, 8)} ${cleanedString.substring(8)}';
    } else if (cleanedString.length == 9) {
      // For 8-digit numbers after adding +855
      return '${cleanedString.substring(0, 5)} ${cleanedString.substring(5, 7)} ${cleanedString.substring(7)}';
    }

    return this;
  }
}

extension ColorBlend on Color {
  /// Lightens the current color by blending it with white.
  /// The [opacity] determines the weight of the current color in the blend.
  /// An opacity of 0.0 will result in white, and an opacity of 1.0 will result in the original color.
  /// Defaults to 1.0 if no opacity is provided.
  Color lightenColor([double opacity = 0.5]) {
    assert(
      opacity >= 0.0 && opacity <= 1.0,
      'Opacity must be between 0.0 and 1.0',
    );
    return Color.alphaBlend(this.withValues(alpha: opacity), Colors.white);
  }

  /// Darkens the current color by blending it with black.
  /// The [opacity] determines the weight of the current color in the blend.
  /// An opacity of 0.0 will result in black, and an opacity of 1.0 will result in the original color.
  /// Defaults to 1.0 if no opacity is provided.
  Color darkenColor([double opacity = 0.5]) {
    assert(
      opacity >= 0.0 && opacity <= 1.0,
      'Opacity must be between 0.0 and 1.0',
    );
    return Color.alphaBlend(this.withValues(alpha: opacity), Colors.black);
  }
}

extension DateTimeExtensions on DateTime {
  DateTime get firstDayOfMonth => DateTime(this.year, this.month, 1);

  DateTime get lastDayOfMonth =>
      DateTime(this.year, this.month + 1, 1).subtract(const Duration(days: 1));

  DateTime get previousMonth => DateTime(this.year, this.month - 1, this.day);

  DateTime get nextMonth => DateTime(this.year, this.month + 1, this.day);
}

extension DistinctList<T> on List<T> {
  List<T> get distinct {
    final uniqueItems = <String, T>{};
    for (var item in this) {
      // Assuming each item has a unique property, like a path
      if (item is File) {
        uniqueItems[item.path] = item;
      }
    }
    return uniqueItems.values.toList();
  }
}

extension EnumUtils<T extends Enum> on List<T> {
  T fromString(String name, {required T fallback}) {
    return firstWhere((e) => e.name == name, orElse: () => fallback);
  }
}

extension FileExtension on String {
  String get extension {
    // Split the string by '.' and get the last part
    final parts = split('.');

    // If there's only one part, it means there's no extension
    if (parts.length <= 1) {
      return '';
    }

    // Return the last part, which is the file extension
    return parts.last;
  }
}

extension StringExtension on String {
  String get capitalize {
    if (this.isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}

// Telegram Link
extension TelegramPhoneExtension on String {
  //todo add check telegram link or not For when null;"";old(https://t.me/)
  String toTelegramLink(String dialCode) {
    final cleaned = replaceAll(RegExp(r'\D'), '');
    final normalized = cleaned.startsWith('0') ? cleaned.substring(1) : cleaned;
    final code = dialCode.replaceAll('+', ''); // Just in case + is passed
    return 'https://t.me/+$code$normalized';
  }

  String toLocalPhoneNumber() {
    final onlyDigits = replaceAll(RegExp(r'\D'), '');
    if (onlyDigits.length >= 9) {
      final lastNine = onlyDigits.substring(onlyDigits.length - 8);
      return '0$lastNine';
    }
    return this; // fallback to original if invalid
  }
}

/// Extension on [double?] to provide convenient formatting
/// for prices and currency display.
extension DoublePriceExtension on double? {
  /// Converts the [double?] to a price string with fixed decimal places.
  ///
  /// If the value is `null`, returns `'0.00'` by default.
  ///
  /// You can customize the number of decimal places by setting [fractionDigits].
  ///
  /// Example:
  /// ```dart
  /// double? price = 12.5;
  /// print(price.toPriceString()); // "12.50"
  /// ```
  String toPriceString({int fractionDigits = 2}) {
    if (this == null) return '0.00';
    return this!.toStringAsFixed(fractionDigits);
  }

  /// Converts the [double?] to a currency string, including a currency [symbol].
  ///
  /// If the value is `null`, returns `'0.00'` prefixed by the [symbol].
  ///
  /// You can also customize the number of decimal places using [fractionDigits].
  ///
  /// Example:
  /// ```dart
  /// double? price = 12.5;
  /// print(price.toCurrency()); // "$12.50"
  /// print(price.toCurrency(symbol: '€')); // "€12.50"
  /// ```
  String toCurrency({String symbol = '\$', int fractionDigits = 1}) {
    return "$symbol ${toPriceString(fractionDigits: fractionDigits)}";
  }
}

extension EmployeeImageExtension on String {
  String get employeeImageUrl =>
      "https://portal.chipmong.com/empl/images/$this.png";
}

extension PackageInfoExtension on PackageInfo {
  String get appVersion => 'v${version} | b${buildNumber}';

  static Future<String> getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.appVersion.toUpperCase();
  }
}
