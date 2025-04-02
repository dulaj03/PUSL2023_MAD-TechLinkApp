import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_link/data/market_place.dart';
import 'package:tech_link/model/market_place.dart';
import 'package:tech_link/widgets/product_card.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  String _selectedCategory = 'All';
  List<Product> _displayedProducts = [];
  final TextEditingController _searchController = TextEditingController();
  String _sortOption = 'Newest';

  @override
  void initState() {
    super.initState();
    _displayedProducts = ProductData.getAllProducts();

    _searchController.addListener(() {
      _filterProducts();
    });
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty && _selectedCategory == 'All') {
        _displayedProducts = ProductData.getAllProducts();
      } else if (query.isEmpty) {
        _displayedProducts = ProductData.getProductsByCategory(
          _selectedCategory,
        );
      } else if (_selectedCategory == 'All') {
        _displayedProducts = ProductData.searchProducts(query);
      } else {
        _displayedProducts =
            ProductData.searchProducts(
              query,
            ).where((p) => p.category == _selectedCategory).toList();
      }

      // Apply sorting
      _sortProducts();
    });
  }

  void _sortProducts() {
    switch (_sortOption) {
      case 'Price: Low to High':
        _displayedProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        _displayedProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        _displayedProducts.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
      default:
        // Assuming newest is the default order in ProductData
        break;
    }
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterProducts();
    });
  }

  void _changeSort(String? value) {
    if (value != null) {
      setState(() {
        _sortOption = value;
        _sortProducts();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get all categories plus "All" option
    final categories = ['All', ...ProductData.getCategories()];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Tech Marketplace',
          style: GoogleFonts.chakraPetch(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              // Navigate to cart page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cart feature coming soon!'),
                  backgroundColor: Color.fromARGB(255, 7, 59, 58),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for tech products...',
                hintStyle: GoogleFonts.chakraPetch(color: Colors.black),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Categories
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == _selectedCategory;

                return GestureDetector(
                  onTap: () => _selectCategory(category),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? const Color.fromARGB(255, 146, 227, 169)
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color:
                            isSelected
                                ? const Color.fromARGB(255, 7, 59, 58)
                                : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Products header with sort options
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  child: Text(
                    _selectedCategory == 'All'
                        ? 'All Products'
                        : _selectedCategory,
                    style: GoogleFonts.chakraPetch(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Spacer(),
                // Sort dropdown
                DropdownButton<String>(
                  value: _sortOption,
                  underline: const SizedBox(),
                  hint: const Text('Sort by'),
                  items: const [
                    DropdownMenuItem(value: 'Newest', child: Text('Newest')),
                    DropdownMenuItem(
                      value: 'Price: Low to High',
                      child: Text('Price: Low to High'),
                    ),
                    DropdownMenuItem(
                      value: 'Price: High to Low',
                      child: Text('Price: High to Low'),
                    ),
                    DropdownMenuItem(value: 'Rating', child: Text('Rating')),
                  ],
                  onChanged: _changeSort,
                ),
              ],
            ),
          ),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_displayedProducts.length} products found',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                if (_searchController.text.isNotEmpty ||
                    _selectedCategory != 'All')
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() {
                          _selectedCategory = 'All';
                          _displayedProducts = ProductData.getAllProducts();
                        });
                      },
                      child: Text(
                        'Clear filters',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 7, 59, 58),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Grid of products
          Expanded(
            child:
                _displayedProducts.isEmpty
                    ? _buildNoProductsFound()
                    : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: _displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = _displayedProducts[index];
                        return _buildProductCard(product);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return ProductCard(product: product);
  }

  Widget _buildNoProductsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: GoogleFonts.chakraPetch(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or categories',
            style: GoogleFonts.chakraPetch(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
