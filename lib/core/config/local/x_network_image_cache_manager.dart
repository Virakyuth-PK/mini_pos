import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../flavors.dart';
import '../../utils/app_log.dart';

class XNetworkImageCacheManager extends CacheManager {
  static final instance = XNetworkImageCacheManager._();

  XNetworkImageCacheManager._()
    : super(
        Config(
          FConfig.cacheManagerKey,
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 100,
          repo: JsonCacheInfoRepository(databaseName: FConfig.cacheManagerKey),
          fileSystem: IOFileSystem(FConfig.cacheManagerKey),
          fileService: LoggingHttpFileService(),
        ),
      );

  @override
  Future<File> getSingleFile(
    String url, {
    String? key,
    Map<String, String>? headers,
  }) async {
    final cleanedUrl = removeQueryParameters(url); // Clean URL
    final file = await super.getSingleFile(
      cleanedUrl,
      key: cleanedUrl,
      headers: headers,
    );

    // Log message to be printed only once
    String msg = '[CacheManager 📁]';
    xPrettyLog(
      message: msg,
      customMessage1LineStart: 'File path: \n${file.path}',
    );

    return file;
  }

  @override
  Future<FileInfo?> getFileFromCache(
    String key, {
    bool ignoreMemCache = false,
  }) async {
    String msg = '[CacheManager 🔍]\n Checking cache for key';
    final cleanedKey = removeQueryParameters(
      key,
    ); // Clean key before checking cache
    final file = await super.getFileFromCache(
      cleanedKey,
      ignoreMemCache: ignoreMemCache,
    );

    if (file != null) {
      msg = '$msg\n✅\nImage loaded from cache,';
    } else {
      msg = '$msg\n🆕\nImage not in cache,';
    }
    // xPrettyLog(message: msg, customMessage1LineStart: 'key: $key');

    return file;
  }

  @override
  Future<File> putFile(
    String url,
    Uint8List fileBytes, {
    String? key,
    String? eTag,
    Duration maxAge = const Duration(days: 30),
    String fileExtension = 'file',
  }) async {
    final cleanedUrl = removeQueryParameters(url); // Clean URL
    final cleanedKey =
        key ?? cleanedUrl; // Use cleaned URL as the key if no key is provided

    // Log information for debugging (message printed only once)
    String msg = '➕\nAdding file to cache with cleaned key,';

    msg = '$msg\n➕\nFile size: \n${fileBytes.length} bytes';
    xPrettyLog(
      message: msg,
      customMessage1LineStart: 'cleanedKey: $cleanedKey',
    );

    try {
      // Attempt to put the file into the cache
      return await super.putFile(
        cleanedUrl,
        fileBytes,
        key: cleanedKey,
        eTag: eTag,
      );
    } catch (e) {
      // Log error if putFile fails (message printed only once)
      msg = '$msg\n❌\nFailed to add file to cache: \n$e';
      xPrettyLog(
        message: msg,
        customMessage1LineStart: 'cleanedKey: $cleanedKey',
      );
      rethrow; // Re-throw the error to propagate it
    }
  }

  @override
  Future<void> emptyCache() async {
    super.emptyCache();
    xPrettyLog(message: 'CacheManager 🧹 Cache cleared');
  }
}

class LoggingHttpFileService extends HttpFileService {
  @override
  Future<FileServiceResponse> get(String url, {Map<String, String>? headers}) {
    // Log message printed only once for the download process
    // String msg = '[CacheManager 🌐]\nDownloading file from URL: \n$url';
    // xPrettyLog(message: msg);

    return super.get(url, headers: headers);
  }
}

String removeQueryParameters(String url) {
  final uri = Uri.parse(url);
  return uri.replace(query: '').toString(); // Remove query parameters
}
