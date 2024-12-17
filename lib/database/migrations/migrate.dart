import 'dart:io';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import 'create_customer_table.dart';
import 'create_order_table.dart';
import 'create_productnote_table.dart';
import 'create_vendor_table.dart';
import 'create_product_table.dart';
import 'create_orderitem_table.dart';
import 'create_personal_access_tokens_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async{
		 await CreatePersonalAccessTokensTable().up();
     await CreateUserTable().up();
		 await CreateCustomerTable().up();
     await CreateVendorTable().up();
     await CreateOrderTable().up();
     await CreateProductTable().up();
     await CreateOrderitemTable().up();
     await CreateProductnoteTable().up();
	}

  dropTables() async {
		 await CreateOrderitemTable().down();
		 await CreateProductTable().down();
		 await CreateVendorTable().down();
		 await CreateProductnoteTable().down();
		 await CreateOrderTable().down();
		 await CreateCustomerTable().down();
		 await CreateUserTable().down();
     await CreatePersonalAccessTokensTable().down();
	 }
}
