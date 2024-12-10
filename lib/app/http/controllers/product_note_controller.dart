import 'package:vania_service/app/models/productnote.dart';
import 'package:vania/vania.dart';
// ignore: implementation_imports
import 'package:vania/src/exception/validation_exception.dart';

class ProductNoteController extends Controller {
  // Menampilkan semua catatan produk
  Future<Response> index() async {
    try {
      final listProductNotes = await Productnote().query().get();
      return Response.json({
        'message': 'Daftar catatan produk',
        'data': listProductNotes,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Gagal mengambil data catatan produk',
        'error': e.toString(),
      }, 500);
    }
  }

  // Membuat catatan produk baru
  Future<Response> create(Request request) async {
    try {
      request.validate({
        'product_id': 'required|string',
        'note': 'required|string|max_length:255',
      }, {
        'product_id.required': 'ID produk tidak boleh kosong',
        'product_id.string': 'ID produk harus berupa teks',
        'note.required': 'Catatan tidak boleh kosong',
        'note.string': 'Catatan harus berupa teks',
        'note.max_length': 'Catatan maksimal 255 karakter',
      });

      final requestData = request.input();
      requestData['created_at'] = DateTime.now().toIso8601String();

      await Productnote().query().insert(requestData);

      return Response.json({
        'message': 'Catatan produk berhasil dibuat',
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

  // Menampilkan detail catatan produk berdasarkan ID
  Future<Response> show(String productNoteId) async {
    try {
      final productNote = await Productnote().query().where('product_note_id', '=', productNoteId).first();

      if (productNote == null) {
        return Response.json({'message': 'Catatan produk tidak ditemukan'}, 404);
      }

      return Response.json({
        'message': 'Detail catatan produk',
        'data': productNote,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Internal Server Error',
        'error': e.toString(),
      }, 500);
    }
  }

  // Mengupdate data catatan produk berdasarkan ID
  Future<Response> update(Request request, String productNoteId) async {
    try {
      request.validate({
        'product_id': 'required|string',
        'note': 'required|string|max_length:255',
      }, {
        'product_id.required': 'ID produk tidak boleh kosong',
        'product_id.string': 'ID produk harus berupa teks',
        'note.required': 'Catatan tidak boleh kosong',
        'note.string': 'Catatan harus berupa teks',
        'note.max_length': 'Catatan maksimal 255 karakter',
      });

      final requestData = request.input();
      requestData['updated_at'] = DateTime.now().toIso8601String();

      final productNote = await Productnote().query().where('product_note_id', '=', productNoteId).first();

      if (productNote == null) {
        return Response.json({'message': 'Catatan produk tidak ditemukan'}, 404);
      }

      await Productnote().query().where('product_note_id', '=', productNoteId).update(requestData);

      return Response.json({
        'message': 'Catatan produk berhasil diperbarui',
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

  // Menghapus catatan produk berdasarkan ID
  Future<Response> destroy(String productNoteId) async {
    try {
      final productNote = await Productnote().query().where('product_note_id', '=', productNoteId).first();

      if (productNote == null) {
        return Response.json({'message': 'Catatan produk tidak ditemukan'}, 404);
      }

      await Productnote().query().where('product_note_id', '=', productNoteId).delete();

      return Response.json({
        'message': 'Catatan produk berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Internal Server Error',
        'error': e.toString(),
      }, 500);
    }
  }
}

final ProductNoteController productNoteController = ProductNoteController();
