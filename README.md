<h1 align="center">✈️ Travel Guide App 🏖</h1>


<p align="center">
  <a href="https://www.apple.com"><img alt="Platform" src="https://img.shields.io/badge/platform-iOS-lightgrey"/></a>
  <a href="https://developer.apple.com/documentation/xcode-release-notes/xcode-13-release-notes"><img alt="Xcode" src="https://img.shields.io/badge/Xcode-13-blue"/></a>
  <a href="https://www.swift.org"><img alt="Swift" src="https://img.shields.io/badge/Swift-5-orange"/></a>
  <a href="https://github.com/ErtasBurak/travel-guide-app-mvvm/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/badge/license-MIT-blueviolet"/></a>
</p>




<p align="center">
A travel guide app that implements <b>MVVM</b> design pattern, using 
  <a href="https://633f7631e44b83bc73bab811.mockapi.io/all_travel_list">mock API</a>.
</p>

![Ekran Resmi 2022-10-11 02 30 44](https://user-images.githubusercontent.com/88059407/194967213-7a98f7d9-1d14-4af1-b6d2-c89f7e9f30e4.png)

## ✨ Features
### 🔸 Project Features
- Written in [Swift](https://www.swift.org)
- Implemented MVVM design pattern
- Consuming a [mock API](https://633f7631e44b83bc73bab811.mockapi.io/all_travel_list)
- API call with [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- Implemented [Core Data](https://developer.apple.com/documentation/coredata)
- Programmatic UI

### 🔹 App Features
- Home Screen shows through various categories and navigates to Flights&Hotels Screen
- Search Flights&Hotels on the *Search* screen
- Detail Screen of Flights&Hotels
  - Can add the detail to Bookmark
  - Learn more about the Flights&Hotels
- Bookmark Screen shows the guide details where we added to database and can delete it


## ▶ Demos



### 🏠 Home Screen



![travelhomescreen](https://user-images.githubusercontent.com/88059407/194955318-243edfdb-fdac-4f29-b6cb-8ac8d21206dd.gif)



### 🔍 Search Screen



![travelsearchscreen](https://user-images.githubusercontent.com/88059407/194955389-abf68688-4592-4708-8792-6c9ca38d7453.gif)



### 📚 Bookmarks Screen




![travelbookmarkscreen](https://user-images.githubusercontent.com/88059407/194955509-eee0e04a-e980-4782-b349-967ad7b25989.gif)




### 📌 Note
This Project is not %100 solid. There are some issues; in search screen, when we empty the searchtext it will not refresh the tableview, collectionview and tableviews can crash when we scroll fast. I'm still learning about iOS development. I will update the project as I learn more and find solutions. I'm also open to any kind of advice to make the project's code quality better.


## 📜 License
```
Copyright (c) 2022 Burak Ertaş

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
