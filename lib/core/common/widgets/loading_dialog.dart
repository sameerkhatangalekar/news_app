import 'dart:async';

import 'package:flutter/material.dart';

import 'package:news_app/core/utils/loading_controller.dart';

final class LoadingDialog {
  static final LoadingDialog _instance = LoadingDialog._();

  LoadingDialog._();

  factory LoadingDialog() => _instance;

  LoadingScreenController? _loadingScreenController;

  void close() {
    _loadingScreenController?.close();
    _loadingScreenController = null;
  }

  void show({required BuildContext context, required String text}) {
    if (_loadingScreenController?.update(text) ?? false) {
      return;
    } else {
      _loadingScreenController = _showOverlay(context: context, text: text);
    }
  }

  LoadingScreenController _showOverlay(
      {required BuildContext context, required String text}) {
    final textController = StreamController<String>();

    textController.add(text);

    final overlayState = Overlay.of(context);

    final overlayEntry = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black.withAlpha(105),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          constraints: const BoxConstraints(
            maxWidth: 200,
            minWidth: 200,
            maxHeight: 200,
            minHeight: 200,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 8,
              ),
              StreamBuilder(
                stream: textController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data as String,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        )),
      );
    });

    overlayState.insert(overlayEntry);
    return LoadingScreenController(close: () {
      textController.close();
      overlayEntry.remove();
      return true;
    }, update: (text) {
      textController.add(text);
      return true;
    });
  }
}
