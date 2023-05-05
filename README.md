## Crazy Button
Flutter widget to give wiggle animation to the button. 

# Installation

1.  Add the latest version of package to your pubspec.yaml (and run `dart pub get`):
 ```sh
  dependencies:
    crazy_button: ^1.0.1
```
2.  Import the package and use it in your Flutter App.
 ```sh
import 'package:crazy_button/crazy_button.dart';
```
## Preview
> **Example:** Infinite Wiggle.
>
[![N|Solid](https://github.com/Rohit-joshi-i/crazy_button/blob/main/assets/example.gif?raw=true)](https://nodesource.com/products/nsolid)

# Example

```sh
CrazyButton(
                infiniteShake: true,
                child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Icon(
                      Icons.ac_unit,
                    ))),
              )
```

