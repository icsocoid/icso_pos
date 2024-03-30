import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icso_pos/core/constants/container_layout.dart';
import 'package:icso_pos/presentation/diskon/diskon_page.dart';
import 'package:icso_pos/presentation/home/dashboard_page.dart';
import 'package:icso_pos/presentation/mobile/diskon/diskon_page_mobile.dart';
import 'package:icso_pos/presentation/mobile/home/home_page_mobile.dart';

class DiskonLayout extends StatefulWidget {
  const DiskonLayout({super.key});

  @override
  State<DiskonLayout> createState() => _DiskonLayout();
}

class _DiskonLayout extends State<DiskonLayout> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return DiskonPageMobile();
        } else {
          return DiskonPage();
        }
      },
    );
  }
}