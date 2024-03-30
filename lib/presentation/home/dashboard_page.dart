import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icso_pos/core/assets/assets.gen.dart';
import 'package:icso_pos/core/constants/colors.dart';
import 'package:icso_pos/core/extensions/build_context_ext.dart';
import 'package:icso_pos/data/datasources/auth_local_datasource.dart';
import 'package:icso_pos/data/models/response/auth_response_model.dart';
import 'package:icso_pos/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:icso_pos/presentation/auth/login_page.dart';
import 'package:icso_pos/presentation/diskon/diskon_page.dart';
import 'package:icso_pos/presentation/home/home_page.dart';
import 'package:icso_pos/presentation/home/widgets/nav_item.dart';
import 'package:icso_pos/presentation/layout/diskon_layout.dart';
import 'package:icso_pos/presentation/layout/home_layout.dart';
import 'package:icso_pos/presentation/mobile/home/home_page_mobile.dart';
import 'package:icso_pos/presentation/setting/pages/sync_data_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const DiskonPage(),
    // const Center(child: Text('This is page 1')),
    // const Center(child: Text('This is page 2')),
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
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double availableWidth = constraints.maxWidth;
            double availableHeight = constraints.maxHeight;
            if(availableWidth < 600) {
              return BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.indigoAccent,
                  // called when one tab is selected
                  onTap: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  items: const[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.feed), label: 'Feed'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: 'Favorites'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings')
                  ]
              );
            } else {
              return Row(
                children: [
                  SingleChildScrollView(
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(16.0)),
                      child: SizedBox(
                        height: context.deviceHeight - 20.0,
                        child: ColoredBox(
                          color: AppColors.primary,
                          child: Column(
                            children: [
                              // NavItem(
                              //   iconPath: Assets.icons.homeResto.path,
                              //   isActive: _selectedIndex == 0,
                              //   onTap: () => _onItemTapped(0),
                              // ),
                              // NavItem(
                              //   iconPath: Assets.icons.discount.path,
                              //   isActive: _selectedIndex == 1,
                              //   onTap: () => _onItemTapped(1),
                              // ),
                              // NavItem(
                              //   iconPath: Assets.icons.dashboard.path,
                              //   isActive: _selectedIndex == 2,
                              //   onTap: () => _onItemTapped(2),
                              // ),
                              // NavItem(
                              //   iconPath: Assets.icons.setting.path,
                              //   isActive: _selectedIndex == 3,
                              //   onTap: () => _onItemTapped(3),
                              // ),
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
                                // child: NavItem(
                                //   iconPath: Assets.icons.logout.path,
                                //   isActive: false,
                                //   onTap: () {
                                //     context
                                //         .read<LogoutBloc>()
                                //         .add(const LogoutEvent.logout());
                                //   },
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _pages[_selectedIndex],
                  ),
                ],
              );
            }
          },
        )

      ),
    );
  }


}
