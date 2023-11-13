# Me & You - Newton Canteen Menu

Flutter app providing a proper web app experience to read the canteen's menu for the Newton building in Munich.
You can try it out [here](https://cestcedric.github.io/me-and-you/)!

## Architecture

This frontend does **not** access the API used in the original [FG & More App](https://fruehaufgenuss.de/fruehauf-genuss-app/).
Instead it gets data from a Firebase Firestore. This setup causes no additional load on the original API, although it of course also means that the data in the Firestore has to be updated regularly.

## Future Work

This app does pretty much exactly what I want it to do.
However, some ideas could still be implemented:

- Automatically scroll to current day (this one would actually be pretty nice)
  - Maybe using an approach similar to [this one](https://stackoverflow.com/questions/49153087/flutter-scrolling-to-a-widget-in-listview), although I didn't get it to work on the first try
- Filters for allergens, veggie, ...
- Feedback, rate dishes
- Favourites

## Attributions

### Icons

[Spoon icons]("https://www.flaticon.com/free-icons/sppon) created by Freepik - Flaticon
