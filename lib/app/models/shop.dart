class Shop {
  final String image, name;
  final double score;
  final int id,review;

  Shop(
    this.id,
    this.image,
    this.name,
    this.score,
    this.review
  );

}

List<Shop> shops = List.generate(demo_data.length, (index) => Shop(demo_data[index]['id'], demo_data[index]['image'], demo_data[index]['name'], demo_data[index]['score'], demo_data[index]['review']));

List demo_data = [
  {
    "id": 1,
    "name": "ข้าวแกงอร่อยที่สุดใน 3 โลก",
    "image": "assets/images/image.jpg",
    "score": 5.0,
    "review": 100
  },
  {
    "id": 2,
    "name": "อาหารตามสั่ง",
    "image": "assets/images/image.jpg",
    "score": 1.0,
    "review": 132
  },
  {
    "id": 3,
    "name": "ข้าวมันไก่",
    "image": "assets/images/image.jpg",
    "score": 4.3,
    "review": 12
  },
  {
    "id": 4,
    "name": "ข้าวแกงอร่อยที่สุดใน 3 โลก",
    "image": "assets/images/image.jpg",
    "score": 5.0,
    "review": 100
  },
  {
    "id": 5,
    "name": "ข้าวแกงอร่อยที่สุดใน 3 โลก",
    "image": "assets/images/image.jpg",
    "score": 5.0,
    "review": 100
  },
];