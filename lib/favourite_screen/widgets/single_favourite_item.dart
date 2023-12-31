import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../../constants/constants.dart';
import '../../models/salon_model/salon_model.dart';
import '../../provider/app_provider.dart';

class SingleFavouriteItem extends StatefulWidget {
  final SalonModel singleSalon;
  const SingleFavouriteItem({super.key, required this.singleSalon});

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(color: Theme.of(context).primaryColor, width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              child: Image.network(
                widget.singleSalon.image[0],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleSalon.name,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                AppProvider appProvider =
                                    Provider.of<AppProvider>(context,
                                        listen: false);
                                appProvider.removeFavouriteSalon(
                                    widget.singleSalon);
                                showMessage("Supprimer");
                              },
                              child: const Text(
                                "Supprimer",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
                           Icon(
      Icons.star,
      size: 20,
      color: Colors.orange,
    ),
    Text(
      "5",
   style: GoogleFonts.arsenal(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.orange)),

    ),
                        ],)
                       
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
