import 'package:tech_link/model/market_place.dart';

class ProductData {
  static final List<Product> _products = [
    // IoT Devices
    Product(
      id: '1',
      name: 'Smart Home Hub',
      category: 'IoT Devices',
      price: 16000,
      originalPrice: 35500,
      description:
          'Control all your smart home devices from one central hub. Works with Amazon Alexa, Google Assistant, and Apple HomeKit. Easily manage lighting, thermostats, security, and more.',
      imageUrl: 'assets/aeotec-smart-home-hub-1.jpeg',
      additionalImages: ['assets/home hub.jpg'],
      rating: 4.7,
      reviewCount: 256,
      inStock: true,
      features: [
        'Compatible with over 100 smart home brands',
        'Voice control support',
        'Automation scheduling',
        'Energy monitoring',
        'Mobile app control',
      ],
      specifications: {
        'Connectivity': 'Wi-Fi, Bluetooth, Zigbee, Z-Wave',
        'Power': 'AC adapter (included)',
        'Dimensions': '4.5 x 4.5 x 1.2 inches',
        'Weight': '8.5 oz',
        'Warranty': '2-year limited warranty',
      },
      relatedProducts: ['5', '8', '12'],
    ),

    Product(
      id: '2',
      name: 'Developer Laptop Pro',
      category: 'Hardware',
      price: 649000,
      description:
          'Ultimate development machine with 16GB RAM, 1TB SSD, and the latest generation processor. Perfect for running multiple virtual machines, containers, and development environments.',
      imageUrl: 'assets/600.png',
      additionalImages: ['assets/bundle-pd1.png', 'assets/images.jpg'],
      rating: 4.9,
      reviewCount: 183,
      inStock: true,
      features: [
        '16-core CPU for parallel processing',
        'Dedicated GPU for ML workloads',
        'Ultra-fast SSD storage',
        'High-resolution display',
        'Extended battery life',
      ],
      specifications: {
        'CPU': '16-core processor @ 3.2GHz',
        'RAM': '16GB DDR4 (upgradable to 64GB)',
        'Storage': '1TB NVMe SSD',
        'Display': '15.6" 4K (3840x2160) IPS',
        'Graphics': 'Dedicated 8GB GDDR6',
        'Battery': 'Up to 10 hours',
      },
      relatedProducts: ['3', '4', '7'],
    ),

    Product(
      id: '3',
      name: 'Full Stack Development Course',
      category: 'Software',
      price: 5500,
      originalPrice: 17000,
      description:
          'Comprehensive course covering front-end and back-end technologies. Learn HTML, CSS, JavaScript, React, Node.js, and MongoDB to build complete web applications from scratch.',
      imageUrl: 'assets/full-stack-web-developmen-selar.co-64aec65249d13.png',
      rating: 4.8,
      reviewCount: 1024,
      inStock: true,
      features: [
        '50+ hours of video content',
        'Hands-on projects',
        'Certificate of completion',
        'Life-time access',
        'Community support',
      ],
      specifications: {
        'Level': 'Beginner to Advanced',
        'Duration': '12 weeks',
        'Languages': 'HTML, CSS, JavaScript',
        'Frameworks': 'React, Node.js, Express',
        'Database': 'MongoDB',
        'Updates': 'Free lifetime updates',
      },
      relatedProducts: ['6', '9', '11'],
    ),

    Product(
      id: '4',
      name: 'Professional Mechanical Keyboard',
      category: 'Hardware',
      price: 18000,
      description:
          'Programmable mechanical keyboard with customizable RGB lighting. Features hot-swappable switches, macro programming, and ergonomic design for comfortable coding sessions.',
      imageUrl: 'assets/keyboard.jpg',
      rating: 4.6,
      reviewCount: 472,
      inStock: true,
      features: [
        'Hot-swappable mechanical switches',
        'Programmable keys and macros',
        'RGB backlighting with effects',
        'Ergonomic wrist rest included',
        'Durable aluminum frame',
      ],
      specifications: {
        'Switch Type': 'Cherry MX Brown (tactile)',
        'Layout': 'Full size, 104 keys',
        'Connectivity': 'USB-C (detachable cable)',
        'Backlight': 'Per-key RGB',
        'Material': 'Aluminum top plate, PBT keycaps',
      },
      relatedProducts: ['7', '10'],
    ),

    Product(
      id: '5',
      name: 'Smart Wi-Fi Development Board',
      category: 'IoT Devices',
      price: 4500,
      description:
          'Compact Wi-Fi enabled development board perfect for IoT projects. Built-in sensors, low power consumption, and easy programming via Arduino IDE or MicroPython.',
      imageUrl: 'assets/wifi.jpg',
      rating: 4.5,
      reviewCount: 318,
      inStock: true,
      features: [
        'Wi-Fi and Bluetooth connectivity',
        'Multiple GPIO pins',
        'Built-in temperature & humidity sensor',
        'Low power deep sleep mode',
        'Arduino and MicroPython compatible',
      ],
      specifications: {
        'Processor': 'Dual-core 32-bit MCU',
        'Memory': '4MB Flash, 520KB SRAM',
        'Connectivity': 'Wi-Fi 802.11 b/g/n, Bluetooth 4.2',
        'I/O': '36 GPIO pins',
        'Power': 'USB or 3.3V battery',
      },
      relatedProducts: ['1', '8', '12'],
    ),

    Product(
      id: '6',
      name: 'DevOps & Cloud Certification Bundle',
      category: 'Software',
      price: 13000,
      originalPrice: 32000,
      description:
          'Complete certification preparation for AWS, Azure, and Google Cloud. Includes DevOps practices, CI/CD pipelines, container orchestration, and infrastructure as code.',
      imageUrl: 'assets/devops.png',
      rating: 4.7,
      reviewCount: 864,
      inStock: true,
      features: [
        'Practice exams for all certifications',
        'Hands-on labs with cloud platforms',
        'Infrastructure as Code templates',
        'CI/CD pipeline examples',
        'Kubernetes & Docker mastery',
      ],
      specifications: {
        'Certifications': 'AWS, Azure, Google Cloud',
        'Topics': 'DevOps, CI/CD, Containers, IaC',
        'Level': 'Intermediate to Advanced',
        'Duration': '6 months access',
        'Format': 'Video courses, labs, practice exams',
      },
      relatedProducts: ['3', '9', '11'],
    ),

    Product(
      id: '7',
      name: 'Ultra-wide Developer Monitor',
      category: 'Hardware',
      price: 240000,
      description:
          '34-inch curved ultrawide monitor designed for developers. Split screen capability, high resolution, and eye-care technology for comfortable long coding sessions.',
      imageUrl: 'assets/monitir.png',
      rating: 4.8,
      reviewCount: 230,
      inStock: true,
      features: [
        '34" ultrawide curved display',
        'WQHD resolution (3440x1440)',
        'Multiple input ports (HDMI, DisplayPort, USB-C)',
        'Built-in KVM switch',
        'Low blue light & flicker-free technology',
      ],
      specifications: {
        'Panel Type': 'IPS',
        'Size': '34 inches, 21:9 aspect ratio',
        'Resolution': '3440 x 1440 (WQHD)',
        'Refresh Rate': '100Hz',
        'Connectivity': 'HDMI 2.0, DisplayPort 1.4, USB-C',
        'Features': 'Picture-by-picture, VESA mount compatible',
      },
      relatedProducts: ['2', '4', '10'],
    ),

    Product(
      id: '10',
      name: 'Developer T-Shirt Bundle',
      category: 'Merchandise',
      price: 7560,
      description:
          'Set of 3 premium cotton t-shirts with funny programming quotes and designs. Comfortable for everyday wear and perfect for showing off your tech passion.',
      imageUrl: 'assets/tshirt.jpg',
      rating: 4.4,
      reviewCount: 189,
      inStock: true,
      features: [
        'Set of 3 different designs',
        '100% premium cotton',
        'Comfortable fit',
        'Durable print quality',
        'Sizes XS to 3XL available',
      ],
      specifications: {
        'Material': '100% cotton',
        'Designs': 'Funny programming quotes and graphics',
        'Sizes': 'XS, S, M, L, XL, 2XL, 3XL',
        'Care': 'Machine washable, inside out',
        'Made in': 'Ethically produced',
      },
      relatedProducts: ['13', '14'],
    ),

    Product(
      id: '11',
      name: 'Cybersecurity Bootcamp',
      category: 'Software',
      price: 24000,
      originalPrice: 35000,
      description:
          'Intensive cybersecurity training covering ethical hacking, penetration testing, network security, and security best practices. Includes virtual lab access for hands-on practice.',
      imageUrl: 'assets/cyber.png',
      rating: 4.8,
      reviewCount: 638,
      inStock: true,
      features: [
        'Ethical hacking techniques',
        'Penetration testing methodologies',
        'Network security fundamentals',
        'Security tools and utilities',
        'Virtual lab environment',
      ],
      specifications: {
        'Level': 'Intermediate to Advanced',
        'Duration': '12 weeks',
        'Tools': 'Kali Linux, Metasploit, Wireshark',
        'Topics': 'Web security, network security, cryptography',
        'Certificate': 'Yes, upon completion',
      },
      relatedProducts: ['3', '6', '9'],
    ),

    Product(
      id: '12',
      name: 'Raspberry Pi 4 Complete Kit',
      category: 'IoT Devices',
      price: 34500,
      description:
          'Complete Raspberry Pi 4 starter kit with 8GB RAM, case, power supply, cooling fan, and pre-loaded SD card. Perfect for learning Linux, home automation, or building a retro gaming console.',
      imageUrl: 'assets/rasberry.jpg',
      rating: 4.7,
      reviewCount: 521,
      inStock: true,
      features: [
        'Raspberry Pi 4 Model B with 8GB RAM',
        'Premium case with cooling fan',
        'Official power supply',
        '128GB SD card with OS pre-loaded',
        'HDMI cables and heatsinks included',
      ],
      specifications: {
        'Processor': 'Quad-core Cortex-A72 @ 1.5GHz',
        'Memory': '8GB LPDDR4-3200 SDRAM',
        'Connectivity':
            '2.4 GHz and 5.0 GHz IEEE 802.11ac, Bluetooth 5.0, Gigabit Ethernet',
        'Ports': '2 × USB 3.0, 2 × USB 2.0, 2 × micro-HDMI',
        'Storage': '128GB Class 10 microSD card',
      },
      relatedProducts: ['1', '5', '8'],
    ),

    Product(
      id: '13',
      name: 'Developer Coffee Mug',
      category: 'Merchandise',
      price: 3250,
      description:
          'Large ceramic coffee mug with funny programming joke. Holds 15oz of your favorite coding fuel and is dishwasher safe.',
      imageUrl: 'assets/cup.jpg',
      rating: 4.5,
      reviewCount: 247,
      inStock: true,
      features: [
        'Funny programming joke print',
        'Large 15oz capacity',
        'Durable ceramic construction',
        'Dishwasher and microwave safe',
        'Comfortable handle design',
      ],
      specifications: {
        'Material': 'Ceramic',
        'Capacity': '15 oz (450ml)',
        'Design': 'Funny programming joke and code snippet',
        'Dimensions': '4.5" tall, 3.25" diameter',
        'Care': 'Dishwasher and microwave safe',
      },
      relatedProducts: ['10', '14'],
    ),
  ];

  // Get all products
  static List<Product> getAllProducts() {
    return _products;
  }

  // Get products by category
  static List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  // Get product by ID
  static Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null; // Product not found
    }
  }

  // Search products
  static List<Product> searchProducts(String query) {
    if (query.isEmpty) {
      return _products;
    }

    final lowerQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery) ||
          product.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // Get featured products (for example, ones with ratings > 4.7)
  static List<Product> getFeaturedProducts() {
    return _products.where((product) => product.rating > 4.7).toList();
  }

  // Get categories
  static List<String> getCategories() {
    final categories =
        _products.map((product) => product.category).toSet().toList();
    return categories;
  }
}
