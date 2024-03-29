// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FailedWidget extends StatelessWidget {
  DioException error;
  FailedWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Text(
        error.message!,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
