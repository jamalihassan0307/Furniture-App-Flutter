import 'package:flutter/material.dart';
import 'package:uidesign03/core/color.dart';
import 'package:uidesign03/core/text_style.dart';
import 'package:uidesign03/data/model_data.dart';
import 'package:uidesign03/widgets/item_card.dart';

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

        bool matchesCategory =
            _selectedCategory == 'All' || item.category == _selectedCategory;

        double price = double.parse(
            item.price.replaceAll('\$', '').replaceAll(',', ''));
        bool matchesPrice = price >= _currentPriceRange.start &&
            price <= _currentPriceRange.end;

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
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => _filterItems(),
                      decoration: InputDecoration(
                        hintText: 'Search furniture...',
                        prefixIcon: Icon(Icons.search, color: primary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isFiltering
                                ? Icons.filter_list
                                : Icons.filter_list_outlined,
                            color: primary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFiltering = !_isFiltering;
                            });
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  if (_isFiltering) ...[
                    SizedBox(height: 20),
                    // Category Filter
                    Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              label: Text(_categories[index]),
                              selected: _selectedCategory == _categories[index],
                              onSelected: (selected) {
                                setState(() {
                                  _selectedCategory = _categories[index];
                                  _filterItems();
                                });
                              },
                              selectedColor: primary,
                              labelStyle: TextStyle(
                                color: _selectedCategory == _categories[index]
                                    ? white
                                    : primary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Price Range Slider
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price Range: \$${_currentPriceRange.start.toInt()} - \$${_currentPriceRange.end.toInt()}',
                          style: subHeading,
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
                ],
              ),
            ),
            // Results
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        'No items found',
                        style: subHeading,
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return ItemCard(model: _filteredItems[index]);
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
} 