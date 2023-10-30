import 'package:dog_dashboard/models/view_mode.dart';
import 'package:dog_dashboard/providers/dogs/breeds_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DogImageViewer extends ConsumerWidget {
  const DogImageViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchImageDate = ref.watch(fetchImageDataProvider);
    return fetchImageDate.viewMode == ViewMode.list
        ? const MultipleDogImages()
        : const SliverFillRemaining(
            hasScrollBody: false,
            child: SingleDogImage(),
          );
  }
}

class MultipleDogImages extends ConsumerWidget {
  const MultipleDogImages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    const crossAxisCount = 3;
    final imageProvider = ref.watch(randomBreedImageProvider);

    if (imageProvider.hasValue && imageProvider.value == null) {
      return SliverFillRemaining(child: Container());
    }
    return Skeletonizer.sliver(
      enabled: imageProvider.isLoading,
      child: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: imageProvider.value?.length ?? 0,
          (context, index) {
            if (imageProvider.isLoading) {
              return const Padding(
                padding: EdgeInsets.all(4.0),
                child: Skeleton.unite(
                  child: Placeholder(),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                imageProvider.value![index],
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_rounded,
                        size: 50,
                        color: theme.colorScheme.inversePrimary,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Failed to load image.\nThis is probably not your fault.',
                        style: theme.textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class SingleDogImage extends ConsumerWidget {
  const SingleDogImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageProvider = ref.watch(randomBreedImageProvider);

    if (imageProvider.hasValue && imageProvider.value == null) {
      return Container();
    }

    String url = '';

    final isSuccess = imageProvider.hasValue &&
        !imageProvider.isLoading &&
        !imageProvider.hasError &&
        imageProvider.value != null;

    if (isSuccess) {
      url = imageProvider.value!.first;
    }

    final theme = Theme.of(context);

    return Skeletonizer(
      enabled: !isSuccess,
      child: Skeleton.unite(
        child: isSuccess
            ? Image.network(
                url,
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_rounded,
                        size: 50,
                        color: theme.colorScheme.inversePrimary,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Failed to load image.\nThis is probably not your fault.',
                        style: theme.textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              )
            : const Placeholder(),
      ),
    );
  }
}
