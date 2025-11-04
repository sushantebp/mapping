import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:mapping/core/core.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const MyAppBar());
  }
}
