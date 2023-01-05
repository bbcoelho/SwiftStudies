#  WhatFlower? 🌼

### This app is originaly from The App Brewery iOS Bootcamp at ûdemy with a lot of modifications I did by myself:

* A view programmatically create (ViewCode) instead of using Storyboard
* A new AI model created from Oxford 102 Flowers dataset using CreateML (since I couldn't convert the available Caffe model using CoreML Tools as the lecture suggested)
* And out of curiosity I've added one more class to the model (one more flower it can now recognize) calling it 103 Flowers 😉


## How does it works?

1) Use the camera to get the flower you want to identify
2) The app does the work!

* Uses the AI model to recognize the flower's "specie"
* Makes a query on Wikipedia's API searching for the description and image of the identified flower
* Updetes the UI with the information from Wikipedia


## More datails:

* Framework: UIKit
* iOS Target: +13.0
* Architecture: MVC
* Third Party Libraries: Alamofire (but today I would use URLSession with async/await istead), SwiftyJSON, SDWebImage)
