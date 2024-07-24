import 'package:flutter/material.dart';
import 'package:me_and_you/utils/alert.dart';
import 'package:me_and_you/state/app_state.dart';
import 'package:me_and_you/utils/index.dart';
import 'package:me_and_you/widgets/daily_menu.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  static const appBarHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    // styles
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final titleStyle =
        theme.textTheme.displaySmall!.copyWith(color: colorScheme.primary);

    var screenWidth = MediaQuery.of(context).size.width;

    // data
    var appState = context.watch<AppState>();

    var validFrom = appState.validFrom;
    var validTo = appState.validTo;
    var validityPeriod = validTo.difference(validFrom).inDays + 1;
    var location = appState.location;
    var menu = appState.menu;
    var initialized = appState.initialized;

    if (!appState.alertDisplayed) {
      appState.alertDisplayed = true;
      Future.delayed(Duration.zero, () => showAlertDialog(context));
    }

    return Container(
      color: colorScheme.background,
      child: SafeArea(
          child: initialized
              ? CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: ScrollController(
                    initialScrollOffset: scrollToToday(
                      validFrom,
                      validityPeriod,
                      screenWidth,
                      menu,
                    ),
                  ),
                  slivers: [
                    SliverAppBar(
                      pinned: false,
                      stretch: true,
                      collapsedHeight: appBarHeight,
                      expandedHeight: appBarHeight,
                      toolbarHeight: appBarHeight,
                      onStretchTrigger: appState.update,
                      title: Center(child: Text(location, style: titleStyle)),
                      backgroundColor: colorScheme.background,
                      surfaceTintColor: colorScheme.primary,
                      flexibleSpace: FlexibleSpaceBar(
                        background: DecoratedBox(
                          position: DecorationPosition.foreground,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: colorScheme.outlineVariant,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var date = validFrom.add(Duration(days: index));

                          return Center(
                            child: DailyMenu(
                              date: date,
                              dishes: menu[dateToDashedString(date)] ?? [],
                            ),
                          );
                        },
                        childCount: validityPeriod,
                      ),
                    ),
                  ],
                )
              : Column(children: [LinearProgressIndicator()])),
    );
  }
}
