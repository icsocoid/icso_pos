import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icso_pos/data/datasources/order_remote_datasource.dart';
import 'package:icso_pos/data/datasources/product_local_datasource.dart';

part 'sync_order_event.dart';
part 'sync_order_state.dart';
part 'sync_order_bloc.freezed.dart';

class SyncOrderBloc extends Bloc<SyncOrderEvent, SyncOrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  SyncOrderBloc(this.orderRemoteDatasource) : super(const _Initial()) {
    on<SyncOrderEvent>((event, emit) async{
      emit(_Loading());
      final dataOrderNotSynced = await ProductLocalDatasource.instance.getOrderByIsNotSync();
      for(var order in dataOrderNotSynced) {
        final orderItem = await ProductLocalDatasource.instance.getOrderItemByOrderId(order.id!);
        final newOrder = order.copyWith(orderItems: orderItem);
        final result = await orderRemoteDatasource.saveOrder(newOrder);
        if(result) {
          await ProductLocalDatasource.instance.updateOrderIsSync(order.id!);
        } else {
          emit(const _Error('Sync Order Failed'));
          return;
        }
      }
      emit(_Loaded());
    });
  }
}
