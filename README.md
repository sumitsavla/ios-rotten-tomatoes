iOS App - Rotten Tomatoes 
=========================

This is an iOS application for displaying the latest box office movies, upcoming movies and new arrivals using the [RottenTomatoes API](http://www.rottentomatoes.com/).

Time spent: 16 hours spent in total

Completed user stories:

 * [x] Required: User can view a list of movies from Rotten Tomatoes.  
 * [x] Required: User can click on a movie in the list to bring up a details page with additional information such as synopsis
 * [x] Required: Poster images must be loading asynchronously.
 * [x] Required: User can view movie details by tapping on a cell
 * [x] Required: User sees loading state while waiting for movies API.
 * [x] Required: User sees error message when there's a networking error.
 * [x] Required: User can pull to refresh the movie list.
 * [x] Optional: Customize the navigation bar
 * [x] Optional: Added navigation bar button for "New Arrivals"
 * [x] Optional: Customize the highlight and selection effect of the cell.
 * [ ] Optional: Add a search bar 
 
 
Notes:

1. Spent some time on trying to use poster images as a background for table view row and show movie info on poster.
But as posters also have text, movie info was not very readable. Hence switched to normal poster.
2. Tried implementing tab bar control but it was tricky as using one MovieListVC to show all 3 movie lists. 
3. Created two instance of same vc for 2 tabs, but only second tab was showing data and first tab view was empty

Libraries used:
1. cocoapod
2. AFNetworking
3. MBProgressHUD
4. DejalActivityView 

Walkthrough of all user stories:

![Video Walkthrough](https://raw.githubusercontent.com/sumitsavla/ios-rotten-tomatoes/master/RottenTomatoes/anim_rotten_tomatoes.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).


