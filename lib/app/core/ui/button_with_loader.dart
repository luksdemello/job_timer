import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<T extends StateStreamable<S>, S>
    extends StatelessWidget {
  final BlocWidgetSelector<S, bool> selector;
  final T bloc;
  final VoidCallback onPressed;
  final String label;

  const ButtonWithLoader({
    super.key,
    required this.onPressed,
    required this.label,
    required this.selector,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: BlocSelector<T, S, bool>(
        bloc: bloc,
        selector: selector,
        builder: (context, showLoading) {
          if (!showLoading) {
            return Text(label);
          }
          return Stack(
            alignment: Alignment.center,
            children: [
              Text(label),
              const Align(
                alignment: Alignment.centerRight,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
