import 'package:dog_dashboard/providers/dog_breed_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum BreedType { main, sub }

class BreedDropdown extends StatelessWidget {
  final void Function(String) onSelect;
  final List<String> values;
  final bool enabled;

  BreedDropdown({
    super.key,
    required this.onSelect,
    required this.values,
    required this.enabled,
    required this.value,
  });

  final String? value;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text('Select Item', style: theme.textTheme.labelMedium),
        items: values
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: theme.textTheme.labelMedium,
                ),
              ),
            )
            .toList(),
        value: value,
        onChanged: (value) {
          if (value == null) return;

          onSelect(value);
        },
        iconStyleData: IconStyleData(
          iconEnabledColor: theme.colorScheme.primary,
        ),

        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: kMinInteractiveDimension,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.inversePrimary,
            ),
          ),
        ),

        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
        ),

        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  gapPadding: 10,
                ),
              ),
              style: theme.textTheme.labelMedium,
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value
                .toString()
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

class MainBreedDropdown extends ConsumerWidget {
  final void Function(String) onSelect;
  final String? value;
  const MainBreedDropdown({
    super.key,
    required this.onSelect,
    this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breeds = ref.watch(breedsProvider);
    final breedsOrEmpty = List<String>.from(
        !breeds.hasValue ? [] : breeds.value!.map((e) => e.name));

    return Skeletonizer(
      enabled: !breeds.hasValue,
      child: BreedDropdown(
        onSelect: onSelect,
        values: breedsOrEmpty,
        enabled: true,
        value: value,
      ),
    );
  }
}

class SubBreedDropdown extends ConsumerWidget {
  final void Function(String) onSelect;
  final String? value;

  final String? mainBreed;
  const SubBreedDropdown({
    super.key,
    required this.onSelect,
    required this.mainBreed,
    this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breeds = ref.watch(breedsProvider);
    List<String> subBreedsOrEmpty = [];
    if (breeds.hasValue && mainBreed != null) {
      final breed = breeds.value!.firstWhere(
        (element) => element.name == mainBreed,
      );

      subBreedsOrEmpty = breed.subBreeds;
    }

    return Skeletonizer(
      enabled: !breeds.hasValue,
      child: BreedDropdown(
        onSelect: onSelect,
        values: subBreedsOrEmpty,
        enabled: subBreedsOrEmpty.isNotEmpty,
        value: value,
      ),
    );
  }
}
