# ImageGallery
Sample app consuming Flickr API(public feed) to load images on UI.
- User can search images based on the tags.
- Tapping on the image will navigate to the browser with image url.

### Technical approach
- Application follows the principle of clean architecture
- App components are loosely coupled. This enables reusability of the components. This makes writing test cases easier.
- In-Memory caching has been implemented to improve app responsiveness.
- Thread safe array is being used to avoid duplication of network calls for downloading images. This avoids multiple network calls when user scroll through the gallery/collection view.
- Unit test cases has been written 


### Dev Environment-
Xcode v9.4.1
Swift 4.1
