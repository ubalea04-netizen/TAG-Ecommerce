import '../models/product.dart';
import '../models/auction_item.dart';

final List<Product> sampleProducts = [
  Product(
    id: 'p1',
    title: 'Wireless Headphones',
    category: 'Electronics',
    vendor: 'SoundWave',
    price: 2499.0,
    rating: 4.6,
    isAuction: false,
    imageUrl: 'https://via.placeholder.com/150',
    inventoryCount: 120,
  ),
  Product(
    id: 'p2',
    title: 'Smartwatch Pro',
    category: 'Wearables',
    vendor: 'TechPulse',
    price: 6999.0,
    rating: 4.4,
    isAuction: false,
    imageUrl: 'https://via.placeholder.com/150',
    inventoryCount: 64,
  ),
  Product(
    id: 'p3',
    title: 'Limited Edition Sneakers',
    category: 'Fashion',
    vendor: 'UrbanStyle',
    price: 3999.0,
    rating: 4.8,
    isAuction: true,
    imageUrl: 'https://via.placeholder.com/150',
    inventoryCount: 20,
  ),
];

final List<AuctionItem> sampleAuctions = [
  AuctionItem(
    id: 'a1',
    title: 'Collector Watch',
    vendor: 'ChronoShop',
    currentBid: 12500.0,
    startingBid: 9500.0,
    timeLeft: const Duration(hours: 1, minutes: 22, seconds: 50),
    imageUrl: 'https://via.placeholder.com/150',
  ),
  AuctionItem(
    id: 'a2',
    title: 'Luxury Handbag',
    vendor: 'StyleHouse',
    currentBid: 8200.0,
    startingBid: 6500.0,
    timeLeft: const Duration(hours: 2, minutes: 15, seconds: 33),
    imageUrl: 'https://via.placeholder.com/150',
  ),
];
