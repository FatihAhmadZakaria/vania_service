import 'package:vania/vania.dart';

class CreateProductTable extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('product', () {
      string('prod_id', length: 10);
      string('vend_id', length: 5);
      string('prod_name', length: 25);
      integer('prod_price');
      text('prod_desc');
      foreign('vend_id', 'vendor', 'vend_id', constrained: true, onDelete: 'CASCADE');
      primary('prod_id');
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('product');
  }
}
