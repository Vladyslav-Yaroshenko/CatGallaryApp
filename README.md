# Cat Gallery App

Cat Gallery App is a mobile application that allows users to browse a collection of cat images. 
The app is designed to provide a visually appealing and user-friendly interface for cat lovers to explore and enjoy beautiful cat pictures.

## Architecture

The CatGalleryApp follows the MVP (Model-View-Presenter) architecture pattern.

## Features

- Browse a Collection of Cat Images: The app downloads a JSON file containing cat data and parses it into an array of `Cat` structs, which have a property `URL`. The app then downloads the images from the provided URLs and displays them to the user.

- View Cat Images: Tapping on an image opens a second view controller displaying a larger image of the cat, allowing users to get a closer look at their favorite feline friends.

- Share Cat Images: The second view controller also includes a button to share the picture. Users can easily share their favorite cat images with friends and family through various sharing options available on their device.

## Technologies Used

- Swift: The app is developed using the Swift programming language, leveraging its power and features to create a seamless user experience.

- UIKit: The user interface of the app is built using UIKit, Apple's framework for building iOS applications.

- URLSession: The app utilizes URLSession for downloading the cat images from the provided URLs.

## Screenshots

![photo_2023-06-26 18 36 00](https://github.com/Vladyslav-Yaroshenko/CatGallaryApp/assets/106316686/4efcd298-18e1-4cc0-b344-9658141527c0)


## Requirements

- iOS 14.0 or later
- Xcode 12.0 or later

## Getting Started

To run the Cat Gallery App on your device or simulator, follow these steps:

1. Clone the repository to your local machine.
   
2. Open the project in Xcode.

3. Build and run the app on the iPhone/Ipad Simulator or a physical device.

