import 'package:events/globals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchEvents extends StatefulWidget {
  @override
  _SearchEventsState createState() => _SearchEventsState();
}

class _SearchEventsState extends State<SearchEvents> {
  @override
  void initState() {
    eSearchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    eSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColorDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.5),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0,
                      0,
                    ),
                  ),
                ],
              ),
              child: TextFormField(
                controller: eSearchController,
                textDirection: TextDirection.ltr,
                maxLines: 1,
                autofocus: autofocus,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                  suffix: IconButton(
                    icon: Icon(
                      MdiIcons.close,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      eSearchController.clear();
                    },
                  ),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        )
        // showSearch(context: null, delegate: null),
        );
  }
}
