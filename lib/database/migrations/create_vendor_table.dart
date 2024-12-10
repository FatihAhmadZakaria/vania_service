import 'package:vania/vania.dart';

class CreateVendorTable extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('vendor', () {
      string('vend_id', length: 5);
      string('vend_name', length: 50);
      text('vend_address');
      string('vend_kota', length: 25);
      string('vend_state', length: 5);
      string('vend_zip', length: 7);
      string('vend_country', length: 25);
      primary('vend_id');
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('vendor');
  }
}
