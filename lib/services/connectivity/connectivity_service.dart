import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isDialogShowing = false;
  BuildContext? _dialogContext;

  void checkConnectivity(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      _showNoInternetDialog(context);
    }
  }

  void _showNoInternetDialog(BuildContext context) {
    if (_isDialogShowing) return;

    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        _dialogContext = dialogContext;
        return AlertDialog(
          title: const Text('Sem Conexão com a Internet'),
          content: const Text('Este aplicativo requer uma conexão com a internet para funcionar.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tentar Novamente'),
              onPressed: () async {
                Navigator.of(_dialogContext!).pop();
                _isDialogShowing = false;
                _dialogContext = null;
                checkConnectivity(context);
              },
            ),
          ],
        );
      },
    ).then((_) {
      _isDialogShowing = false;
      _dialogContext = null;
    });
  }

  void listenForConnectivityChanges(BuildContext context) {
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (!result.contains(ConnectivityResult.none)) {
        if (_isDialogShowing && _dialogContext != null) {
          Navigator.of(_dialogContext!).pop();
        }
      } else {
        if (!_isDialogShowing) {
          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
             _showNoInternetDialog(context);
          }
        }
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
