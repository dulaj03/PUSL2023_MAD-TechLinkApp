import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_link/data/market_place.dart';
import 'package:tech_link/model/market_place.dart';
import 'package:tech_link/providers/user_provider.dart';
import 'package:tech_link/services/stripe_services.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  const ProductDetailsPage({Key? key, required this.productId})
    : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Product _product;
  bool _isLoading = true;
  bool _isFavorite = false;
  int _quantity = 1;
  int _selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() async {
    // Simulate network loading
    await Future.delayed(const Duration(milliseconds: 500));

    final product = ProductData.getProductById(widget.productId);

    if (product != null) {
      setState(() {
        _product = product;
        _isFavorite = product.isFavorite;
        _isLoading = false;
      });
    } else {
      // Handle product not found
      Navigator.pop(context);
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      // In a real app, you would update this in your database
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Added to favorites' : 'Removed from favorites',
          style: GoogleFonts.chakraPetch(),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 58),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addToCart() {
    // In a real app, you would add this product to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added $_quantity ${_product.name} to cart',
          style: GoogleFonts.chakraPetch(),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 58),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _buyNow() async {
    final user = context.read<UserProvider>();
    user.toggleLoading();
    await StripeService.instance.makePayment("Navindu");
    user.toggleLoading();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Product Details',
            style: GoogleFonts.chakraPetch(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 7, 59, 58),
          ),
        ),
      );
    }

    // List of all images (main + additional)
    final allImages = [_product.imageUrl];
    if (_product.additionalImages != null) {
      allImages.addAll(_product.additionalImages!);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main image
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      allImages[_selectedImageIndex],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Image selector
                  if (allImages.length > 1)
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: allImages.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedImageIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImageIndex = index;
                              });
                            },
                            child: Container(
                              width: 70,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? const Color.fromARGB(255, 7, 59, 58)
                                          : Colors.grey.shade300,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  allImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  // Product info
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              146,
                              227,
                              169,
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _product.category,
                            style: GoogleFonts.chakraPetch(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 7, 59, 58),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Product name
                        Text(
                          _product.name,
                          style: GoogleFonts.chakraPetch(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Rating
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                i < _product.rating.floor()
                                    ? Icons.star
                                    : i < _product.rating
                                    ? Icons.star_half
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              ),
                            const SizedBox(width: 8),
                            Text(
                              '${_product.rating} (${_product.reviewCount} reviews)',
                              style: GoogleFonts.chakraPetch(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Price
                        Row(
                          children: [
                            Text(
                              '\Rs.${_product.price.toStringAsFixed(2)}',
                              style: GoogleFonts.chakraPetch(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 7, 59, 58),
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (_product.originalPrice != null &&
                                _product.originalPrice! > _product.price)
                              Text(
                                '\Rs.${_product.originalPrice!.toStringAsFixed(2)}',
                                style: GoogleFonts.chakraPetch(
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[500],
                                ),
                              ),
                          ],
                        ),

                        // Availability
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              _product.inStock
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color:
                                  _product.inStock ? Colors.green : Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _product.inStock ? 'In Stock' : 'Out of Stock',
                              style: GoogleFonts.chakraPetch(
                                color:
                                    _product.inStock
                                        ? Colors.green
                                        : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const Divider(height: 32),

                        // Quantity selector
                        Row(
                          children: [
                            Text(
                              'Quantity',
                              style: GoogleFonts.chakraPetch(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed:
                                        _quantity > 1
                                            ? () {
                                              setState(() {
                                                _quantity--;
                                              });
                                            }
                                            : null,
                                    color:
                                        _quantity > 1
                                            ? const Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              58,
                                            )
                                            : Colors.grey,
                                    iconSize: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      '$_quantity',
                                      style: GoogleFonts.chakraPetch(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                    color: const Color.fromARGB(255, 7, 59, 58),
                                    iconSize: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Description header
                        Text(
                          'Description',
                          style: GoogleFonts.chakraPetch(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Description
                        Text(
                          _product.description,
                          style: GoogleFonts.chakraPetch(
                            fontSize: 14,
                            color: Colors.grey[800],
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Features header
                        Text(
                          'Features',
                          style: GoogleFonts.chakraPetch(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Features list
                        ...(_product.features ?? [])
                            .map(
                              (feature) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: const Color.fromARGB(
                                        255,
                                        146,
                                        227,
                                        169,
                                      ),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: GoogleFonts.chakraPetch(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),

                        const SizedBox(height: 24),

                        // Specifications header
                        Text(
                          'Specifications',
                          style: GoogleFonts.chakraPetch(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Specifications
                        if (_product.specifications != null)
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children:
                                  _product.specifications!.entries.map((entry) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              entry.key,
                                              style: GoogleFonts.chakraPetch(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              entry.value,
                                              style: GoogleFonts.chakraPetch(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),

                        const SizedBox(height: 40),

                        // Related products header
                        if (_product.relatedProducts != null &&
                            _product.relatedProducts!.isNotEmpty)
                          Text(
                            'You May Also Like',
                            style: GoogleFonts.chakraPetch(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                        // Related products
                        if (_product.relatedProducts != null &&
                            _product.relatedProducts!.isNotEmpty)
                          Container(
                            height: 180,
                            margin: const EdgeInsets.only(top: 12),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _product.relatedProducts!.length,
                              itemBuilder: (context, index) {
                                final relatedProductId =
                                    _product.relatedProducts![index];
                                final relatedProduct =
                                    ProductData.getProductById(
                                      relatedProductId,
                                    );

                                if (relatedProduct == null) {
                                  return const SizedBox();
                                }

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProductDetailsPage(
                                              productId: relatedProduct.id,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 160,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(8),
                                              ),
                                          child: Image.asset(
                                            relatedProduct.imageUrl,
                                            height: 100,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                relatedProduct.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.chakraPetch(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '\Rs.${relatedProduct.price.toStringAsFixed(2)}',
                                                style: GoogleFonts.chakraPetch(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    58,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom purchase bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                // Add to cart button
                Expanded(
                  child: OutlinedButton(
                    onPressed: _product.inStock ? _addToCart : null,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color:
                            _product.inStock
                                ? const Color.fromARGB(255, 7, 59, 58)
                                : Colors.grey,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: GoogleFonts.chakraPetch(
                        color:
                            _product.inStock
                                ? const Color.fromARGB(255, 7, 59, 58)
                                : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Buy now button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _product.inStock ? _buyNow : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          context.watch<UserProvider>().isLoading
                              ? Colors.grey
                              : const Color.fromARGB(255, 7, 59, 58),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child:
                        context.watch<UserProvider>().isLoading
                            ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : Text(
                              'Buy Now',
                              style: GoogleFonts.chakraPetch(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
