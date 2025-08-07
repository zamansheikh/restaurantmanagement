# Bella Vista Restaurant Management App

A beautiful Flutter application for restaurant management with an elegant aesthetic design featuring a consistent color theme.

## Features

### 🎨 **Aesthetic Design**
- **Color Scheme**: Dark brown (#2C1810), Gold (#D4AF37), and Cream (#FFF8E1)
- Consistent typography and spacing
- Smooth animations and transitions
- Material Design 3 components

### 🏪 **Restaurant Features**
- **Splash Screen**: Beautiful animated splash with restaurant branding
- **Menu Display**: Categorized menu items with attractive cards
- **Category Filtering**: Easy navigation between Appetizers, Main Courses, Desserts, and Beverages
- **Shopping Cart**: Add, remove, and modify quantities
- **Order Management**: Complete order flow with confirmation

### 📱 **User Experience**
- Smooth page transitions
- Real-time cart updates
- Quantity controls with + and - buttons
- Order total calculation with tax
- Order confirmation with animations
- Empty cart state with call-to-action

### 🍽️ **Menu Categories**
- **Appetizers**: Truffle Bruschetta, Shrimp Cocktail, Stuffed Mushrooms
- **Main Courses**: Grilled Salmon, Beef Tenderloin, Chicken Parmesan, Vegetarian Risotto, Spicy Pasta
- **Desserts**: Chocolate Lava Cake, Tiramisu, Crème Brûlée
- **Beverages**: House Wine, Fresh Lemonade, Espresso

### 🛒 **Cart Features**
- Add items to cart
- Modify quantities
- Remove items
- View total with tax calculation
- Order confirmation with animations
- Clear cart functionality

## Technical Features

- **State Management**: Custom CartService with ChangeNotifier
- **Navigation**: Smooth page transitions
- **Animations**: Custom splash screen and order confirmation animations
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Data Models**: Structured MenuItem and CartItem classes

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   └── menu_item.dart                 # Data models
├── services/
│   └── cart_service.dart              # Cart state management
├── data/
│   └── menu_data.dart                 # Sample menu data
├── screens/
│   ├── splash_screen.dart             # Animated splash screen
│   ├── home_screen.dart               # Main menu display
│   ├── cart_screen.dart               # Shopping cart
│   └── order_confirmation_screen.dart  # Order success
└── widgets/
    ├── category_chip.dart             # Category filter chips
    └── menu_item_card.dart            # Menu item display cards
```

## Getting Started

1. **Prerequisites**
   - Flutter SDK (3.8.1 or higher)
   - Dart SDK
   - Android Studio or VS Code with Flutter extensions

2. **Installation**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Design System

### Colors
- **Primary**: Dark Brown (#2C1810) - Headers, text, borders
- **Secondary**: Gold (#D4AF37) - Accents, highlights, CTAs
- **Background**: Cream (#FFF8E1) - Main background
- **Surface**: White variants for cards and surfaces

### Typography
- **Headers**: Bold, Dark Brown
- **Body Text**: Regular, Dark Brown with opacity
- **Accents**: Gold for highlights and special text

### Components
- **Cards**: Elevated with subtle shadows and rounded corners
- **Buttons**: Consistent styling with hover states
- **Chips**: Animated category filters
- **Icons**: Consistent sizing and colors

## Features Showcase

### Splash Screen
- Animated restaurant logo with scaling and fade effects
- Gradient background
- Smooth transition to main screen

### Home Screen
- Restaurant welcome header
- Horizontal scrolling category filters
- Grid/list view of menu items
- Floating cart indicator with item count

### Menu Item Cards
- Emoji-based food images
- Vegetarian and spicy indicators
- Quantity controls
- Price display
- Add to cart functionality

### Cart Screen
- Item management (add/remove/modify)
- Running total calculation
- Tax calculation (8%)
- Order summary
- Place order functionality

### Order Confirmation
- Animated success checkmark
- Order details display
- Estimated delivery time
- Navigation back to menu

## Customization

The app is designed to be easily customizable:

1. **Menu Items**: Modify `menu_data.dart` to add/remove items
2. **Colors**: Update color constants in `main.dart`
3. **Restaurant Info**: Change restaurant name and branding
4. **Categories**: Add new menu categories
5. **Pricing**: Adjust tax rates and pricing logic

## Future Enhancements

- User authentication
- Order history
- Payment integration
- Push notifications
- Admin panel for menu management
- Customer reviews and ratings
- Delivery tracking
- Multiple restaurant support

---

**Bella Vista Restaurant** - Fine Dining Experience 🍽️
