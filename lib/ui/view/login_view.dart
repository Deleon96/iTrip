import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itrip/ui/widget/common/button_primary.dart';
import 'package:itrip/ui/widget/common/colored_safe_area.dart';
import 'package:itrip/ui/widget/login/header_arc.dart';
import 'package:itrip/use_cases/bloc/login_bloc/login_bloc.dart';
import 'package:itrip/util/colors_app.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            Navigator.of(context).pushReplacementNamed("/home");
          }
        },
        child: ColoredSafeArea(
          color: ColorsApp.primaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderArc(
                  child: Container(
                    color: ColorsApp.primaryColor,
                    height: MediaQuery.sizeOf(context).height / 3,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("asset/images/itrip_logo.png", width: 200),
                        const SizedBox(height: 32),
                        Image.asset("asset/images/beach.png", width: 192),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Form(
                      key: _keyForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bienvenido(a) ingresa tus datos",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _ctrlEmail,
                            autofillHints: [AutofillHints.newUsername],
                            decoration: InputDecoration(
                              // hintText: "Correo Electronico",
                              labelText: "Correo Electronico",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (v) {
                              if (v != null && v.isNotEmpty) {
                                if (RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                                ).hasMatch(v)) {
                                  return null;
                                } else {
                                  return "El correo electronico no es valido";
                                }
                              } else {
                                return "Debes ingresar un correo electronico";
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _ctrlPassword,
                            autofillHints: [AutofillHints.newPassword],
                            decoration: InputDecoration(
                              labelText: "Contraseña",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            validator: (v) {
                              if (v != null && v.isNotEmpty) {
                                if (v.length >= 6) {
                                  return null;
                                  // if (RegExp(
                                  //   r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$",
                                  // ).hasMatch(v)) {
                                  //   return null;
                                  // } else {
                                  //   return "La contraseña debe tener al menos una mayuscula, una minuscula y un numero";
                                  // }
                                } else {
                                  return "La contraseña debe tener al menos 6 caracteres";
                                }
                              } else {
                                return "Debes ingresar tu contraseña";
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: ButtonPrimary(
                              text: 'Iniciar Sesión',
                              onClick: () async {
                                if (_keyForm.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    DoLoginEvent(
                                      email: _ctrlEmail.text,
                                      password: _ctrlPassword.text,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
