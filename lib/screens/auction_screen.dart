import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/auction_item.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  late List<AuctionItem> auctions;

  @override
  void initState() {
    super.initState();
    auctions = sampleAuctions.map((item) => AuctionItem(
      id: item.id,
      title: item.title,
      vendor: item.vendor,
      currentBid: item.currentBid,
      startingBid: item.startingBid,
      timeLeft: item.timeLeft,
      imageUrl: item.imageUrl,
    )).toList();
  }

  void _placeBid(AuctionItem item) {
    setState(() {
      item.currentBid += 500;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bid placed on ${item.title}: ₹${item.currentBid.toStringAsFixed(0)}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auction Hub')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Live Auction Listings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...auctions.map((auction) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.network(auction.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(auction.title),
              subtitle: Text('Current bid: ₹${auction.currentBid.toStringAsFixed(0)} • Ends in ${_formatDuration(auction.timeLeft)}'),
              trailing: ElevatedButton(onPressed: () => _placeBid(auction), child: const Text('Bid')),
            ),
          )).toList(),
          const SizedBox(height: 24),
          const Text('Auction Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Sellers can list auction products with a starting bid, time limit, and automatic highest-bid winner determination. Buyers can place bids in real time.',
          ),
          const SizedBox(height: 16),
          const Text('Top bidder winner will be selected automatically once auction time expires.'),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
