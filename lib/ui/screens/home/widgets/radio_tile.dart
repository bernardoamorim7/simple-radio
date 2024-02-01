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
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          favicon,
          width: 50,
          height: 50,
          semanticLabel: name,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.radio,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              );
            }
            return child;
          },
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: () async {
        final radioTileViewModel = ref.read(radioTileViewModelProvider);

        showBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          elevation: 0,
          enableDrag: false,
          builder: (context) {
            return Consumer(
              builder: (context, ref, child) {
                final radioTileViewModel =
                    ref.watch(radioTileViewModelProvider);

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          favicon,
                          width: 50,
                          height: 50,
                          semanticLabel: name,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.radio,
                              size: 50,
                              color: Theme.of(context).colorScheme.primary,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress != null) {
                              return CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              );
                            }
                            return child;
                          },
                        ),
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              radioTileViewModel.paused
                                  ? Icons.play_arrow
                                  : Icons.pause,
                              color: Theme.of(context).colorScheme.primary,
                              semanticLabel:
                                  radioTileViewModel.paused ? 'Play' : 'Pause',
                            ),
                            onPressed: () async {
                              if (radioTileViewModel.playing) {
                                await radioTileViewModel.pause();
                              } else {
                                await radioTileViewModel.resume();
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.stop,
                              color: Theme.of(context).colorScheme.primary,
                              semanticLabel: 'Stop',
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                              await radioTileViewModel.stop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );

        if (radioTileViewModel.playing) {
          await radioTileViewModel.stop();
        }
        await radioTileViewModel.play(url);
      },
    );
  }
}
