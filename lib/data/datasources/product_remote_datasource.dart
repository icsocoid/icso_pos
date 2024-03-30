
import 'package:dartz/dartz.dart';
import 'package:icso_pos/core/constants/app_url.dart';
import 'package:icso_pos/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:icso_pos/data/models/response/product_response_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final url = Uri.parse('http://icsoapi.als.today/public/api/pt-abc/product-get-all?page=0&perpage=10&product_type=item');
    // final url = Uri.parse('http://pos-api.mers.biz.id/public/api/product/get-data');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(url, headers: {
        // 'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
    });

    if(response.statusCode == 200) {
        return Right(ProductResponseModel.fromJson(response.body));
    }
    else {
        return const Left('Failed to get product');
    }
  }
}