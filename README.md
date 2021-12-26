![foursquare-places](https://user-images.githubusercontent.com/11244927/147422392-b5ebd37d-23e0-4853-af16-3f60c03c1fcd.png)

[![CI](https://github.com/alielsokary/FoursquarePlaces/actions/workflows/CI.yml/badge.svg)](https://github.com/alielsokary/FoursquarePlaces/actions/workflows/CI.yml)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/4ac37543a9f244c081f4468325cf72ac)](https://app.codacy.com/gh/alielsokary/FoursquarePlaces?utm_source=github.com&utm_medium=referral&utm_content=alielsokary/FoursquarePlaces&utm_campaign=Badge_Grade_Settings)

## Project Structure

```
.
├── FoursquarePlces
│   │   ├── App             # cotnains `AppDelegate` and `SceneDelegate`
│   │   ├── Models   
│   │   ├── Scenes          # contains all app Scenes
│   │   │   └── ${Module}   # contains concrete module, its structure is described in Layered architecture 
│   │   ├──  Services       # contains network and  storage services 
│   │   ├── Library         # contains Helper/Extensions files
│   │   │   └── Extension 
│   │   ├── Supporting files       # contains network and  storage services 
│   │   ├──  Unit-Tests     
└── 
```

## Architecture description
### Design Pattern
The app designed with the **MVVM** pattern.

### Modular development
Application is separated into small units with similar functionality that can be developed independently.
### Layered architecture

Each module is divided by layers:

```
├── Service
├── ViewModel
├── View
│   ├── Cell
│   └── Layout
```

### Notes
- After 11/18/21 foursquare V2 API was deprecated. So Places API V3 used to get nearby places.
- In order to see nearby venues please use a real device or mock the location on simulator.
