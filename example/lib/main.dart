import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_deferred_deeplink/flutter_deferred_deeplink.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deferredLink = 'Waiting for link...';

  @override
  void initState() {
    super.initState();
    _loadDeferredLink();
  }

  void _loadDeferredLink() async {
    final link = await FlutterDeferredDeeplink().getDeferredDeepLink();
    setState(() {
      _deferredLink = link ?? 'No deferred link found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Deferred Link Example')),
        body: Center(child: Text(_deferredLink)),
      ),
    );
  }
}
