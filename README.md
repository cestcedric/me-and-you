# Me & You - Newton Canteen Menu

Flutter app providing a proper web app experience to read the canteen's menu for the Newton building in Munich.
You can try it out [here](https://cestcedric.github.io/me-and-you/)!

## Architecture

The raw data used in the original [FG & More App](https://fruehaufgenuss.de/fruehauf-genuss-app/) is coming from a password protected API. While the endpoints, user name and password are all hardcoded in the app and easy to find, this project is using a custom backend to avoid leaking any info even harder.
The implementation can be found in this second, private, [repository](https://github.com/cestcedric/newton-canteen-relay) (obviously I'm going build a proxy backend just to then leak the password there).

![Proxy setup](/docs/me-and-you.png 'Proxy setup.')

## Future Work

This app does pretty much exactly what I want it to do.
However, some ideas could still be implemented:

- Automatically scroll to current day (this one would actually be pretty nice)
  - Maybe using an approach similar to [this one](https://stackoverflow.com/questions/49153087/flutter-scrolling-to-a-widget-in-listview), although I didn't get it to work on the first try
- Update indicator
  - Combination of early notification from state and SliverAppBar with `stretch: true` crashes
- Filters for allergens, veggie, ...
- Feedback, rate dishes
- Favourites

## Attributions

### Icons

[Spoon icons]("https://www.flaticon.com/free-icons/sppon) created by Freepik - Flaticon
