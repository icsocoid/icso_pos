import 'package:http/http.dart' as http;
import 'package:icso_pos/core/constants/app_url.dart';
import 'package:icso_pos/data/datasources/auth_local_datasource.dart';
import 'package:icso_pos/presentation/home/models/order_model.dart';

class OrderRemoteDatasource {
  Future<bool> saveOrder(OrderModel orderModel) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final url = Uri.parse('${AppUrl.baseUrl}/api/order/save-data');
    final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
        },
        body: {
          orderModel.toJson(),
        }
    );

    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}