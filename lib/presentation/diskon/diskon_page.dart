import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icso_pos/core/assets/assets.gen.dart';
import 'package:icso_pos/core/constants/colors.dart';
import 'package:icso_pos/core/extensions/build_context_ext.dart';
import 'package:icso_pos/data/datasources/auth_local_datasource.dart';
import 'package:icso_pos/data/models/response/auth_response_model.dart';
import 'package:icso_pos/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:icso_pos/presentation/auth/login_page.dart';
import 'package:icso_pos/presentation/home/home_page.dart';
import 'package:icso_pos/presentation/home/widgets/nav_item.dart';
import 'package:icso_pos/presentation/layout/diskon_layout.dart';
import 'package:icso_pos/presentation/layout/home_layout.dart';
import 'package:icso_pos/presentation/mobile/home/home_page_mobile.dart';

class DiskonPage extends StatefulWidget {
  const DiskonPage({super.key});

  @override
  State<DiskonPage> createState() => _DiskonPageState();
}

class _DiskonPageState extends State<DiskonPage> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text(
        'Halaman Diskon Tablet',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }


}
