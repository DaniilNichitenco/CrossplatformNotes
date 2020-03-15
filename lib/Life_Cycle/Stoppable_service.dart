import 'package:flutter/material.dart';

abstract class StoppabelService {
  bool _serviceStoped = false;
  bool get serviceStoped => _serviceStoped;

  @mustCallSuper
  void stop() {
    _serviceStoped = true;
  }

  @mustCallSuper
  void start() {
    _serviceStoped = false;
  }
}