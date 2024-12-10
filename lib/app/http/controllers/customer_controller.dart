import 'package:vania_service/app/models/customer.dart';
import 'package:vania/vania.dart';
// ignore: implementation_imports
import 'package:vania/src/exception/validation_exception.dart';

class CustomerController extends Controller {
  // Menampilkan semua customer
  Future<Response> index() async {
    try {
      final listCustomer = await Customer().query().get();
      return Response.json({
        'message': 'Daftar pelanggan',
        'data': listCustomer,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Gagal mengambil data pelanggan',
        'error': e.toString(),
      }, 500);
    }
  }

  // Membuat customer baru
  Future<Response> create(Request request) async {
    try {
      request.validate({
        'cust_name': 'required|string|max_length:50',
        'cust_email': 'required|string|email|max_length:100',
        'cust_address': 'required|string|max_length:255',
        'cust_phone': 'required|string|max_length:15',
      }, {
        'cust_name.required': 'Nama pelanggan tidak boleh kosong',
        'cust_name.string': 'Nama pelanggan harus berupa teks',
        'cust_name.max_length': 'Nama pelanggan maksimal 50 karakter',
        'cust_email.required': 'Email tidak boleh kosong',
        'cust_email.email': 'Format email tidak valid',
        'cust_email.max_length': 'Email maksimal 100 karakter',
        'cust_address.required': 'Alamat tidak boleh kosong',
        'cust_address.string': 'Alamat harus berupa teks',
        'cust_address.max_length': 'Alamat maksimal 255 karakter',
        'cust_phone.required': 'Nomor telepon tidak boleh kosong',
        'cust_phone.string': 'Nomor telepon harus berupa teks',
        'cust_phone.max_length': 'Nomor telepon maksimal 15 karakter',
      });

      final requestData = request.input();

      await Customer().query().insert(requestData);

      return Response.json({
        'message': 'Pelanggan berhasil dibuat',
        'data': requestData,
      }, 201);
    } catch (e) {
      if (e is ValidationException) {
        final errorMessages = e.message;
        return Response.json({'message': errorMessages}, 400);
      } else {
        return Response.json({'message': 'Internal Server Error'}, 500);
      }
    }
  }

  // Menampilkan detail customer berdasarkan ID
  Future<Response> show(String custId) async {
    try {
      final customer = await Customer().query().where('cust_id', '=', custId).first();

      if (customer == null) {
        return Response.json({'message': 'Pelanggan tidak ditemukan'}, 404);
      }

      return Response.json({
        'message': 'Detail pelanggan',
        'data': customer,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Internal Server Error',
        'error': e.toString(),
      }, 500);
    }
  }

  // Mengupdate data customer berdasarkan ID
  Future<Response> update(Request request, String custId) async {
    try {
      request.validate({
        'cust_name': 'required|string|max_length:50',
        'cust_email': 'required|string|email|max_length:100',
        'cust_address': 'required|string|max_length:255',
        'cust_phone': 'required|string|max_length:15',
      }, {
        'cust_name.required': 'Nama pelanggan tidak boleh kosong',
        'cust_name.string': 'Nama pelanggan harus berupa teks',
        'cust_name.max_length': 'Nama pelanggan maksimal 50 karakter',
        'cust_email.required': 'Email tidak boleh kosong',
        'cust_email.email': 'Format email tidak valid',
        'cust_email.max_length': 'Email maksimal 100 karakter',
        'cust_address.required': 'Alamat tidak boleh kosong',
        'cust_address.string': 'Alamat harus berupa teks',
        'cust_address.max_length': 'Alamat maksimal 255 karakter',
        'cust_phone.required': 'Nomor telepon tidak boleh kosong',
        'cust_phone.string': 'Nomor telepon harus berupa teks',
        'cust_phone.max_length': 'Nomor telepon maksimal 15 karakter',
      });

      final requestData = request.input();

      final customer = await Customer().query().where('cust_id', '=', custId).first();

      if (customer == null) {
        return Response.json({'message': 'Pelanggan tidak ditemukan'}, 404);
      }

      await Customer().query().where('cust_id', '=', custId).update(requestData);

      return Response.json({
        'message': 'Pelanggan berhasil diperbarui',
        'data': requestData,
      }, 200);
    } catch (e) {
      if (e is ValidationException) {
        final errorMessages = e.message;
        return Response.json({
          'error': errorMessages,
        }, 400);
      } else {
        return Response.json({
          'error': 'Internal Server Error',
        }, 500);
      }
    }
  }

  // Menghapus customer berdasarkan ID
  Future<Response> destroy(String custId) async {
    try {
      final customer = await Customer().query().where('cust_id', '=', custId).first();

      if (customer == null) {
        return Response.json({'message': 'Pelanggan tidak ditemukan'}, 404);
      }

      await Customer().query().where('cust_id', '=', custId).delete();

      return Response.json({
        'message': 'Pelanggan berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Internal Server Error',
        'error': e.toString(),
      }, 500);
    }
  }
}

final CustomerController customerController = CustomerController();
