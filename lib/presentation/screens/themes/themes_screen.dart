import 'package:flutter/material.dart';
import 'package:flutter_proyecto_ft/presentation/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemesScreen extends ConsumerWidget {
  static const String name = 'themes_screen';

  const ThemesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkmode = ref.watch(isDarkmodeProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('ThemesScreen'),
          actions: [
            IconButton(
              icon: Icon(isDarkmode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined), //
              onPressed: () {
                ref.read(isDarkmodeProvider.notifier).update((isDarkmode) => !isDarkmode);
              },
            )
          ],
        ),
        body: _ThemeChangerView());
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, ref) {

    final List<Color> colors = ref.watch( colorListProvider );
    final int selectedColor = ref.watch(selectedColorProvider);



    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final Color color = colors[index];
        
        return RadioListTile(
          title: Text('Este color', style: TextStyle(color: color)),
          subtitle: Text('${color.value}'),
          activeColor: color,
          value: index, 
          groupValue: selectedColor, 
          onChanged: (value) {
            ref.read(selectedColorProvider.notifier).state = index;
          },
        );
      },
    );
  }
}
