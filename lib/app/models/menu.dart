// ignore_for_file: non_constant_identifier_names

class Menu {
  final String image, name;
  final double price;
  final int id, shopId;
  String? detail = "";
  dynamic option = {};

  Menu(this.id, this.image, this.name,this.detail, this.option, this.price, this.shopId) {
    detail = detail ?? "";
    option = option ?? {};
  }
}

List<Menu> menus = List.generate(demo_data.length, (index) => Menu(demo_data[index]['id'], demo_data[index]['image'], demo_data[index]['name'], demo_data[index]['detail'], demo_data[index]['option'], demo_data[index]['price'], demo_data[index]['shopId']));

List option = [
  {"id": 1, "name": "item1", "price": 10},
  {"id": 2, "name": "item1", "price": 0},
  {"id": 3, "name": "item1", "price": 0},
  {"id": 4, "name": "item1", "price": 0},
];

List demo_data = [
  {
    "id": 1,
    "name": "ราดข้าว 2 อย่าง",
    "detail": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,",
    "option": {"max": 2, "item":option},
    "image": "assets/images/image.jpg",
    "price": 30.00,
    "shopId": 1
  },
  {
    "id": 2,
    "name": "ราดข้าว 3 อย่าง",
    "detail": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,",
    "option": {"max": 3, "item":option},
    "image": "assets/images/image.jpg",
    "price": 35.00,
    "shopId": 1
  },
  {
    "id": 3,
    "name": "กับข้าว",
    "detail": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,",
    "image": "assets/images/image.jpg",
    "price": 20.00,
    "shopId": 1
  },
  {
    "id": 4,
    "name": "test",
    "detail": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,",
    "image": "assets/images/image.jpg",
    "price": 5.00,
    "shopId": 2
  },
  {
    "id": 5,
    "name": "test",
    "detail": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,",
    "image": "assets/images/image.jpg",
    "price": 5.00,
    "shopId": 2
  },
];