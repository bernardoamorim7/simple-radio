import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_models/home_view_model.dart';
import 'widgets/radio_tile.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.radio),
        title: const Text('Simple Radio'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem<String>(
                value: 'about',
                child: Text('About'),
              ),
            ],
            onSelected: (String value) async {
              if (value == 'settings') {
                await Navigator.pushNamed(context, 'settings');
              } else if (value == 'about') {
                await Navigator.pushNamed(context, 'about');
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        // ignore: discarded_futures
        future: homeViewModel.fetchRadios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.error),
                  const SizedBox(height: 16),
                  const Text('Something went wrong!'),
                  TextButton(
                    onPressed: () async {
                      await homeViewModel.fetchRadios();
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async => homeViewModel.fetchRadios(),
              child: ListView.builder(
                itemCount: homeViewModel.radios.length,
                itemBuilder: (context, index) {
                  final radio = homeViewModel.radios[index];
                  return RadioTile(
                    name: radio.name,
                    url: radio.url,
                    favicon: radio.favicon,
                    tags: radio.tags,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
