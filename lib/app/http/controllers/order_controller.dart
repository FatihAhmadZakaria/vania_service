import 'package:vania_service/app/models/order.dart';
import 'package:vania/vania.dart';
// ignore: implementation_imports
import 'package:vania/src/exception/validation_exception.dart';

class OrderController extends Controller {
  // Menampilkan semua data order
  Future<Response> index() async {
    try {
      final listOrders = await Order().query().get();
      return Response.json({
        'message': 'Daftar pesanan',
        'data': listOrders,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Gagal mengambil data pesanan',
        'error': e.toString(),
      }, 500);
    }
  }

  // Membuat order baru
  Future<Response> create(Request request) async {
    try {
      request.validate({
        'cust_id': 'required|string',
        'order_date': 'required|date',
        'order_total': 'required|numeric|min:0',
        'order_status': 'required|string|max_length:50',
      }, {
        'cust_id.required': 'ID pelanggan tidak boleh kosong',
        'cust_id.string': 'ID pelanggan harus berupa teks',
        'order_date.required': 'Tanggal pesanan tidak boleh kosong',
        'order_date.date': 'Format tanggal pesanan tidak valid',
        'order_total.required': 'Total pesanan tidak boleh kosong',
        'order_total.numeric': 'Total pesanan harus berupa angka',
        'order_total.min': 'Total pesanan tidak boleh kurang dari 0',
        'order_status.required': 'Status pesanan tidak boleh kosong',
        'order_status.string': 'Status pesanan harus berupa teks',
        'order_status.max_length': 'Status pesanan maksimal 50 karakter',
      });

      final requestData = request.input();

      requestData['created_at'] = DateTime.now().toIso8601String();

      await Order().query().insert(requestData);

      return Response.json({
        'message': 'Pesanan berhasil dibuat',
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

  // Menampilkan detail order berdasarkan ID
  Future<Response> show(String orderId) async {
    try {
      final order = await Order().query().where('order_id', '=', orderId).first();

      if (order == null) {
        return Response.json({'message': 'Pesanan tidak ditemukan'}, 404);
      }

      return Response.json({
        'message': 'Detail pesanan',
        'data': order,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Internal Server Error',
        'error': e.toString(),
      }, 500);
    }
  }

  // Mengupdate data order berdasarkan ID
  Future<Response> update(Request request, String orderId) async {
    try {
      request.validate({
        'cust_id': 'required|string',
        'order_date': 'required|date',
        'order_total': 'required|numeric|min:0',
        'order_status': 'required|string|max_length:50',
      }, {
        'cust_id.required': 'ID pelanggan tidak boleh kosong',
        'cust_id.string': 'ID pelanggan harus berupa teks',
        'order_date.required': 'Tanggal pesanan tidak boleh kosong',
        'order_date.date': 'Format tanggal pesanan tidak valid',
        'order_total.required': 'Total pesanan tidak boleh kosong',
        'order_total.numeric': 'Total pesanan harus berupa angka',
        'order_total.min': 'Total pesanan tidak boleh kurang dari 0',
        'order_status.required': 'Status pesanan tidak boleh kosong',
        'order_status.string': 'Status pesanan harus berupa teks',
        'order_status.max_length': 'Status pesanan maksimal 50 karakter',
      });

      final requestData = request.input();
      requestData['updated_at'] = DateTime.now().toIso8601String();

      final order = await Order().query().where('order_id', '=', orderId).first();

      if (order == null) {
        return Response.json({'message': 'Pesanan tidak ditemukan'}, 404);
      }

      await Order().query().where('order_id', '=', orderId).update(requestData);

      return Response.json({
        'message': 'Pesanan berhasil diperbarui',
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

  // Menghapus order berdasarkan ID
  Future<Response> destroy(String orderId) async {
    try {
      final order = await Order().query().where('order_id', '=', orderId).first();

      if (order == null) {
        return Response.json({'message': 'Pesanan tidak ditemukan'}, 404);
      }

      await Order().query().where('order_id', '=', orderId).delete();

      return Response.json({
        'message': 'Pesanan berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Internal Server Error',
        'error': e.toString(),
      }, 500);
    }
  }
}

final OrderController orderController = OrderController();
