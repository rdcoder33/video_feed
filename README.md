# Video Feed 

I have used a clean and production quality bloc architecture and state management. 
Though http package was enough for this app, I used the Dio package to handle API calls since Dio is something we might wanna use in production due to its better features.
I have used Hive for local storage management for Add Favorite feature since Hive is blazing fast.
I have tried to use re-use most of the UI components and there are no unnecessary builds or API calls in the app.
I have used the latest versions of all the packages and the project is null safe.

Apart from that, I have added few extra features such as Dynamic Dark Mode using BlocBuilder and Live Internet Checker using BlocListner. 

A notable challenge I face was having multiple video player instances in the app which is not possible in flutter currently. Check this for more info: #Flutter Issue 25558.

It took some research and tries to achieve this but I made a solution by making a custom widget on top video_player.  This widget reuses a single instance of the video player and can play infinite videos with just one active instance. This implementation works great and can be used in Production.
The logic I used for auto-play is checking which video is 100% visible on screen and then playing it. (Same approach as Instagram).
Also, since the API didn't contain direct links of thumbnail images I used a basic container in its place.

The UI is pretty basic since that was not the focus of this task. Also, This is an in-development project and it might contain some bugs though I didn't found any yet.
If you have any issues, suggestions, or queries feel free to share. 
 
 
