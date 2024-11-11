
import 'package:long_register_flutter/data/remote/Network_url_app.dart';
import 'package:long_register_flutter/data/remote/api_url.dart';
import 'package:long_register_flutter/model/products/Product_response.dart';

class ProductRepository {
  final NetworkUrlApp _api = NetworkUrlApp();
  Future<ProductResponse> getAllProduct() async {
    var response = await _api.getApi(ApiUrl.getAllProduct);
    ProductResponse productResponse = ProductResponse.fromJson(response);
    return productResponse;
  }
}