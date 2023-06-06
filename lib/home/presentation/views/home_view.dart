import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base/pagination_scroll_view.dart';
import '../../../core/const/app_strings.dart';
import '../../../core/enums/home_view_enum.dart';
import '../../../core/enums/scroll_view_enum.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/dependency_injection.dart' as di;
import '../../../core/widgets/app_progress.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/icon_button_widget.dart';
import '../../../core/widgets/main_widgets.dart';
import '../../domain/entities/filter_model.dart';
import '../view_model/home_cubit.dart';
import '../widgets/movie_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeCubit _cubit;
  late final FocusNode _focusNode;
  late final TextEditingController _searchController;
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    _cubit = di.serviceLocator<HomeCubit>();
    _focusNode = FocusNode();
    _searchController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: BlocBuilder<HomeCubit, HomeState>(
            bloc: _cubit,
            builder: (BuildContext context, HomeState state) {
              if (state is HomeLoadingState) {
                return const SafeArea(
                  child: AppProgress(),
                );
              } else if (state is HomeErrorState) {
                return const AppErrorWidget();
              } else if (state is HomeLoadedState ||
                  state is MoviesLoadingState) {
                return GestureDetector(
                  onTap: unFocus,
                  child: Scaffold(
                    key: _scaffoldKey,
                    appBar: AppBar(
                      title: Text(
                        AppStrings.movies.tr(),
                      ),
                      actions: [
                        Padding(
                          padding: MediaQuery.of(context).size.width >= 1200
                              ? const EdgeInsets.only(
                                  right: 46,
                                )
                              : EdgeInsets.zero,
                          child: IconButton(
                            tooltip: AppStrings.settings.tr(),
                            icon: const Icon(Icons.settings_outlined),
                            onPressed: () {
                              unFocus();
                              context.push(AppRoutes.settingsRoute);
                            },
                          ),
                        ),
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(70),
                        child: Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _searchController,
                                  focusNode: _focusNode,
                                  hint: AppStrings.search.tr(),
                                  maxLines: 1,
                                  suffix: Offstage(
                                    offstage: _cubit.query.isEmpty,
                                    child: IconButtonWidget(
                                      tooltip: AppStrings.clear.tr(),
                                      icon: Icons.clear,
                                      buttonSize: 42,
                                      onPressed: () {
                                        _searchController.clear();
                                        _cubit.resetSearchFilter();
                                      },
                                    ),
                                  ),
                                  onChanged: (query) =>
                                      _cubit.searchForMovie(query),
                                ),
                              ),
                              Offstage(
                                offstage:
                                    _cubit.viewType != HomeViewEnum.filter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 12,
                                  ),
                                  child: IconButtonWidget(
                                    tooltip: AppStrings.clear.tr(),
                                    icon: Icons.clear,
                                    buttonSize: AppUtils.isMobile() ? 50 : 57,
                                    onPressed: _cubit.resetSearchFilter,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 12,
                                ),
                                child: IconButtonWidget(
                                  tooltip: AppStrings.filter.tr(),
                                  icon: Icons.filter_alt_outlined,
                                  color: _cubit.viewType == HomeViewEnum.filter
                                      ? Theme.of(context).primaryColor
                                      : null,
                                  buttonSize: AppUtils.isMobile() ? 50 : 57,
                                  onPressed: () async {
                                    if (state is HomeLoadedState) {
                                      final FilterModel? filterModel =
                                          MediaQuery.of(context).size.width >=
                                                  1200
                                              ? await showFilterAlertDialog(
                                                  context: _scaffoldKey
                                                          .currentContext ??
                                                      context,
                                                  filter: state.filterModel,
                                                )
                                              : await showFilterBottomSheet(
                                                  context: _scaffoldKey
                                                          .currentContext ??
                                                      context,
                                                  filter: state.filterModel,
                                                );
                                      if (filterModel != null) {
                                        _searchController.clear();
                                        _cubit.applyFilter(
                                          filterModel: filterModel,
                                          apply: true,
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: Container(
                      width: double.infinity,
                      height: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                      ),
                      child: RefreshIndicator(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        onRefresh: () async {
                          _searchController.clear();
                          _cubit.resetSearchFilter();
                        },
                        child: Builder(
                          builder: (context) {
                            if (state is HomeLoadedState) {
                              return _buildMovies(
                                context: context,
                                loadedState: state,
                                unFocus: unFocus,
                              );
                            } else if (state is MoviesLoadingState) {
                              return const AppProgress();
                            } else {
                              return const Offstage();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Offstage();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMovies({
    required BuildContext context,
    required HomeLoadedState loadedState,
    required void Function() unFocus,
  }) {
    return loadedState.movies.isEmpty
        ? AppErrorWidget(
            title: AppStrings.noMovies.tr(),
            backgroundColor: AppColors.transparent,
          )
        : PaginationScrollView(
            scrollController: loadedState.scrollController,
            type: ScrollViewEnum.wrap,
            paginationLoader: loadedState.isLoaded,
            padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 8),
            children: loadedState.movies.map((movie) {
              return MovieItem(
                movie: movie,
                onTap: () {
                  unFocus();
                  context.push(
                    AppRoutes.movieDetailsRoute,
                    extra: movie,
                  );
                },
              );
            }).toList(),
          );
  }

  void unFocus() => _focusNode.unfocus();
}
