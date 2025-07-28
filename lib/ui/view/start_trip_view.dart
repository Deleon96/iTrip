import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itrip/ui/widget/common/app_bar_primary.dart';
import 'package:itrip/ui/widget/common/button_primary.dart';
import 'package:itrip/ui/widget/common/text_field_primary.dart';

class StartTripView extends StatefulWidget {
  const StartTripView({super.key});

  @override
  State<StartTripView> createState() => _StartTripViewState();
}

class _StartTripViewState extends State<StartTripView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPrimary(context: context, showBack: true),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  "Iniciar Paseo 🏖️",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  "Información Basica",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFieldPrimary(labelText: "Nombre de la aventura"),
                const SizedBox(height: 16),
                TextFieldPrimary(
                  labelText: "Descripcion de tu recorrido",
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                Text(
                  "¿Como es tu paseo en ésta ocasion?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
