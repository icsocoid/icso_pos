import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icso_pos/core/extensions/build_context_ext.dart';
import 'package:icso_pos/core/extensions/int_ext.dart';
import 'package:icso_pos/core/extensions/string_ext.dart';
import 'package:icso_pos/data/datasources/auth_local_datasource.dart';
import 'package:icso_pos/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:icso_pos/presentation/auth/login_page.dart';
import 'package:icso_pos/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:icso_pos/presentation/home/bloc/local_product/local_product_bloc.dart';
import 'package:icso_pos/presentation/home/confirm_payment_page.dart';
import 'package:icso_pos/presentation/home/models/product_category.dart';
import 'package:icso_pos/presentation/home/models/product_model.dart';
import 'package:icso_pos/presentation/home/widgets/column_button.dart';
import 'package:icso_pos/presentation/home/widgets/custom_tab_bar.dart';
import 'package:icso_pos/presentation/home/widgets/home_title.dart';
import 'package:icso_pos/presentation/home/widgets/order_menu.dart';
import 'package:icso_pos/presentation/home/widgets/product_card.dart';
import 'package:icso_pos/presentation/setting/pages/sync_data_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  // List<ProductModel> searchResults = [];

  // final List<ProductModel> tesProducts = [
  // ProductModel(
  //   image: Assets.images.menu1.path,
  //   name: 'Express Bowl Ayam Rica',
  //   category: ProductCategory.food,
  //   price: 32000,
  //   stock: 10),
  // ProductModel(
  //   image: Assets.images.menu2.path,
  //   name: 'Crispy Black Pepper Sauce',
  //   category: ProductCategory.food,
  //   price: 36000,
  //   stock: 10)
  // ];

  @override
  void initState() {
    // searchResults = products;
    context
        .read<LocalProductBloc>()
        .add(const LocalProductEvent.getLocalProduct());
    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear();
    // if (index == 0) {
    //   searchResults = products;
    // } else {
    //   searchResults = products
    //       .where((e) => e.category.index.toString().contains(index.toString()))
    //       .toList();
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // if (products.isEmpty) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    return Hero(
      tag: 'confirmation_screen',
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HomeTitle(
                          controller: searchController,
                          onChanged: (value) {
                            // searchResults = products
                            //     .where((e) => e.name
                            //         .toLowerCase()
                            //         .contains(value.toLowerCase()))
                            //     .toList();
                            // setState(() {});
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTabBar(
                          tabTitles: const [
                            'Semua',
                            'Makanan',
                            'Minuman',
                            'Snack'
                          ],
                          initialTabIndex: 0,
                          tabViews: [
                            // if (searchResults.isEmpty)
                            //   const Padding(
                            //     padding: EdgeInsets.only(top: 80.0),
                            //     child: _IsEmpty(),
                            //   )
                            // else
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(orElse: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loading: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loaded: (products) {
                                    if (products.isEmpty) {
                                      return const Center(
                                        child: Text('No Items'),
                                      );
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: products.length,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.85,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 30.0,
                                        mainAxisSpacing: 30.0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                            data: products[index],
                                            onCartButton: () {},
                                          ),
                                    );
                                  });
                                },
                              ),
                            ),





                            // if (searchResults
                            //     .where((element) => element.category.isDrink)
                            //     .toList()
                            //     .isEmpty)
                            //   const Padding(
                            //     padding: EdgeInsets.only(top: 80.0),
                            //     child: _IsEmpty(),
                            //   )
                            // else
                            //   SizedBox(
                            //     child: GridView.builder(
                            //       shrinkWrap: true,
                            //       itemCount: searchResults
                            //           .where(
                            //               (element) => element.category.isDrink)
                            //           .toList()
                            //           .length,
                            //       physics: const NeverScrollableScrollPhysics(),
                            //       gridDelegate:
                            //           const SliverGridDelegateWithFixedCrossAxisCount(
                            //         childAspectRatio: 0.85,
                            //         crossAxisCount: 3,
                            //         crossAxisSpacing: 30.0,
                            //         mainAxisSpacing: 30.0,
                            //       ),
                            //       itemBuilder: (context, index) => ProductCard(
                            //         data: searchResults
                            //             .where((element) =>
                            //                 element.category.isDrink)
                            //             .toList()[index],
                            //         onCartButton: () {},
                            //       ),
                            //     ),
                            //   ),
                            // if (searchResults
                            //     .where((element) => element.category.isSnack)
                            //     .toList()
                            //     .isEmpty)
                            //   const Padding(
                            //     padding: EdgeInsets.only(top: 80.0),
                            //     child: _IsEmpty(),
                            //   )
                            // else
                            //   SizedBox(
                            //     child: GridView.builder(
                            //       shrinkWrap: true,
                            //       itemCount: searchResults
                            //           .where(
                            //               (element) => element.category.isSnack)
                            //           .toList()
                            //           .length,
                            //       physics: const NeverScrollableScrollPhysics(),
                            //       gridDelegate:
                            //           const SliverGridDelegateWithFixedCrossAxisCount(
                            //         childAspectRatio: 0.85,
                            //         crossAxisCount: 3,
                            //         crossAxisSpacing: 30.0,
                            //         mainAxisSpacing: 30.0,
                            //       ),
                            //       itemBuilder: (context, index) => ProductCard(
                            //         data: searchResults
                            //             .where((element) =>
                            //                 element.category.isSnack)
                            //             .toList()[index],
                            //         onCartButton: () {},
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Orders #1',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 170,
                              ),
                              IconButton(
                                  iconSize: 24,
                                  onPressed: () {
                                    context.push(const SyncDataPage());
                                  },
                                  icon: Icon(Icons.settings, color: AppColors.primary,)
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
                                child: IconButton(
                                    iconSize: 24,
                                    onPressed: () {
                                      context
                                          .read<LogoutBloc>()
                                          .add(const LogoutEvent.logout());
                                    },
                                    icon: Icon(Icons.logout, color: AppColors.primary,)
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(16.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Item',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 130,
                              ),
                              SizedBox(
                                width: 50.0,
                                child: Text(
                                  'Qty',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(8),
                          const Divider(),
                          const SpaceHeight(8),
                          BlocBuilder<CheckoutBloc, CheckoutState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () => const Center(
                                  child: Text('No Items'),
                                ),
                                loaded: (products) {
                                  if (products.isEmpty) {
                                    return const Center(
                                      child: Text('No Items'),
                                    );
                                  }
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        OrderMenu(data: products[index]),
                                    separatorBuilder: (context, index) =>
                                    const SpaceHeight(1.0),
                                    itemCount: products.length,
                                  );
                                },
                              );
                            },
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColumnButton(
                                label: 'Diskon',
                                svgGenImage: Assets.icons.diskon,
                                onPressed: () {},
                              ),
                              ColumnButton(
                                label: 'Pajak',
                                svgGenImage: Assets.icons.pajak,
                                onPressed: () {},
                              ),
                              ColumnButton(
                                label: 'Layanan',
                                svgGenImage: Assets.icons.layanan,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          const Divider(),
                          const SpaceHeight(8.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pajak',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              Text(
                                '11 %',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Diskon',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              Text(
                                'Rp. 0',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sub total',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  final price = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded: (products) {
                                        if(products.isEmpty) {
                                          return 0;
                                        }
                                        return products
                                            .map((e) =>
                                        e.product.price!.toIntegerFromText * e.quantity)
                                            .reduce((value, element) => value + element);
                                      });
                                  return Text(
                                    price.currencyFormatRp,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SpaceHeight(100.0),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ColoredBox(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          child: Button.filled(
                            onPressed: () {
                              context.push(const ConfirmPaymentPage());
                            },
                            label: 'Lanjutkan Pembayaran',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IsEmpty extends StatelessWidget {
  const _IsEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.noProduct.svg(),
          const SizedBox(height: 80.0),
          const Text(
            'Belum Ada Produk',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
