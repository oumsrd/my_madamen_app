import 'package:flutter/material.dart';
import 'package:app_rim/Consts/colors.dart';
import 'package:app_rim/favourite_screen/widgets/single_favourite_item.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BbPink,
        title: const Text(
          "Favoris",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: appProvider.getFavouriteSalonList.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              itemCount: appProvider.getFavouriteSalonList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleFavouriteItem(
                  singleSalon: appProvider.getFavouriteSalonList[index],
                );
              }),
    );
  }
}
