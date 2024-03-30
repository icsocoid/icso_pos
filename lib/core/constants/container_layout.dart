import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icso_pos/core/assets/assets.gen.dart';
import 'package:icso_pos/core/constants/colors.dart';
import 'package:icso_pos/core/extensions/build_context_ext.dart';
import 'package:icso_pos/data/datasources/auth_local_datasource.dart';
import 'package:icso_pos/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:icso_pos/presentation/auth/login_page.dart';
import 'package:icso_pos/presentation/diskon/diskon_page.dart';
import 'package:icso_pos/presentation/home/home_page.dart';
import 'package:icso_pos/presentation/home/widgets/nav_item.dart';
import 'package:icso_pos/presentation/layout/home_layout.dart';
import 'package:icso_pos/presentation/setting/pages/sync_data_page.dart';

class ContainerLayout extends StatefulWidget {
    const ContainerLayout({super.key});

    // final Widget mobileLayout;
    // final Widget tabletLayout;

    // const ContainerLayout({
    //     super.key,
    //     required this.mobileLayout,
    //     required this.tabletLayout
    // });

    @override
    State<ContainerLayout> createState() => _ContainerLayout();

}

class _ContainerLayout extends State<ContainerLayout> {

    int _selectedIndex = 0;

    final List<Widget> _pages = [
        const HomeLayout(),
      // const Center(child: Text('This is page 1')),

        const DiskonPage(),
        const Center(child: Text('This is page 3')),
        // const Center(child: Text('This is page 4')),
        const SyncDataPage(),
        // const ManagePrinterPage(),
        // const SettingsPage(),
    ];

    void _onItemTapped(int index) {
        _selectedIndex = index;
        setState(() {});
    }

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: Scaffold(
              drawer: constraints.maxWidth <= 640? Drawer():null,
              appBar: constraints.maxWidth <= 640? AppBar(
                iconTheme: IconThemeData(color: AppColors.white),
                backgroundColor: AppColors.primary,
                title: const Text(
                  'Home',
                  style: TextStyle(
                    color: AppColors.white
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: IconButton(
                        iconSize: 20,
                        onPressed: () {},
                        icon: Icon(Icons.notifications_none, color: AppColors.white,)
                    ),
                  )
                ],
                centerTitle: true,
                bottom: PreferredSize(preferredSize: Size.fromHeight(40.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:
                          <Widget>[
                            TextButton(onPressed: (){}, child: const Text('Makanan', style: TextStyle(color: Colors.white),), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),),
                            TextButton(onPressed: (){}, child: const Text('Minuman', style: TextStyle(color: Colors.white))),
                            TextButton(onPressed: (){}, child: const Text('Snack', style: TextStyle(color: Colors.white))),
                            TextButton(onPressed: (){}, child: const Text('Lain-lain', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      ),
                    )
                ),
              ):null,
              body: Row(
                children: [
                  if(constraints.maxWidth >= 640)
                    Visibility(
                      visible: false,
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.horizontal(right: Radius.circular(16.0)),
                        child: SizedBox(
                          height: context.deviceHeight - 10.0,
                          child: ColoredBox(
                            color: AppColors.primary,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  NavItem(
                                    iconPath: Assets.icons.home.path,
                                    isActive: _selectedIndex == 0,
                                    onTap: () => _onItemTapped(0),
                                    nameLabel: '  Home  ',
                                  ),
                                  NavItem(
                                    iconPath: Assets.icons.discount.path,
                                    isActive: _selectedIndex == 1,
                                    onTap: () => _onItemTapped(1),
                                    nameLabel: 'Discount',
                                  ),
                                  NavItem(
                                    iconPath: Assets.icons.dashboard.path,
                                    isActive: _selectedIndex == 2,
                                    onTap: () => _onItemTapped(2),
                                    nameLabel: ' Report ',
                                  ),
                                  NavItem(
                                    iconPath: Assets.icons.setting.path,
                                    isActive: _selectedIndex == 3,
                                    onTap: () => _onItemTapped(3),
                                    nameLabel: ' Setting ',
                                  ),
                                  BlocListener<LogoutBloc, LogoutState>(
                                    listener: (context, state) {
                                      state.maybeMap(
                                        orElse: () {},
                                        error: (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(e.message),
                                              backgroundColor: AppColors.red,
                                            ),
                                          );
                                        },
                                        success: (value) {
                                          AuthLocalDataSource().removeAuthData();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Logout success'),
                                              backgroundColor: AppColors.primary,
                                            ),
                                          );
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (context) {
                                                return const LoginPage();
                                              }));
                                        },
                                      );
                                    },
                                    child: NavItem(
                                      iconPath: Assets.icons.logout.path,
                                      isActive: false,
                                      onTap: () {
                                        context
                                            .read<LogoutBloc>()
                                            .add(const LogoutEvent.logout());
                                      },
                                      nameLabel: ' Logout ',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _pages[_selectedIndex],
                    ),
                ],
              ),
            ),
          );
        }
      );
    }
}

