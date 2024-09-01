class NavItemModel {
  final String title;
  final String src;

  NavItemModel({ required this.title, required this.src });
}


List<NavItemModel> bottomNavItems = [
  NavItemModel(title: "Cards", src: 'assets/images/tabs_icons/trading.png'),
  NavItemModel(title: 'Busca', src: 'assets/images/tabs_icons/search.png')
];
