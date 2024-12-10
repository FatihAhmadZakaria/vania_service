import 'package:vania_service/app/models/orderitem.dart';
import 'package:vania/vania.dart';
// ignore: implementation_imports
import 'package:vania/src/exception/validation_exception.dart';

class OrderItemController extends Controller {
  // Menampilkan semua data order item
  Future<Response> index() async {
    try {
      final listOrderItems = await Orderitem().query().get();
      return Response.json({
        'message': 'Daftar item pesanan',
        'data': listOrderItems,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Gagal mengambil data item pesanan',
        'error': e.toString(),
      }, 500);
    }
  }

  // Membuat order item baru
  Future<Response> create(Request request) async {
    try {
      request.validate({
        'order_id': 'required|string',
        'product_id': 'required|string',
        'quantity': 'required|numeric|min:1',
        'price': 'required|numeric|min:0',
      }, {
        'order_id.required': 'ID pesanan tidak boleh kosong',
        'order_id.string': 'ID pesanan harus berupa teks',
        'product_id.required': 'ID produk tidak boleh kosong',
        'product_id.string': 'ID produk harus berupa teks',
        'quantity.required': 'Jumlah tidak boleh kosong',
        'quantity.numeric': 'Jumlah harus berupa angka',
        'quantity.min': 'Jumlah minimal adalah 1',
        'price.required': 'Harga tidak boleh kosong',
        'price.numeric': 'Harga harus berupa angka',
        'price.min': 'Harga tidak boleh kurang dari 0',
      });

      final requestData = request.input();
      requestData['created_at'] = DateTime.now().toIso8601String();

      await Orderitem().query().insert(requestData);

      return Response.json({
        'message': 'Item pesanan berhasil dibuat',
        'data': requestData,
      }, 201);
    } catch (e) {
      if (e is ValidationException) {
        return Response.json({'message': e.message}, 400);
      } else {
        return Response.json({'message': 'Internal Server Error'}, 500);
      }
    }
  }

  // Menampilkan detail order item berdasarkan ID
  Future<Response> show(String orderItemId) async {
    try {
      final orderItem = await Orderitem().query().where('order_item_id', '=', orderItemId).first();

      if (orderItem == null) {
        return Response.json({'message': 'Item pesanan tidak ditemukan'}, 404);
      }

      return Response.json({
        'message': 'Detail item pesanan',
        'data': orderItem,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Internal Server Error',
        'error': e.toString(),
      }, 500);
    }
  }

  // Mengupdate data order item berdasarkan ID
  Future<Response> update(Request request, String orderItemId) async {
    try {
      request.validate({
        'order_id': 'required|string',
        'product_id': 'required|string',
        'quantity': 'required|numeric|min:1',
        'price': 'required|numeric|min:0',
      }, {
        'order_id.required': 'ID pesanan tidak boleh kosong',
        'order_id.string': 'ID pesanan harus berupa teks',
        'product_id.required': 'ID produk tidak boleh kosong',
        'product_id.string': 'ID produk harus berupa teks',
        'quantity.required': 'Jumlah tidak boleh kosong',
        'quantity.numeric': 'Jumlah harus berupa angka',
        'quantity.min': 'Jumlah minimal adalah 1',
        'price.required': 'Harga tidak boleh kosong',
        'price.numeric': 'Harga harus berupa angka',
        'price.min': 'Harga tidak boleh kurang dari 0',
      });

      final requestData = request.input();
      requestData['updated_at'] = DateTime.now().toIso8601String();

      final orderItem = await Orderitem().query().where('order_item_id', '=', orderItemId).first();

      if (orderItem == null) {
        return Response.json({'message': 'Item pesanan tidak ditemukan'}, 404);
      }

      await Orderitem().query().where('order_item_id', '=', orderItemId).update(requestData);

      return Response.json({
        'message': 'Item pesanan berhasil diperbarui',
        'data': requestData,
      }, 200);
    } catch (e) {
      if (e is ValidationException) {
        return Response.json({'message': e.message}, 400);
      } else {
        return Response.json({'message': 'Internal Server Error'}, 500);
      }
    }
  }

  // Menghapus order item berdasarkan ID
  Future<Response> destroy(String orderItemId) async {
    try {
      final orderItem = await Orderitem().query().where('order_item_id', '=', orderItemId).first();

      if (orderItem == null) {
        return Response.json({'message': 'Item pesanan tidak ditemukan'}, 404);
      }

      await Orderitem().query().where('order_item_id', '=', orderItemId).delete();

      return Response.json({
        'message': 'Item pesanan berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Internal Server Error',
        'error': e.toString(),
      }, 500);
    }
  }
}

final OrderItemController orderItemController = OrderItemController();
