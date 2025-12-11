import 'package:flutter/material.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

abstract class ProductLocalDataSource {
  Future<List<CategoryEntity>> getCategories();
  Future<List<ProductEntity>> getProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<List<CategoryEntity>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      CategoryEntity(id: '1', name: 'New Arrivals', imageUrl: 'https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg', icon: Icons.new_releases),
      CategoryEntity(id: '2', name: 'Clothes', imageUrl: 'https://images.pexels.com/photos/996329/pexels-photo-996329.jpeg', icon: Icons.checkroom),
      CategoryEntity(id: '3', name: 'Bags', imageUrl: 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg', icon: Icons.shopping_bag),
      CategoryEntity(id: '4', name: 'Shoes', imageUrl: 'https://images.pexels.com/photos/1478442/pexels-photo-1478442.jpeg', icon: Icons.roller_skating),
      CategoryEntity(id: '5', name: 'Electronics', imageUrl: 'https://images.pexels.com/photos/356056/pexels-photo-356056.jpeg', icon: Icons.devices),
      CategoryEntity(id: '6', name: 'Jewelry', imageUrl: 'https://images.pexels.com/photos/265906/pexels-photo-265906.jpeg', icon: Icons.diamond),
      CategoryEntity(id: '7', name: 'Dresses', imageUrl: 'https://images.pexels.com/photos/985635/pexels-photo-985635.jpeg', icon: Icons.woman),
      CategoryEntity(id: '8', name: 'Jackets', imageUrl: 'https://images.pexels.com/photos/16170/pexels-photo.jpg', icon: Icons.checkroom_outlined),
      CategoryEntity(id: '9', name: 'Activewear', imageUrl: 'https://images.pexels.com/photos/863988/pexels-photo-863988.jpeg', icon: Icons.fitness_center),
      CategoryEntity(id: '10', name: 'Watches', imageUrl: 'https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg', icon: Icons.watch),
    ];
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      // -----------------------------
      // CATEGORY 1 — NEW ARRIVALS
      // -----------------------------
      _createProduct('1', 'Oversized Streetwear Hoodie', '<p>Premium <b>cotton hoodie</b> with a relaxed fit.</p><ul><li>100% Cotton</li><li>Oversized Fit</li><li>Machine Washable</li></ul>', 49.99, 'https://images.pexels.com/photos/767987/pexels-photo-767987.jpeg', '1', rating: 4.8, reviewCount: 124, isNew: true, sizes: ['S', 'M', 'L', 'XL'], colors: ['0xFF000000', '0xFF808080']),
      _createProduct('2', 'Beige Urban Cargo Pants', '<p>Trendy <b>cargo pants</b> perfect for everyday style.</p><p>Features:</p><ul><li>Multiple Pockets</li><li>Durable Fabric</li><li>Comfortable Fit</li></ul>', 59.99, 'https://images.pexels.com/photos/6311654/pexels-photo-6311654.jpeg', '1', rating: 4.5, reviewCount: 89, isNew: true, sizes: ['30', '32', '34', '36'], colors: ['0xFFF5F5DC', '0xFF000000']),
      _createProduct('3', 'Minimalist Sneakers', '<p>Clean <b>white sneakers</b> with soft cushioning.</p><br><p>Perfect for daily wear.</p>', 79.99, 'https://images.pexels.com/photos/267202/pexels-photo-267202.jpeg', '1', rating: 4.7, reviewCount: 210, isSale: true, sizes: ['7', '8', '9', '10', '11'], colors: ['0xFFFFFFFF']),
      _createProduct('4', 'Casual Knit Sweater', 'Lightweight knit sweater with modern texture.', 42.99, 'https://images.pexels.com/photos/794062/pexels-photo-794062.jpeg', '1', rating: 4.3, reviewCount: 56, sizes: ['S', 'M', 'L'], colors: ['0xFF000080', '0xFF808080']),
      _createProduct('5', 'Slim Fit Blue Denim', 'Premium stretch denim with slim silhouette.', 69.99, 'https://images.pexels.com/photos/428338/pexels-photo-428338.jpeg', '1', rating: 4.6, reviewCount: 150, sizes: ['30', '32', '34'], colors: ['0xFF0000FF']),

      // -----------------------------
      // CATEGORY 2 — CLOTHING
      // -----------------------------
      _createProduct('6', 'Classic White T-Shirt', 'Soft cotton t-shirt for everyday comfort.', 19.99, 'https://images.pexels.com/photos/10026434/pexels-photo-10026434.jpeg', '2', rating: 4.9, reviewCount: 500, sizes: ['S', 'M', 'L', 'XL'], colors: ['0xFFFFFFFF', '0xFF000000']),
      _createProduct('7', 'Black Denim Jacket', 'Rugged denim jacket with metal buttons.', 89.99, 'https://images.pexels.com/photos/532588/pexels-photo-532588.jpeg', '2', rating: 4.7, reviewCount: 90, isNew: true, sizes: ['M', 'L', 'XL'], colors: ['0xFF000000']),
      _createProduct('8', 'Beige Chino Pants', 'Classic chinos with tapered fit.', 39.99, 'https://images.pexels.com/photos/6311608/pexels-photo-6311608.jpeg', '2', rating: 4.4, reviewCount: 75, sizes: ['30', '32', '34'], colors: ['0xFFF5F5DC']),
      _createProduct('9', 'Striped Summer Shirt', 'Breathable linen shirt with vertical stripes.', 34.99, 'https://images.pexels.com/photos/769109/pexels-photo-769109.jpeg', '2', rating: 4.5, reviewCount: 60, isSale: true, sizes: ['S', 'M', 'L'], colors: ['0xFFFFFFFF', '0xFFADD8E6']),
      _createProduct('10', 'Black Formal Suit', 'Elegant slim-fit formal suit for events.', 129.99, 'https://images.pexels.com/photos/8387834/pexels-photo-8387834.jpeg', '2', rating: 4.8, reviewCount: 45, sizes: ['38', '40', '42'], colors: ['0xFF000000']),

      // -----------------------------
      // CATEGORY 3 — ACCESSORIES
      // -----------------------------
      _createProduct('11', 'Classic Sunglasses', 'UV-protected fashionable sunglasses.', 24.99, 'https://images.pexels.com/photos/2747598/pexels-photo-2747598.jpeg', '3', rating: 4.6, reviewCount: 110, colors: ['0xFF000000', '0xFF8B4513']),
      _createProduct('12', 'Leather Belt', 'Full-grain leather belt with metal buckle.', 29.99, 'https://images.pexels.com/photos/6311525/pexels-photo-6311525.jpeg', '3', rating: 4.5, reviewCount: 88, colors: ['0xFF000000', '0xFF8B4513']),
      _createProduct('13', 'Stylish Cap', 'Adjustable streetwear-style cap.', 14.99, 'https://images.pexels.com/photos/6311582/pexels-photo-6311582.jpeg', '3', rating: 4.3, reviewCount: 65, sizes: ['Free Size'], colors: ['0xFF000000', '0xFFFFFFFF']),
      _createProduct('14', 'Minimalist Wallet', 'Slim wallet crafted from premium leather.', 39.99, 'https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg', '3', rating: 4.8, reviewCount: 200, isNew: true, colors: ['0xFF8B4513', '0xFF000000']),
      _createProduct('15', 'Fashion Scarf', 'Lightweight scarf suitable for all seasons.', 19.99, 'https://images.pexels.com/photos/4012669/pexels-photo-4012669.jpeg', '3', rating: 4.4, reviewCount: 50, colors: ['0xFFFFC0CB', '0xFF808080']),

      // -----------------------------
      // CATEGORY 4 — SHOES
      // -----------------------------
      _createProduct('16', 'Running Sneakers', 'Comfortable and lightweight running shoes.', 79.99, 'https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg', '4', rating: 4.7, reviewCount: 180, sizes: ['7', '8', '9', '10', '11'], colors: ['0xFF0000FF', '0xFF808080']),
      _createProduct('17', 'Leather Boots', 'Durable leather boots for men.', 129.99, 'https://images.pexels.com/photos/186035/pexels-photo-186035.jpeg', '4', rating: 4.8, reviewCount: 95, sizes: ['8', '9', '10', '11'], colors: ['0xFF8B4513']),
      _createProduct('18', 'White Casual Shoes', 'Minimalist shoes with clean design.', 49.99, 'https://images.pexels.com/photos/461633/pexels-photo-461633.jpeg', '4', rating: 4.5, reviewCount: 130, sizes: ['7', '8', '9', '10'], colors: ['0xFFFFFFFF']),
      _createProduct('19', 'High Heels', 'Elegant heels for women.', 59.99, 'https://images.pexels.com/photos/894505/pexels-photo-894505.jpeg', '4', rating: 4.6, reviewCount: 70, isSale: true, sizes: ['5', '6', '7', '8'], colors: ['0xFF000000', '0xFFFF0000']),
      _createProduct('20', 'Slip-On Shoes', 'Breathable slip-ons with flexible fit.', 39.99, 'https://images.pexels.com/photos/19090/pexels-photo.jpg', '4', rating: 4.4, reviewCount: 60, sizes: ['7', '8', '9', '10'], colors: ['0xFF808080']),

      // -----------------------------
      // CATEGORY 5 — BAGS
      // -----------------------------
      _createProduct('21', 'Leather Handbag', 'Premium handmade handbag.', 159.99, 'https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg', '5', rating: 4.9, reviewCount: 45, isNew: true, colors: ['0xFF8B4513', '0xFF000000']),
      _createProduct('22', 'Black Backpack', 'Durable backpack made for daily use.', 49.99, 'https://images.pexels.com/photos/6311655/pexels-photo-6311655.jpeg', '5', rating: 4.7, reviewCount: 150, colors: ['0xFF000000']),
      _createProduct('23', 'Beige Tote Bag', 'Lightweight tote bag for women.', 24.99, 'https://images.pexels.com/photos/6311002/pexels-photo-6311002.jpeg', '5', rating: 4.5, reviewCount: 80, colors: ['0xFFF5F5DC']),
      _createProduct('24', 'Laptop Bag', 'Shockproof business laptop bag.', 69.99, 'https://images.pexels.com/photos/572896/pexels-photo-572896.jpeg', '5', rating: 4.8, reviewCount: 120, colors: ['0xFF808080', '0xFF000000']),
      _createProduct('25', 'Travel Duffel Bag', 'Spacious duffel bag for travel.', 89.99, 'https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg', '5', rating: 4.6, reviewCount: 65, sizes: ['Large'], colors: ['0xFF00008B']),

      // -----------------------------
      // CATEGORY 6 — WATCHES
      // -----------------------------
      _createProduct('26', 'Classic Leather Watch', 'Elegant watch with leather straps.', 119.99, 'https://images.pexels.com/photos/277319/pexels-photo-277319.jpeg', '6', rating: 4.8, reviewCount: 90, colors: ['0xFF8B4513', '0xFF000000']),
      _createProduct('27', 'Gold Wristwatch', 'Luxury gold-toned wristwatch.', 249.99, 'https://images.pexels.com/photos/125779/pexels-photo-125779.jpeg', '6', rating: 4.9, reviewCount: 30, isNew: true, colors: ['0xFFFFD700']),
      _createProduct('28', 'Sports Digital Watch', 'Water-resistant sporty digital watch.', 59.99, 'https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg', '6', rating: 4.5, reviewCount: 200, colors: ['0xFF000000']),
      _createProduct('29', 'Metal Strap Watch', 'Stainless steel strap with a modern dial.', 139.99, 'https://images.pexels.com/photos/112460/pexels-photo-112460.jpeg', '6', rating: 4.7, reviewCount: 85, colors: ['0xFFC0C0C0']),
      _createProduct('30', 'Minimalist Watch', 'Simple and stylish minimalist watch.', 89.99, 'https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg', '6', rating: 4.6, reviewCount: 110, colors: ['0xFF000000', '0xFFFFFFFF']),

      // -----------------------------
      // CATEGORY 7 — JEWELRY
      // -----------------------------
      _createProduct('31', 'Gold Necklace', 'Beautiful chain necklace for women.', 149.99, 'https://images.pexels.com/photos/1453005/pexels-photo-1453005.jpeg', '7', rating: 4.9, reviewCount: 60, colors: ['0xFFFFD700']),
      _createProduct('32', 'Pearl Earrings', 'Elegant pearl earrings for events.', 79.99, 'https://images.pexels.com/photos/2698519/pexels-photo-2698519.jpeg', '7', rating: 4.8, reviewCount: 45, colors: ['0xFFFFFFFF']),
      _createProduct('33', 'Silver Bracelet', 'Sterling silver bracelet with smooth finish.', 59.99, 'https://images.pexels.com/photos/1191536/pexels-photo-1191536.jpeg', '7', rating: 4.7, reviewCount: 70, colors: ['0xFFC0C0C0']),
      _createProduct('34', 'Diamond Ring', 'Premium solitaire diamond ring.', 499.99, 'https://images.pexels.com/photos/771446/pexels-photo-771446.jpeg', '7', rating: 5.0, reviewCount: 20, isNew: true, sizes: ['5', '6', '7'], colors: ['0xFFC0C0C0']),
      _createProduct('35', 'Gold Bangles', 'Traditional handcrafted bangles.', 129.99, 'https://images.pexels.com/photos/1453005/pexels-photo-1453005.jpeg', '7', rating: 4.6, reviewCount: 88, sizes: ['2.4', '2.6', '2.8'], colors: ['0xFFFFD700']),

      // -----------------------------
      // CATEGORY 8 — WINTER WEAR
      // -----------------------------
      _createProduct('36', 'Wool Sweater', 'Thick premium wool sweater.', 59.99, 'https://images.pexels.com/photos/6311656/pexels-photo-6311656.jpeg', '8', rating: 4.7, reviewCount: 150, sizes: ['S', 'M', 'L', 'XL'], colors: ['0xFF808080', '0xFF000000']),
      _createProduct('37', 'Puffer Jacket', 'Warm padded jacket for cold seasons.', 109.99, 'https://images.pexels.com/photos/6311561/pexels-photo-6311561.jpeg', '8', rating: 4.8, reviewCount: 95, colors: ['0xFF000000', '0xFF0000FF']),
      _createProduct('38', 'Knitted Scarf', 'Soft and warm knitted scarf.', 19.99, 'https://images.pexels.com/photos/4012669/pexels-photo-4012669.jpeg', '8', rating: 4.5, reviewCount: 120, colors: ['0xFFF5F5DC', '0xFF800000']),
      _createProduct('39', 'Winter Boots', 'Insulated boots suitable for snow.', 89.99, 'https://images.pexels.com/photos/186035/pexels-photo-186035.jpeg', '8', rating: 4.7, reviewCount: 80, sizes: ['7', '8', '9', '10'], colors: ['0xFF8B4513']),
      _createProduct('40', 'Beanie Cap', 'Warm beanie for winter days.', 14.99, 'https://images.pexels.com/photos/6311571/pexels-photo-6311571.jpeg', '8', rating: 4.6, reviewCount: 200, sizes: ['Free Size'], colors: ['0xFF000000', '0xFF808080']),

      // -----------------------------
      // CATEGORY 9 — SPORTSWEAR
      // -----------------------------
      _createProduct('41', 'Running Tee', 'Quick-dry breathable running t-shirt.', 24.99, 'https://images.pexels.com/photos/841130/pexels-photo-841130.jpeg', '9', rating: 4.6, reviewCount: 110, sizes: ['S', 'M', 'L', 'XL'], colors: ['0xFF0000FF', '0xFF000000']),
      _createProduct('42', 'Gym Shorts', 'Stretchable gym shorts for workouts.', 19.99, 'https://images.pexels.com/photos/416778/pexels-photo-416778.jpeg', '9', rating: 4.5, reviewCount: 90, sizes: ['S', 'M', 'L'], colors: ['0xFF000000', '0xFF808080']),
      _createProduct('43', 'Yoga Pants', 'High-waist yoga pants for women.', 29.99, 'https://images.pexels.com/photos/3757370/pexels-photo-3757370.jpeg', '9', rating: 4.7, reviewCount: 150, sizes: ['XS', 'S', 'M', 'L'], colors: ['0xFF000000']),
      _createProduct('44', 'Sports Hoodie', 'Sweat-wicking gym hoodie.', 49.99, 'https://images.pexels.com/photos/6311654/pexels-photo-6311654.jpeg', '9', rating: 4.8, reviewCount: 75, colors: ['0xFF808080', '0xFF000000']),
      _createProduct('45', 'Training Shoes', 'Durable shoes designed for training.', 69.99, 'https://images.pexels.com/photos/267202/pexels-photo-267202.jpeg', '9', rating: 4.6, reviewCount: 100, sizes: ['7', '8', '9', '10'], colors: ['0xFF000000']),

      // -----------------------------
      // CATEGORY 10 — KIDS FASHION
      // -----------------------------
      _createProduct('46', 'Kids T-Shirt', 'Colorful soft cotton t-shirt for kids.', 14.99, 'https://images.pexels.com/photos/1912868/pexels-photo-1912868.jpeg', '10', rating: 4.5, reviewCount: 80, sizes: ['XS', 'S', 'M'], colors: ['0xFFFF0000', '0xFF0000FF', '0xFFFFFF00']),
      _createProduct('47', 'Kids Sneakers', 'Comfortable sneakers for children.', 29.99, 'https://images.pexels.com/photos/1299791/pexels-photo-1299791.jpeg', '10', rating: 4.7, reviewCount: 60, sizes: ['1', '2', '3', '4'], colors: ['0xFFFFFFFF']),
      _createProduct('48', 'Kids Hoodie', 'Warm and cozy hoodie for kids.', 24.99, 'https://images.pexels.com/photos/2783873/pexels-photo-2783873.jpeg', '10', rating: 4.6, reviewCount: 50, colors: ['0xFF0000FF']),
      _createProduct('49', 'Kids Jeans', 'Durable denim jeans for children.', 19.99, 'https://images.pexels.com/photos/1648383/pexels-photo-1648383.jpeg', '10', rating: 4.4, reviewCount: 90, sizes: ['4', '5', '6', '7'], colors: ['0xFF00008B']),
      _createProduct('50', 'Kids Dress', 'Cute casual dress for girls.', 24.99, 'https://images.pexels.com/photos/1648384/pexels-photo-1648384.jpeg', '10', rating: 4.8, reviewCount: 40, sizes: ['S', 'M', 'L'], colors: ['0xFFFFC0CB']),

      // -----------------------------
      // CATEGORY 11 — MEN’S FASHION
      // -----------------------------
      _createProduct('51', 'Men’s Formal Shirt', 'Slim-fit formal shirt.', 34.99, 'https://images.pexels.com/photos/2506943/pexels-photo-2506943.jpeg', '11', rating: 4.6, reviewCount: 110, sizes: ['S', 'M', 'L', 'XL'], colors: ['0xFFFFFFFF', '0xFFADD8E6']),
      _createProduct('52', 'Men’s Leather Jacket', 'Classic black leather jacket.', 149.99, 'https://images.pexels.com/photos/428338/pexels-photo-428338.jpeg', '11', rating: 4.9, reviewCount: 75, isNew: true, sizes: ['M', 'L', 'XL'], colors: ['0xFF000000']),
      _createProduct('53', 'Men’s Jeans', 'Stretchable slim-fit jeans.', 39.99, 'https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg', '11', rating: 4.5, reviewCount: 150, sizes: ['30', '32', '34', '36'], colors: ['0xFF0000FF']),
      _createProduct('54', 'Men’s Kurta', 'Traditional kurta for men.', 29.99, 'https://images.pexels.com/photos/1536582/pexels-photo-1536582.jpeg', '11', rating: 4.4, reviewCount: 60, sizes: ['M', 'L', 'XL'], colors: ['0xFFFFFF00']),
      _createProduct('55', 'Men’s Sneakers', 'Fashionable and lightweight sneakers.', 49.99, 'https://images.pexels.com/photos/19090/pexels-photo.jpg', '11', rating: 4.7, reviewCount: 130, sizes: ['8', '9', '10', '11'], colors: ['0xFFFFFFFF', '0xFF000000']),

      // -----------------------------
      // CATEGORY 12 — WOMEN’S FASHION
      // -----------------------------
      _createProduct('56', 'Women’s Summer Dress', 'Light and airy floral summer dress.', 39.99, 'https://images.pexels.com/photos/428340/pexels-photo-428340.jpeg', '12', rating: 4.8, reviewCount: 160, sizes: ['S', 'M', 'L'], colors: ['0xFFFFC0CB', '0xFFFFFFFF']),
      _createProduct('57', 'Women’s Blazer', 'Elegant blazer for formal wear.', 59.99, 'https://images.pexels.com/photos/1488463/pexels-photo-1488463.jpeg', '12', rating: 4.7, reviewCount: 90, sizes: ['S', 'M', 'L'], colors: ['0xFF000000', '0xFFFFFFFF']),
      _createProduct('58', 'Women’s Handbag', 'Stylish PU leather handbag.', 49.99, 'https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg', '12', rating: 4.6, reviewCount: 110, colors: ['0xFF8B4513', '0xFF000000']),
      _createProduct('59', 'Women’s Sandals', 'Comfortable sandals for daily wear.', 24.99, 'https://images.pexels.com/photos/1936848/pexels-photo-1936848.jpeg', '12', rating: 4.5, reviewCount: 85, sizes: ['5', '6', '7', '8'], colors: ['0xFFF5F5DC']),
      _createProduct('60', 'Women’s Top', 'V-neck stylish top for women.', 29.99, 'https://images.pexels.com/photos/6311572/pexels-photo-6311572.jpeg', '12', rating: 4.6, reviewCount: 95, sizes: ['S', 'M', 'L'], colors: ['0xFF000000', '0xFFFFFF00']),
    ];
  }

  ProductEntity _createProduct(
    String id,
    String name,
    String description,
    double price,
    String imageUrl,
    String categoryId, {
    double rating = 4.0,
    int reviewCount = 0,
    bool isNew = false,
    bool isSale = false,
    List<String> sizes = const [],
    List<String> colors = const [],
  }) => ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      categoryId: categoryId,
      rating: rating,
      reviewCount: reviewCount,
      isNew: isNew,
      isSale: isSale,
      sizes: sizes,
      colors: colors,
    );
}
