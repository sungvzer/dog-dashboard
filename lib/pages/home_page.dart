import 'package:dog_dashboard/components/breed_dropdown.dart';
import 'package:dog_dashboard/components/view_mode_selector.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
                  const ViewModeSelector(),
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
                  const MainBreedDropdown()
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
                  const SubBreedDropdown(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
