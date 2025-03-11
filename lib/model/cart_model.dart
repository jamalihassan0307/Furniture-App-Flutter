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
  CartManager._internal() {
    // Initialize with some static items
    _staticItems = [
      CartItem(
        id: 'chair1',
        name: 'Modern Chair',
        image: 'assets/images/01.png',
        price: 120.00,
        quantity: 1,
      ),
      CartItem(
        id: 'lamp1',
        name: 'Modern Lamp',
        image: 'assets/images/lamp1.jpeg',
        price: 75.00,
        quantity: 1,
      ),
    ];
  }

  late final List<CartItem> _staticItems;
  final List<CartItem> _items = [];
  final List<Function(String)> _listeners = [];
  double _total = 0;

  List<CartItem> get items => [..._staticItems, ..._items];
  List<CartItem> get staticItems => _staticItems;
  double get total => _calculateTotal();

  void addListener(Function(String) listener) {
    _listeners.add(listener);
  }

  void removeListener(Function(String) listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners(String itemId) {
    for (var listener in _listeners) {
      listener(itemId);
    }
  }

  void addItem(CartItem item) {
    final existingItemIndex = _items.indexWhere((i) => i.id == item.id);
    if (existingItemIndex != -1) {
      _items[existingItemIndex].quantity++;
    } else {
      _items.add(item);
    }
    _calculateTotal();
    _notifyListeners(item.id);
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _calculateTotal();
    _notifyListeners(id);
  }

  void updateQuantity(String id, int quantity) {
    final item = _items.firstWhere((item) => item.id == id);
    item.quantity = quantity;
    if (quantity <= 0) {
      removeItem(id);
    }
    _calculateTotal();
    _notifyListeners(id);
  }

  double _calculateTotal() {
    return [..._staticItems, ..._items].fold(
      0,
      (sum, item) => sum + item.totalPrice,
    );
  }

  void clear() {
    _items.clear();
    _total = 0;
  }

  bool isInCart(String id) {
    return _staticItems.any((item) => item.id == id) ||
        _items.any((item) => item.id == id);
  }
} 