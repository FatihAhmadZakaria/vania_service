import 'package:vania/vania.dart';
import 'package:vania_service/app/http/controllers/auth_controller.dart';
import 'package:vania_service/app/http/controllers/product_controller.dart';
import 'package:vania_service/app/http/controllers/customer_controller.dart';
import 'package:vania_service/app/http/controllers/vendor_controller.dart';
import 'package:vania_service/app/http/controllers/order_controller.dart';
import 'package:vania_service/app/http/controllers/product_note_controller.dart';
import 'package:vania_service/app/http/controllers/order_item_controller.dart';
import 'package:vania_service/app/http/middleware/authenticate.dart';

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
    Router.get('/customer', customerController.index).middleware([AuthenticateMiddleware()]);
    Router.put('/customer/{cust_id}', customerController.update);
    Router.delete('/customer/{cust_id}', customerController.destroy);

    Router.post('/vendor', vendorController.create);
    Router.get('/vendor', vendorController.index);
    Router.put('/vendor/{vend_id}', vendorController.update);
    Router.delete('/vendor/{vend_id}', vendorController.destroy);

    Router.post('/order', orderController.create);
    Router.get('/order', orderController.index);
    Router.put('/order/{order_num}', orderController.update);
    Router.delete('/order/{order_num}', orderController.destroy);

    Router.post('/order/item', orderItemController.create);
    Router.get('/order/item', orderItemController.index);
    Router.put('/order/item/{order_item}', orderItemController.update);
    Router.delete('/order/item/{order_item}', orderItemController.destroy);

    Router.post('/product/note', productNoteController.create);
    Router.get('/product/note', productNoteController.index);
    Router.put('/product/note/{note_id}', productNoteController.update);
    Router.delete('/product/note/{note_id}', productNoteController.destroy);

    Router.post('/login', authController.login);
    Router.delete('/delete/token', authController.allLogout);
    Router.post('/register', authController.register);
  }
}
