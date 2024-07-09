import 'package:book_catalog/core/extensions/context_extensions.dart';
import 'package:book_catalog/features/home/presentation/bloc/home_bloc.dart';
import 'package:book_catalog/features/home/presentation/widgets/update_book_dialog.dart';
import 'package:book_catalog/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/services/shared_preferences_service.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.index});
  final int index;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _oneKey = GlobalKey();
  final _secondKey = GlobalKey();

  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(ShowBookEvent(index: widget.index));
    WidgetsBinding.instance.addPostFrameCallback((s) {
      if (SharedPreferencesService.getShowCase() == null) {
        ShowCaseWidget.of(context).startShowCase([_oneKey, _secondKey]);
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        centerTitle: true,
        title: Text(
          'booky',
          style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        actions: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return state.book == null
                  ? const SizedBox()
                  : Showcase(
                      key: _oneKey,
                      description: LocaleKeys.detailsScreen_show1case.tr(),
                      disableBarrierInteraction: true,
                      child: InkWell(
                        onTap: () {
                          showAdaptiveDialog(
                            context: context,
                            builder: (context) =>
                                UpdateBookDialog(book: state.book!),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.edit,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    );
            },
          )
        ],
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.png',
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return state.book != null
                  ? Column(
                      children: [
                        120.verticalSpace,
                        SizedBox(
                          width: .4.sw,
                          height: .25.sh,
                          child: Card(
                            elevation: 8,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: state.book!.image != null
                                ? Image.memory(
                                    state.book!.image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/placeholder.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          state.book!.title,
                          style: context.textTheme.titleLarge,
                        ),
                        10.verticalSpace,
                        Text(
                          state.book!.author,
                          style: context.textTheme.titleSmall,
                        ),
                        10.verticalSpace,
                        Text(
                          DateFormat('yyyy - MM - dd')
                              .format(state.book!.publication),
                          style: context.textTheme.titleMedium,
                        ),
                        25.verticalSpace,
                        Showcase(
                          key: _secondKey,
                          description: LocaleKeys.detailsScreen_show2case.tr(),
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<HomeBloc>()
                                  .add(ToggleFavorite(index: widget.index));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: context.primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  state.book!.favored
                                      ? LocaleKeys
                                          .detailsScreen_removeFromFavorite
                                          .tr()
                                      : LocaleKeys.detailsScreen_addToFavorite
                                          .tr(),
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                          ),
                        ),
                        25.verticalSpace,
                        Text(
                          state.book!.description,
                          textAlign: TextAlign.justify,
                        )
                      ],
                    )
                  : const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
