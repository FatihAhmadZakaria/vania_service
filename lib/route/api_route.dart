import 'package:vania/vania.dart';
import 'package:vania_service/app/http/controllers/product_controller.dart';
import 'package:vania_service/app/http/controllers/customer_controller.dart';
import 'package:vania_service/app/http/controllers/vendor_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
  Router.basePrefix('api');

    Router.post('/product', productController.create);
    Router.get('/product', productController.index);
    Router.put('/product/{prod_id}', productController.update);
    Router.delete('/product/{prod_id}', productController.destroy);

    Router.post('/customer', customerController.create);
    Router.get('/customer', customerController.index);
    Router.put('/customer/{cust_id}', customerController.update);
    Router.delete('/customer/{cust_id}', customerController.destroy);

    Router.post('/vendor', vendorController.create);
    Router.get('/vendor', vendorController.index);
    Router.put('/vendor/{vendor_id}', vendorController.update);
    Router.delete('/vendor/{vendor_id}', vendorController.destroy);

  }
}
