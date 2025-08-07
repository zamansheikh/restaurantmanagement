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
        imageUrl:
            'data:image/jpeg;base64,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',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'app_2',
        name: 'Beguni',
        description: 'Deep-fried eggplant fritters with crispy batter',
        price: 120.0,
        category: 'Appetizers',
        imageUrl: 'https://i.ndtvimg.com/i/2017-12/beguni_620x330_71513660577.jpg',
        isVegetarian: true,
      ),
      MenuItem(
        id: 'app_3',
        name: 'Chop Cutlet',
        description: 'Traditional Bengali potato and meat cutlets, deep fried',
        price: 180.0,
        category: 'Appetizers',
        imageUrl:
            'https://i.ytimg.com/vi/IOzlCl59mgs/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLC5MutA6abgVE76uCDFMxarKcXL8Q',
      ),

      // Main Courses
      MenuItem(
        id: 'main_1',
        name: 'Hilsha Fish Curry',
        description:
            'Traditional Bengali hilsha fish curry with mustard and rice',
        price: 650.0,
        category: 'Main Courses',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDUBE7KTOGmE4xwq-JyxKRUNu_r5cJ8v6p8A&s',
      ),
      MenuItem(
        id: 'main_2',
        name: 'Beef Bhuna',
        description: 'Slow-cooked spicy beef curry with aromatic spices',
        price: 550.0,
        category: 'Main Courses',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1cQl7HfqE8OkHGnYy_6v3M5zW8QP_jKLjLw&s',
        isSpicy: true,
      ),
      MenuItem(
        id: 'main_3',
        name: 'Chicken Roast',
        description: 'Bengali style spiced roasted chicken with potatoes',
        price: 480.0,
        category: 'Main Courses',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdH4mL9yUwL_y7AaHzjLiE6O4Q9wP_8jKJwQ&s',
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
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5xVz6Y8yO4yHt_xQ9PqXc7wZ2JaOhGU4BjA&s',
        isSpicy: true,
      ),
      MenuItem(
        id: 'main_6',
        name: 'Shorshe Ilish',
        description:
            'Hilsha fish cooked in mustard seed paste - Bengali signature dish',
        price: 850.0,
        category: 'Main Courses',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvQz8YhH7K2dJ8_rX5tZ4mN9oW6qE3fL8GhA&s',
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
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH8mR4xP2oT9vF_yQ7nZ5kE6wJ1rO8gU3CzA&s',
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
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9xT4hK8yL5zO_qW2nZ7kE9wJ6rP1gU8BfmA&s',
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
