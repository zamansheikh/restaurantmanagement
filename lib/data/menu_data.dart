import '../models/menu_item.dart';

class MenuData {
  static List<MenuItem> getMenuItems() {
    return [
      // Appetizers
      MenuItem(
        id: 'app_1',
        name: 'Fuchka (Pani Puri)',
        description:
            'Crispy shells filled with spiced water, chickpeas, and tamarind',
        price: 150.0,
        category: 'Appetizers',
        imageUrl: '🥟',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'app_2',
        name: 'Beguni',
        description: 'Deep-fried eggplant fritters with crispy batter',
        price: 120.0,
        category: 'Appetizers',
        imageUrl: '�',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'app_3',
        name: 'Chop Cutlet',
        description: 'Traditional Bengali potato and meat cutlets, deep fried',
        price: 180.0,
        category: 'Appetizers',
        imageUrl: '🥔',
      ),

      // Main Courses
      MenuItem(
        id: 'main_1',
        name: 'Hilsha Fish Curry',
        description:
            'Traditional Bengali hilsha fish curry with mustard and rice',
        price: 650.0,
        category: 'Main Courses',
        imageUrl: '🐟',
      ),
      MenuItem(
        id: 'main_2',
        name: 'Beef Bhuna',
        description: 'Slow-cooked spicy beef curry with aromatic spices',
        price: 550.0,
        category: 'Main Courses',
        imageUrl: '🍖',
        isSpicy: true,
      ),
      MenuItem(
        id: 'main_3',
        name: 'Chicken Roast',
        description: 'Bengali style spiced roasted chicken with potatoes',
        price: 480.0,
        category: 'Main Courses',
        imageUrl: '🍗',
        isSpicy: true,
      ),
      MenuItem(
        id: 'main_4',
        name: 'Dal Bhaja',
        description: 'Traditional lentil curry with fried onions and garlic',
        price: 220.0,
        category: 'Main Courses',
        imageUrl: '🍲',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'main_5',
        name: 'Mutton Biryani',
        description: 'Fragrant basmati rice layered with spiced mutton',
        price: 750.0,
        category: 'Main Courses',
        imageUrl: '�',
        isSpicy: true,
      ),
      MenuItem(
        id: 'main_6',
        name: 'Shorshe Ilish',
        description:
            'Hilsha fish cooked in mustard seed paste - Bengali signature dish',
        price: 850.0,
        category: 'Main Courses',
        imageUrl: '🐠',
        isSpicy: true,
      ),

      // Rice & Bread
      MenuItem(
        id: 'rice_1',
        name: 'Basmati Rice',
        description: 'Steamed fragrant basmati rice',
        price: 80.0,
        category: 'Rice & Bread',
        imageUrl: '🍚',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'rice_2',
        name: 'Paratha',
        description: 'Flaky layered flatbread, freshly made',
        price: 60.0,
        category: 'Rice & Bread',
        imageUrl: '🫓',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'rice_3',
        name: 'Naan',
        description: 'Soft tandoor-baked bread',
        price: 70.0,
        category: 'Rice & Bread',
        imageUrl: '🥙',
        isVegetarian: true,
      ),

      // Desserts
      MenuItem(
        id: 'dess_1',
        name: 'Roshogolla',
        description: 'Soft spongy cottage cheese balls in sugar syrup',
        price: 120.0,
        category: 'Desserts',
        imageUrl: '�',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'dess_2',
        name: 'Mishti Doi',
        description: 'Sweet fermented yogurt, a Bengali classic',
        price: 100.0,
        category: 'Desserts',
        imageUrl: '🥛',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'dess_3',
        name: 'Kheer',
        description: 'Creamy rice pudding with cardamom and nuts',
        price: 150.0,
        category: 'Desserts',
        imageUrl: '�',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'dess_4',
        name: 'Sandesh',
        description: 'Delicate cottage cheese sweets with pistachio',
        price: 180.0,
        category: 'Desserts',
        imageUrl: '🧁',
        isVegetarian: true,
      ),

      // Beverages
      MenuItem(
        id: 'bev_1',
        name: 'Cha (Tea)',
        description: 'Traditional Bengali milk tea with spices',
        price: 40.0,
        category: 'Beverages',
        imageUrl: '🍵',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'bev_2',
        name: 'Lassi',
        description: 'Refreshing yogurt drink, sweet or salted',
        price: 80.0,
        category: 'Beverages',
        imageUrl: '🥤',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'bev_3',
        name: 'Shorbot',
        description: 'Traditional Bengali summer drink with rose water',
        price: 60.0,
        category: 'Beverages',
        imageUrl: '🧃',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'bev_4',
        name: 'Fresh Lime Water',
        description: 'Freshly squeezed lime with mint leaves',
        price: 50.0,
        category: 'Beverages',
        imageUrl: '🍋',
        isVegetarian: true,
      ),
    ];
  }

  static List<String> getCategories() {
    return [
      'All',
      'Appetizers',
      'Main Courses',
      'Rice & Bread',
      'Desserts',
      'Beverages',
    ];
  }
}
