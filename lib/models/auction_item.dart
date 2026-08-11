class AuctionItem {
  final String id;
  final String title;
  final String vendor;
  double currentBid;
  final double startingBid;
  final Duration timeLeft;
  final String imageUrl;

  AuctionItem({
    required this.id,
    required this.title,
    required this.vendor,
    required this.currentBid,
    required this.startingBid,
    required this.timeLeft,
    required this.imageUrl,
  });
}
