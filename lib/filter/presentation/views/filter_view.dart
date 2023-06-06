import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/utils/dependency_injection.dart' as di;
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_progress.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/main_widgets.dart';
import '../../../home/domain/entities/filter_model.dart';
import '../../../home/domain/entities/genre.dart';
import '../view_model/filter_cubit.dart';
import '../widgets/filter_title_item.dart';
import '../widgets/genre_item.dart';

class FilterView extends StatelessWidget {
  final FilterModel? filter;

  FilterView({
    Key? key,
    required this.filter,
  }) : super(key: key);

  final FilterCubit _filterCubit = di.serviceLocator<FilterCubit>();
  final FocusNode _yearFN = FocusNode();
  final TextEditingController _yearTC = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      bloc: _filterCubit..init(filter),
      builder: (BuildContext context, FilterState state) {
        return GestureDetector(
          onTap: unFocus,
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(AppStrings.filter.tr()),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(
                  thickness: 1,
                  height: 1,
                  indent: 0,
                  color: AppColors.grey.withOpacity(0.4),
                ),
              ),
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              actions: [
                Padding(
                  padding: MediaQuery.of(context).size.width >= 540
                      ? const EdgeInsets.only(
                          right: 8,
                        )
                      : EdgeInsets.zero,
                  child: IconButton(
                    tooltip: AppStrings.close.tr(),
                    icon: const Icon(Icons.clear),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (BuildContext context) {
                  if (state is FilterLoadingState) {
                    return const AppProgress();
                  } else if (state is FilterErrorState) {
                    return const AppErrorWidget();
                  } else if (state is FilterLoadedState) {
                    _yearTC.text = state.year;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 22,
                          right: 22,
                          top: 22,
                          bottom: 80,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FilterTitleItem(
                              title: AppStrings.year,
                            ),
                            SizedBox(
                              width: 120,
                              child: AppTextField(
                                maxLines: 1,
                                controller: _yearTC,
                                focusNode: _yearFN,
                                hint: AppStrings.enterYear.tr(),
                                keyboardType: TextInputType.number,
                                backgroundColor: Theme.of(context)
                                    .snackBarTheme
                                    .backgroundColor,
                                onChanged: (v) => _filterCubit.year = v,
                                padding: const EdgeInsets.only(
                                  top: 6,
                                  bottom: 26,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'),
                                  ),
                                ],
                              ),
                            ),
                            const FilterTitleItem(
                              title: AppStrings.genres,
                            ),
                            Wrap(
                              children: state.genres.map((genre) {
                                return GenreItem(
                                  value: _checkGenre(
                                    genre: genre,
                                    selected: state.selectedGenres,
                                  ),
                                  title: genre.name,
                                  onChanged: (value) => _filterCubit.setGenre(
                                    value: value ?? false,
                                    genre: genre,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Offstage();
                  }
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Offstage(
              offstage: _filterCubit.selectedGenres.isEmpty,
              child: AppButton(
                title: AppStrings.apply.tr().toUpperCase(),
                onTap: () {
                  final bool res = _filterCubit.applyFilter(_yearTC.text);
                  if (res) {
                    Navigator.pop(context, _filterCubit.filter);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  bool _checkGenre({
    required Genre genre,
    required List<Genre> selected,
  }) {
    Iterable<Genre> res = selected.where((e) => e.id == genre.id);
    return res.isNotEmpty;
  }

  void unFocus() => _yearFN.unfocus();
}
