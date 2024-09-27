import 'package:flutter/material.dart';
import 'package:news_app/core/common/providers/auth/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthStatusProvider>().user;
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(child: Text(user!.email)),
            const Spacer(),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              tileColor: Colors.black,
              trailing: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title:  Text(
                'Logout',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
              onTap: () {
                context.read<AuthStatusProvider>().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
