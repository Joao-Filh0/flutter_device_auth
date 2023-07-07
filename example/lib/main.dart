
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_device_auth/flutter_device_auth.dart';
import 'package:flutter_device_auth/local_auth_enum.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAvailable = false;
  final _biometricPlugin = LocalAuth();

  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    AuthStatus result = AuthStatus.notAvailable;
    result = await _biometricPlugin.biometric(
        title: 'Plugin Test',
        subTitle: 'Desbloqueie seu celular',
        buttonText: 'Usar Padrão');

    print("STATUS : ${result.name}");

    setState(() {
      isAvailable = result == AuthStatus.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Text(
                isAvailable ? 'Autenticado com Sucesso' : 'Nao Autenticado'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => initPlatformState(),
            child: Icon(isAvailable ? Icons.lock_open_rounded : Icons.lock),
          )),
    );
  }
}
