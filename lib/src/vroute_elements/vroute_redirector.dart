import 'package:vrouter/src/vroute_elements/vpath.dart';
import 'package:vrouter/src/vroute_elements/vroute_element_builder.dart';
import 'package:vrouter/src/vrouter_core.dart';

/// Use this route to redirect from [path] to [redirectTo]
///
/// Note that this uses [pushReplacement] so if you are on the web, [path] will not
/// appear in the web history once redirected
class VRouteRedirector extends VRouteElementBuilder {
  /// The path that should be matched
  final String path;

  /// The path where the user will be redirected
  final String redirectTo;

  VRouteRedirector({
    required this.path,
    required this.redirectTo,
  });

  @override
  Future<void> beforeEnter(VRedirector vRedirector) async =>
      vRedirector.to(redirectTo, isReplacement: true);

  @override
  List<VRouteElement> buildRoutes() => [
        VPath(path: path, stackedRoutes: [_VRouteElementNode()]),
      ];
}

/// An empty node which is valid if the parent is valid
///
///
/// This is needed because VPath asks its children if they
/// are ok with being part of the route and at least one has
/// to say ok for it to be a valid route
class _VRouteElementNode extends VRouteElementBuilder {
  @override
  List<VRouteElement> buildRoutes() => [];

  @override
  bool get mustHaveSubRoutes => false;
}
