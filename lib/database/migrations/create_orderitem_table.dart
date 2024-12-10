import 'package:vania/vania.dart';

class CreateOrderitemTable extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('orderitem', () {
      bigIncrements('order_item');
      bigInt('order_num', unsigned: true);
      string('prod_id', length: 10);
      integer('quantity');
      integer('size');
      foreign('order_num', 'order', 'order_num');
      foreign('prod_id', 'product', 'prod_id');
      primary('order_item');
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orderitem');
  }
}
