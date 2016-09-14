CollectionViewModes is just a side project for Loaf Bottle Stick, exploring making a `UICollectionView` toggle between fullscreen and an "overview" mode.

In fullscreen, the cells, which hold table views, are the size of the screen. In overview, they're distributed by a slightly customized flow layout.

Re-ordering is implemented in the overview mode, and interaction with the table views themselves is disabled in favor of allowing a tap on a cell to bring the user back to fullscreen mode with the tapped cell presented.
