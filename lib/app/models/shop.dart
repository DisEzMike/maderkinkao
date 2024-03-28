class Shop {
  final String image, name;
  final double score;
  final int id;

  Shop(
    this.id,
    this.image,
    this.name,
    this.score,
  );

}

List<Shop> shops = List.generate(demo_data.length, (index) => Shop(demo_data[index]['id'], demo_data[index]['image'], demo_data[index]['name'], demo_data[index]['score']));

List demo_data = [
  {
    "id": 1,
    "name": "ข้าวแกงอร่อยที่สุดใน 3 โลก",
    "image": "assets/images/image.jpg",
    "score": 5.0,
  },
  {
    "id": 2,
    "name": "อาหารตามสั่ง",
    "image": "assets/images/image.jpg",
    "score": 1.0,
  },
  {
    "id": 3,
    "name": "ข้าวมันไก่",
    "image": "assets/images/image.jpg",
    "score": 4.3,
  },
  {
    "id": 4,
    "name": "ข้าวแกงอร่อยที่สุดใน 3 โลก",
    "image": "assets/images/image.jpg",
    "score": 5.0,
  },
  {
    "id": 5,
    "name": "ข้าวแกงอร่อยที่สุดใน 3 โลก",
    "image": "assets/images/image.jpg",
    "score": 5.0,
  },
];