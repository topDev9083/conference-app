import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../bloc/event_bloc.dart';
import '../../../bloc/event_code_bloc.dart';
import '../../../bloc/state/event_state.dart';
import '../../../core/configs.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/app_config_data.dart';
import '../../../utils/responsive_utils.dart';
import '../../../widgets/elevated_button.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/text_form_fields.dart';
import '../router/auth_route_bloc.dart';
import '../router/auth_route_config.dart';
import '../widgets/auth_form.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm();

  @override
  Widget build(final BuildContext context) {
    final loginBloc = LoginBloc.of(context);
    return BlocSelector<EventBloc, EventState, AppConfigData?>(
      selector: (final state) => state.getEventApi.data?.appConfig,
      builder: (final _, final appConfig) => BlocBuilder<LoginBloc, LoginState>(
        builder: (final _, final loginState) => AuthForm(
          titleKey: TranslationKeys.Auth_Login_Login,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EmailTextFormField(
                  labelKey: TranslationKeys.Auth_Email,
                  errorKey: loginState.emailError,
                  validator: Validators.compose([
                    Validators.required(
                      translate(
                        context,
                        TranslationKeys.Auth_Error_Email_Required,
                      )!,
                    ),
                    Validators.email(
                      translate(
                        context,
                        TranslationKeys.Auth_Error_Email_Invalid,
                      )!,
                    ),
                  ]),
                  enabled: !loginState.api.isApiInProgress,
                  onChanged: loginBloc.updateEmail,
                  onFieldSubmitted: (final _) => _onLogin(context),
                ),
                const SizedBox(height: 32),
                PasswordTextFormField(
                  labelKey: TranslationKeys.Auth_Login_Password,
                  errorKey: loginState.passwordError,
                  validator: Validators.compose([
                    Validators.required(
                      translate(
                        context,
                        TranslationKeys.Auth_Login_Error_Password_Required,
                      )!,
                    ),
                    Validators.minLength(
                      5,
                      translate(
                        context,
                        TranslationKeys.Auth_Login_Error_Password_Invalid,
                      )!,
                    ),
                  ]),
                  enabled: !loginState.api.isApiInProgress,
                  onChanged: loginBloc.updatePassword,
                  onFieldSubmitted: (final _) => _onLogin(context),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: WCInkWell(
                    padding: const EdgeInsets.all(8),
                    onTap: () => _onForgotPassword(context),
                    child: Text(
                      translate(
                        context,
                        TranslationKeys.Auth_Login_Forgot_Password,
                      )!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                WCElevatedButton(
                  translate(context, TranslationKeys.Auth_Login_Login)!,
                  onTap: () => _onLogin(context),
                  showLoader: loginState.api.isApiInProgress,
                ),
                const SizedBox(height: 23),
                if (!kIsWeb && config.eventCode == null) ...[
                  const SizedBox(height: 13),
                  Align(
                    child: WCInkWell(
                      padding: const EdgeInsets.all(8),
                      onTap: () => _onChangeEventCode(context),
                      child: Text(
                        translate(
                          context,
                          TranslationKeys.Auth_Login_Change_Event_Code,
                        )!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
                if (appConfig?.sponsorLogo != null &&
                    ScreenType.of(context).isMobile) ...[
                  const SizedBox(height: 40),
                  Center(
                    child: WCImage(
                      image: appConfig!.sponsorLogo!,
                      height: 30,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onForgotPassword(final BuildContext context) {
    AuthRouteBloc.of(context).updateRouteConfig(
      const AuthRouteConfig.forgotPassword(),
    );
  }

  void _onChangeEventCode(final BuildContext context) {
    EventCodeBloc.of(context).resetEventCode();
    EventBloc.of(context).resetAccordingToEventCode();
  }

  void _onLogin(final BuildContext context) {
    final bloc = LoginBloc.of(context);
    final form = Form.of(context);

    if (!form.validate()) {
      return;
    }
    form.save();
    bloc.login();
  }
}
