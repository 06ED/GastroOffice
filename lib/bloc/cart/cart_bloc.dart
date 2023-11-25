import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../../api/http_client.dart';
import '../../entities/impl/product_entity.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitEvent>((event, emit) async {
      final root = await getTemporaryDirectory();
      final file = File("${root.path}/cart.json");
      final cartData = <ProductEntity>[];

      if (await file.exists()) {
        final jsonList =
            jsonDecode(utf8.decode(await file.readAsBytes())) as List;
        cartData.addAll(jsonList.map((e) => ProductEntity.fromJson(e)));
      }

      emit(CartInitState(products: cartData));
    });

    on<DeleteProductFromCartEvent>((event, emit) async {
      final root = await getTemporaryDirectory();
      final file = File("${root.path}/cart.json");
      final cartData = <ProductEntity>[];

      if (await file.exists()) {
        List jsonList =
            jsonDecode(utf8.decode(await file.readAsBytes())) as List;
        jsonList = jsonList
            .where((element) => element["id"] != event.product.id)
            .toList();
        cartData.addAll(jsonList.map((e) => ProductEntity.fromJson(e)));
        await file.writeAsString(jsonEncode(jsonList));
      }

      emit(CartInitState(products: cartData));
    });

  }
}
