import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.4),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
