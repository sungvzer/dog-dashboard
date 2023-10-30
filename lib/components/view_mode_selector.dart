import 'package:dog_dashboard/models/view_mode.dart';
import 'package:dog_dashboard/providers/dogs/breeds_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewModeSelector extends ConsumerWidget {
  const ViewModeSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final ThemeData theme = Theme.of(context);
    final FetchImageData fetchImageData = ref.watch(fetchImageDataProvider);

    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        ref.read(fetchImageDataProvider.notifier).state = FetchImageData(
          breed: fetchImageData.breed,
          subBreed: fetchImageData.subBreed,
          viewMode: index == 0 ? ViewMode.single : ViewMode.list,
        );
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: theme.colorScheme.primary,
      selectedColor: theme.colorScheme.background,
      borderColor: theme.colorScheme.inversePrimary,
      fillColor: theme.colorScheme.primary,
      constraints: const BoxConstraints.tightFor(
        height: kMinInteractiveDimension,
        width: 60,
      ),
      color: theme.colorScheme.inversePrimary,
      isSelected: [
        fetchImageData.viewMode == ViewMode.single,
        fetchImageData.viewMode == ViewMode.list
      ],
      children: const <Widget>[
        Tooltip(
          message: 'Show a single random image',
          child: Icon(
            Icons.image_rounded,
          ),
        ),
        Tooltip(
          message: 'Show a list of images',
          child: Icon(
            Icons.list_rounded,
          ),
        ),
      ],
    );
  }
}
