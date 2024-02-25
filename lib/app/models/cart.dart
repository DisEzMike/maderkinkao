import 'menu.dart';
import 'shop.dart';

class Cart {
  final int menuId, count;
  final List addon;
  final String comment;
  final double price;
  late Menu menu;
  late int shopId;
  late Shop shop;

  Cart(this.menuId, this.addon, this.comment, this.count, this.price) {
    _getMenu();
    shopId = menu.shopId;
  }

  void _getMenu() {
    menu = menus.where((el) => el.id == menuId).toList()[0];
  }
  
}