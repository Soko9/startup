import 'package:flutter/material.dart';

class BBButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final IconData? icon;

  const BBButton({
    super.key,
    required this.label,
    required this.callback,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: callback,
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
          height: 40.0,
          padding: icon == null
              ? const EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 16.0,
                )
              : const EdgeInsets.only(
                  left: 8.0,
                ),
          decoration: BoxDecoration(
            gradient: icon == null
                ? LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            color: icon == null
                ? null
                : Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Stack(
            alignment: icon == null ? Alignment.center : Alignment.centerLeft,
            children: [
              Padding(
                padding: icon == null
                    ? EdgeInsets.zero
                    : const EdgeInsets.only(right: 50.0),
                child: Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
              if (icon != null)
                Positioned(
                  right: 0,
                  child: ClipPath(
                    clipper: ButtonClip(),
                    child: Container(
                      width: 50.0,
                      height: 40.0,
                      alignment: const Alignment(0.5, 0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(4.0),
                        ),
                      ),
                      child: Icon(icon),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width * 0.35, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
