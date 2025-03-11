import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/data/model_data.dart';
import 'package:uidesign03/widgets/item_card.dart';
import 'package:uidesign03/widgets/grid_item_card.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  RangeValues _currentPriceRange = RangeValues(0, 1000);
  String _selectedCategory = 'All';
  List<String> _categories = ['All', 'Chairs', 'Lamps', 'Tables', 'Sofas'];
  bool _isFiltering = false;

  List<dynamic> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = models;
  }

  void _filterItems() {
    setState(() {
      _filteredItems = models.where((item) {
        bool matchesSearch = item.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ) ||
            item.description.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                );

        bool matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;

        double price = double.parse(item.price.replaceAll('\$', '').replaceAll(',', ''));
        bool matchesPrice = price >= _currentPriceRange.start && price <= _currentPriceRange.end;

        return matchesSearch && matchesCategory && matchesPrice;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            // Header and Search Section
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Back Button and Title
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: primary),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Search Products',
                        style: heading.copyWith(
                          fontSize: 24,
                          color: black.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: primary.withOpacity(0.1)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => _filterItems(),
                      decoration: InputDecoration(
                        hintText: 'Search furniture...',
                        hintStyle: subHeading.copyWith(
                          color: lightBlack.withOpacity(0.5),
                        ),
                        prefixIcon: Icon(Icons.search, color: primary),
                        suffixIcon: AnimatedRotation(
                          duration: Duration(milliseconds: 300),
                          turns: _isFiltering ? 0.25 : 0,
                          child: IconButton(
                            icon: Icon(Icons.tune, color: primary),
                            onPressed: () {
                              setState(() {
                                _isFiltering = !_isFiltering;
                              });
                            },
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  // Filters
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: _isFiltering ? null : 0,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        // Categories
                        Container(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  child: FilterChip(
                                    label: Text(_categories[index]),
                                    selected: _selectedCategory == _categories[index],
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedCategory = _categories[index];
                                        _filterItems();
                                      });
                                    },
                                    selectedColor: primary,
                                    backgroundColor: background,
                                    labelStyle: TextStyle(
                                      color: _selectedCategory == _categories[index] ? white : primary,
                                    ),
                                    elevation: 0,
                                    pressElevation: 2,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        // Price Range
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price Range',
                                  style: subHeading.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '\$${_currentPriceRange.start.toInt()} - \$${_currentPriceRange.end.toInt()}',
                                  style: subHeading.copyWith(
                                    color: primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            RangeSlider(
                              values: _currentPriceRange,
                              min: 0,
                              max: 1000,
                              divisions: 20,
                              activeColor: primary,
                              inactiveColor: primary.withOpacity(0.2),
                              labels: RangeLabels(
                                '\$${_currentPriceRange.start.toInt()}',
                                '\$${_currentPriceRange.end.toInt()}',
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  _currentPriceRange = values;
                                  _filterItems();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Results Section
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 80,
                            color: primary.withOpacity(0.5),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No items found',
                            style: subHeading.copyWith(
                              color: primary.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return GridItemCard(model: _filteredItems[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildNavItem(int index, IconData icon, String label, bool isSelected) {
    return InkWell(
      onTap: () {
        if (!isSelected && index == 0) {
          Navigator.pop(context);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? primary : lightBlack,
              size: 24,
            ),
            if (isSelected) ...[
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
