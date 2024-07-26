import 'package:flutter/material.dart';
import 'package:guessme/preLogin.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final bool showBackButton;

  const CommonAppBar({
    super.key,
    this.backgroundColor = Colors.white,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SizedBox(
        width: 200,
        height: 200,
        child: Image.asset('assets/GuessMe_AppBar_newLogo.png'),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0.0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: showBackButton,
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
