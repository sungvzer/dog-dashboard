import 'package:dog_dashboard/components/breed_dropdown.dart';
import 'package:dog_dashboard/models/view_mode.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ViewMode mode = ViewMode.list;
  String? selectedBreed;
  String? selectedSubBreed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.inversePrimary,
          title: const Text(
            'DoggieDash',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('View mode', style: theme.textTheme.titleMedium),
                      Text(
                        'Choose between single and multiple images',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      setState(() {
                        if (index == 0) {
                          mode = ViewMode.single;
                        } else {
                          mode = ViewMode.list;
                        }
                      });
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
                      mode == ViewMode.single,
                      mode == ViewMode.list
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
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Breed', style: theme.textTheme.titleMedium),
                      Text('The main breed!',
                          style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  MainBreedDropdown(
                    onSelect: (breed) {
                      setState(() {
                        selectedSubBreed = null;
                        selectedBreed = breed;
                      });
                    },
                    value: selectedBreed,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sub-breed',
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  SubBreedDropdown(
                    onSelect: (selectedValue) {
                      setState(() {
                        selectedSubBreed = selectedValue;
                      });
                    },
                    mainBreed: selectedBreed,
                    value: selectedSubBreed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
