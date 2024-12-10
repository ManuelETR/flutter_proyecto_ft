import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo({required this.title, required this.caption, required this.imageUrl});
}

final slides = <SlideInfo>[
  SlideInfo(
    title: 'Misión',
    caption:
        'Ofrecer soluciones integrales y de alta calidad en instalación y mantenimiento de aires acondicionados, garantizando el confort y la satisfacción de nuestros clientes mediante un servicio personalizado, eficiente y comprometido, respaldado por los valores de confianza y profesionalismo que caracterizan a nuestra empresa familiar.',
    imageUrl: 'assets/FTM/1.jpg',
  ),
  SlideInfo(
    title: 'Visión',
    caption:
        'Ser reconocidos como la empresa líder en servicios de instalación y mantenimiento de aires acondicionados en La Paz, B.C., destacándonos por nuestra excelencia, innovación y compromiso con el bienestar de nuestros clientes y el desarrollo sostenible de nuestra comunidad.',
    imageUrl: 'assets/FTM/2.jpg',
  ),
  SlideInfo(
  title: 'Valores',
  caption:
      'Compromiso: Cumplimos con altos estándares de calidad y responsabilidad. \n\nProfesionalismo: Actuamos con ética y atención a los detalles. \n\nInnovación: Brindamos soluciones modernas y eficientes para la comodidad de nuestros clientes.',
  imageUrl: 'assets/FTM/3.jpg',
),
];

class MissionScreen extends StatefulWidget {
  static const name = 'mission_screen';

  const MissionScreen({super.key});

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  final PageController pageviewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    pageviewController.addListener(() {
      final page = pageviewController.page ?? 0;
      if (!endReached && page >= (slides.length - 1.54)) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageviewController,
            physics: const BouncingScrollPhysics(),
            children: slides
                .map(
                  (slideData) => _Slide(
                    title: slideData.title,
                    caption: slideData.caption,
                    imageUrl: slideData.imageUrl,
                  ),
                )
                .toList(),
          ),
          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              child: const Text('Salir'),
              onPressed: () => context.pop(),
            ),
          ),
          endReached
              ? Positioned(
                  right: 30,
                  bottom: 30,
                  child: FadeInRight(
                    from: 15,
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                      child: const Text('Comenzar'),
                      onPressed: () => context.pop(),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({super.key, required this.title, required this.caption, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: Image.asset(
                imageUrl,
                key: ValueKey(imageUrl), // Clave única para animación
                height: 300,
                width: 500,
                fit: BoxFit.cover,
              ),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
            const SizedBox(height: 20),
            Text(title, style: titleStyle),
            const SizedBox(height: 10),
            Text(caption, style: captionStyle),
          ],
        ),
      ),
    );
  }
}
