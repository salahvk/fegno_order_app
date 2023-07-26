final List<Map<String, dynamic>> dummyCartData = [
  {
    'itemName': 'Butter Milk',
    'price': 5,
    'quantity': 1,
    'quantityUnit': 'Ml',
    'imageUrl':
        'https://www.bigbasket.com/media/uploads/p/l/161899-2_9-amul-masti-buttermilk-spice.jpg',
  },
  {
    'itemName': 'Honey',
    'price': 15,
    'quantity': 1,
    'quantityUnit': 'Ml',
    'imageUrl':
        'https://4.imimg.com/data4/VE/NM/MY-12668164/pure-natural-honey.jpg',
  },
  {
    'itemName': 'Chicken',
    'price': 100,
    'quantity': 1,
    'quantityUnit': 'Kg',
    'imageUrl':
        'https://tmbidigitalassetsazure.blob.core.windows.net/rms3-prod/attachments/37/1200x1200/Crispy-Fried-Chicken_EXPS_TOHJJ22_6445_DR%20_02_03_11b.jpg',
  },
  {
    'itemName': 'Fish',
    'price': 50,
    'quantity': 1,
    'quantityUnit': 'Kg',
    'imageUrl':
        'https://images.moneycontrol.com/static-mcnews/2022/04/fish.jpg?impolicy=website&width=1600&height=900',
  },
  {
    'itemName': 'Lemon',
    'price': 7,
    'quantity': 1,
    'quantityUnit': 'Kg',
    'imageUrl': 'https://i.ndtvimg.com/mt/cooks/2014-11/lemon.jpg',
  },
];

class DummyDataSource {
  List<Map<String, dynamic>> getCartItems() {
    return dummyCartData;
  }
}
