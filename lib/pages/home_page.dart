import 'package:dog_dashboard/components/breed_dropdown.dart';
import 'package:dog_dashboard/components/image_viewer.dart';
import 'package:dog_dashboard/components/view_mode_selector.dart';
import 'package:dog_dashboard/models/view_mode.dart';
import 'package:dog_dashboard/providers/dogs/breeds_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final imageProvider = ref.watch(fetchImageDataProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.inversePrimary,
          title: const Text(
            'DoggieDash',
          ),
        ),
        floatingActionButton: imageProvider.viewMode == ViewMode.single
            ? FloatingActionButton(
                onPressed: () {
                  ref.read(fetchImageDataProvider.notifier).state =
                      FetchImageData(
                    breed: imageProvider.breed,
                    subBreed: imageProvider.subBreed,
                    viewMode: imageProvider.viewMode,
                  );
                },
                backgroundColor: theme.colorScheme.primary,
                child: const Icon(Icons.refresh_rounded, color: Colors.white),
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('View mode', style: theme.textTheme.titleMedium),
                          Text(
                            'Choose between single and multiple images!',
                            style: theme.textTheme.bodyMedium,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const ViewModeSelector(),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Breed', style: theme.textTheme.titleMedium),
                          Text(
                            'The main breed!',
                            style: theme.textTheme.bodyMedium,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const MainBreedDropdown()
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sub-breed', style: theme.textTheme.titleMedium),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const SubBreedDropdown(),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              const DogImageViewer(),
            ],
          ),
        ),
      ),
    );
  }
}
