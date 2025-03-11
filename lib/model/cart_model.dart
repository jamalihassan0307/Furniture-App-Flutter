class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];
  double _total = 0;

  List<CartItem> get items => _items;
  double get total => _total;

  void addItem(CartItem item) {
    final existingItemIndex = _items.indexWhere((i) => i.id == item.id);
    if (existingItemIndex != -1) {
      _items[existingItemIndex].quantity++;
    } else {
      _items.add(item);
    }
    _calculateTotal();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _calculateTotal();
  }

  void updateQuantity(String id, int quantity) {
    final item = _items.firstWhere((item) => item.id == id);
    item.quantity = quantity;
    if (quantity <= 0) {
      removeItem(id);
    }
    _calculateTotal();
  }

  void _calculateTotal() {
    _total = _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void clear() {
    _items.clear();
    _total = 0;
  }

  bool isInCart(String id) {
    return _items.any((item) => item.id == id);
  }
} 