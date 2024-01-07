import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_models/radio_tile_view_model.dart';

class RadioTile extends ConsumerWidget {
  final String name;
  final String url;
  final String favicon;
  final String tags;

  const RadioTile({
    super.key,
    required this.name,
    required this.url,
    required this.favicon,
    required this.tags,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioTileViewModel = ref.watch(radioTileViewModelProvider);

    return ExpansionTile(
      title: ListTile(
        leading: Image.network(
          favicon,
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.radio,
              size: 50,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const CircularProgressIndicator();
            }
            return child;
          },
        ),
        title: Text(name),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () async => radioTileViewModel.play(url),
            ),
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: () async => radioTileViewModel.pause(),
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () async => radioTileViewModel.stop(),
            ),
          ],
        ),
      ],
    );
  }
}
