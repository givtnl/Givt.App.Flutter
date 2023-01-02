import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/no_connection_bar.dart';
import 'package:givt_mobile_apps/models/local_storage.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/services/persistent_state_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/buttons/generic_button.dart';
import '../../../core/widgets/navigation/appbar_bottom.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../../../services/check_internet_connectivity.dart';
import '../../../services/local_child_service.dart';

class CreateChildPage extends StatefulWidget {
  const CreateChildPage({super.key});

  @override
  State<CreateChildPage> createState() => _CreateChildPageState();
}

class _CreateChildPageState extends State<CreateChildPage> {
  final _nameController = TextEditingController();

  final NavigationService _navigationService = locator<NavigationService>();
  final PersistentStateService _stateService =
      locator<PersistentStateService>();
  final LocalChildUserService _childUserService =
      locator<LocalChildUserService>();

  @override
  void initState() {
    final internetConnectivtyProvider =
        Provider.of<ConnectivityService>(context, listen: false);
    internetConnectivtyProvider.initiateRealtimeConnectionSubscribtion();
    List<ChildUser> childrenList = _childUserService.getAllChildUsers();
    initialization();
    super.initState();
    final PersistentState current = _stateService.getPersistentState();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  void submitName() {
    _childUserService.createChildUser(ChildUser(_nameController.text));
    _stateService.updateCompletedOneFlowFlag(true);
    _navigationService.navigateTo(routes.HomeScreenRoute);
  }

  OutlineInputBorder myFieldBorder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide:
          BorderSide(width: 1, color: Theme.of(context).colorScheme.surface),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<ConnectivityService>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                child!,
                (!provider.hasInternet) ? noConnectionBar() : const SizedBox(),
              ],
            );
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const LogoHeaderTemplate(),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add child account:',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color:
                                        Theme.of(context).colorScheme.surface),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Name or Nickname:',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                            ),
                          ),
                          TextField(
                              autofocus: false,
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context).canvasColor,
                                hintText:
                                    'Joe, Vicky, Rupert, Carla, Billy, Jolene',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                enabledBorder: myFieldBorder(),
                                focusedBorder: myFieldBorder(),
                              ),
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              onSubmitted: (_) {
                                submitName();
                              }),
                          const SizedBox(height: 15),
                          GenericButton(
                            text: 'Create an account',
                            disabled: false,
                            primaryColor: Theme.of(context).colorScheme.surface,
                            textColor: Theme.of(context).backgroundColor,
                            onClicked: () {
                              submitName();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
