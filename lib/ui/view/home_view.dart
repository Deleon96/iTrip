import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itrip/data/db/db_helper.dart';
import 'package:itrip/data/db/table/trip_dao.dart';
import 'package:itrip/data/model/trip.dart';
import 'package:itrip/ui/view/start_trip_view.dart';
import 'package:itrip/ui/widget/common/app_bar_primary.dart';
import 'package:itrip/ui/widget/common/button_primary.dart';
import 'package:itrip/use_cases/singleton/session_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      List<Trip> list = await TripDao.getAll(await DbHelper.getDb());
      print(list.map((t) => t.toJson()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPrimary(context: context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "¡Hola ${SessionManager.getInstance().getName()}! 👋",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100.0),
                      child: Image.network(
                        SessionManager.getInstance().getPhotoUrl() ?? "",
                        width: 64,
                        height: 64,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 8,
                    bottom: 32.0,
                  ),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ButtonPrimary(
                      onClick: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const StartTripView(),
                          ),
                        );
                      },
                      text: "Iniciar Paseo",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
