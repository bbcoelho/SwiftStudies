#  WhatFlower? 🌼

### This app is originally from The App Brewery iOS Bootcamp at ûdemy, with some modifications I did by myself:

* A view programmatically created (ViewCode) instead of using Storyboard
* A new AI model created from Oxford 102 Flowers dataset using CreateML (since I couldn't achieve converting the available Caffe model using CoreML Tools as the lecture suggested)
* And out of curiosity I've added one more class to the model (one more flower it can now recognize) calling it now 103 Flowers 😉
* A different (but still simple) design


## How does it works?

1) Use the camera to get the flower you want to identify
2) The app does the work!

* Uses the AI model to recognize the flower's "specie"
* Makes a query on Wikipedia's API searching for the description and image of the identified flower
* Updates the UI with the information and image from Wikipedia


## More datails:

* Framework: UIKit
* iOS Target: +13.0
* Architecture: MVC
* Third Party Libraries: Alamofire (although I'd rather use URLSession with async/await), SwiftyJSON, SDWebImage)
