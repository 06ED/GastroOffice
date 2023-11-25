import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../../entities/impl/product_entity.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<AddToCartProductEvent>((event, emit) async {
      final root = await getTemporaryDirectory();
      final file = File("${root.path}/cart.json");
      final cartData = <ProductEntity>[];

      if (await file.exists()) {
        final jsonList =
            jsonDecode(utf8.decode(await file.readAsBytes())) as List;
        cartData.addAll(jsonList.map((e) => ProductEntity.fromJson(e)));
      } else {
        await file.create();
      }
      cartData.addAll(event.products);

      await file
          .writeAsString(jsonEncode(cartData.map((e) => e.toJson()).toList()));
    });
  }
}
