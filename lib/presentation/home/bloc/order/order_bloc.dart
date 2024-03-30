import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icso_pos/core/extensions/string_ext.dart';
import 'package:icso_pos/data/datasources/auth_local_datasource.dart';
import 'package:icso_pos/data/datasources/product_local_datasource.dart';
import 'package:icso_pos/presentation/home/models/order_model.dart';
import 'package:icso_pos/presentation/home/models/product_quantity.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Initial()) {
    on<_Order>((event, emit) async {
      emit(_Loading());

      //save to local storage
      final subTotal = 0;
      final total = subTotal + event.tax + event.serviceCharge - event.discount;

      final totalItem = event.items.fold<int>(
          0, (previousValue, element) => previousValue + element.quantity
      );

      final userData = await AuthLocalDataSource().getAuthData();
      final dataInput = OrderModel(
        subTotal: subTotal,
        paymentAmount: event.paymentAmount,
        tax: event.tax,
        discount: event.discount,
        serviceCharge: event.serviceCharge,
        total: total,
        paymentMethod: 'Cash',
        totalItem: totalItem,
        idKasir: userData.user!.id!,
        namaKasir: userData.user!.name!,
        transactionTime: DateTime.now().toIso8601String(),
        isSync: 0,
        orderItems: event.items,
      );

      await ProductLocalDatasource.instance.saveOrder(dataInput);

      emit(_Loaded(dataInput,));
    });
  }
}
