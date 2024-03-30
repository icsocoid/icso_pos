import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icso_pos/presentation/home/home_page.dart';
import 'package:icso_pos/presentation/mobile/home/home_page_mobile.dart';

class HomeLayout extends StatefulWidget {
    const HomeLayout({super.key});

    @override
    State<HomeLayout> createState() => _HomeLayout();
}

class _HomeLayout extends State<HomeLayout> {

    @override
    Widget build(BuildContext context) {
        return LayoutBuilder(
            builder: (context, constraints) {
                if (constraints.maxWidth < 640) {
                    return HomePageMobile();
                } else {
                    return HomePage();
                }
            },
        );
    }
}