import 'menu.dart';
import 'shop.dart';

class Cart {
  int? menuId, count;
  List? addon;
  String? comment;
  double? price;
  late Menu? menu;
  late int? shopId;
  late Shop? shop;

  Cart(this.menuId, this.addon, this.comment, this.count, this.price) {
    _getMenu();
    shopId = menu?.shopId;
  }

  void _getMenu() {
    menu = menus.where((el) => el.id == menuId).toList()[0];
  }

  Cart.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    addon = json['addon'];
    comment = json['comment'];
    price = json['price'];
    shopId = json['shopId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuId'] = menuId;
    data['addon'] = addon;
    data['comment'] = comment;
    data['price'] = price;
    data['shopId'] = shopId;
    return data;
  }
}