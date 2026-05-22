import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../gen/assets.gen.dart';
import '../../translation/app_locale.dart';
import '../utils/app_color.dart';
import '../utils/app_ext.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

import '../utils/app_style.dart';
import '../utils/text_size.dart';

class ConnectionService extends GetxService with WidgetsBindingObserver {
  final Connectivity _connectivity = Connectivity();

  Timer? _timer;
  OverlayEntry? _overlayEntry;

  bool _isOffline = false;
  bool _isPaused = false;
  bool _checking = false;

  int _failCount = 0;
  static const int _failThreshold = 2; // retry before showing modal

  // ---------------- INIT ----------------
  Future<ConnectionService> init() async {
    WidgetsBinding.instance.addObserver(this);

    // Listen to network changes
    _connectivity.onConnectivityChanged.listen((_) {
      _delayedRecheck();
    });

    _startTimer();
    return this;
  }

  // ---------------- LIFECYCLE ----------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _isPaused = true;
    }

    if (state == AppLifecycleState.resumed) {
      _isPaused = false;

      // ⏳ give OS time to restore network
      Future.delayed(const Duration(seconds: 1), _checkNow);
    }
  }

  // ---------------- TIMER ----------------
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isPaused) return;
      _checkNow();
    });
  }

  void _delayedRecheck() {
    Future.delayed(const Duration(milliseconds: 800), _checkNow);
  }

  // ---------------- CHECK LOGIC ----------------
  Future<void> _checkNow() async {
    if (_checking) return;
    _checking = true;

    final hasConnection = await _hasInternet();

    if (!hasConnection) {
      _failCount++;

      if (_failCount >= _failThreshold && !_isOffline) {
        _isOffline = true;
        _showOverlay();
      }
    } else {
      _failCount = 0;
      if (_isOffline) {
        _isOffline = false;
        _removeOverlay();
      }
    }

    _checking = false;
  }

  // ---------------- REAL INTERNET CHECK ----------------
  Future<bool> _hasInternet() async {
    try {
      // 1️⃣ connectivity state
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) return false;

      // 2️⃣ real socket test
      final socket = await Socket.connect(
        '8.8.8.8',
        53,
        timeout: const Duration(seconds: 3),
      );
      socket.destroy();
      return true;
    } catch (_) {
      return false;
    }
  }

  // ---------------- UI ----------------
  void _showOverlay() {
    if (_overlayEntry != null) return;
    if (Get.overlayContext == null) return;

    // _overlayEntry = OverlayEntry(builder: (context) {
    //
    // };
    // showOfflineModal();

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return _showOfflineOverlay();
      },
    );

    Overlay.of(Get.overlayContext!).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // ---------------- CLEANUP ----------------
  void disposeService() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _removeOverlay();
    if (Get.currentRoute == 'offline_dialog') {
      Get.back();
    }
  }
}

Widget _showOfflineOverlay() {
  return Material(
    color: Colors.white,
    child: SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SvgPicture.asset(Assets.svg.lostWifi, width: 120.d),
          xSpaceV(size: 20.d),
          Text(
            AppLocale.connectionLost.tr,
            style: XTextStyle.regular(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          xSpaceV(size: 8.d),

          Text(
            AppLocale.connectionLostDesc.tr,
            style: XTextStyle.regular(),
            textAlign: TextAlign.center,
          ),

          xSpaceV(size: 24.d),
        ],
      ),
    ),
  );
}
