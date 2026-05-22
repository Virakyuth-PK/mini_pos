import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../gen/assets.gen.dart';
import '../../translation/app_locale.dart';
import 'app_ext.dart';

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'app_style.dart';
import 'text_size.dart';

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

    _overlayEntry = OverlayEntry(builder: (_) => const _NoInternetOverlay());

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
  }
}

class _NoInternetOverlay extends StatelessWidget {
  const _NoInternetOverlay();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // dim background
        Container(color: Colors.black.withOpacity(0.5)),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 40.d),
                  margin: EdgeInsets.all(50.d),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.d),
                    child: Row(
                      spacing: 15.d,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.gif.noInternet.path, width: 50.d),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.connectionLost.tr,
                                style: XTextStyle.regular(
                                  color: const Color(0xffEF6C00),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              xSpaceV(size: 8.d),
                              Text(
                                AppLocale.connectionLostDesc.tr,
                                style: XTextStyle.regular(),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
