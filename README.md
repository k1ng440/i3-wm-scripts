# A Collection of i3 Window Manager scripts

This repository contains a collection of Bash scripts for enhancing and customizing your i3 Window Manager experience.
These scripts are designed to automate common tasks and add additional functionality to your i3 setup.
Feel free to use and customize them to match your specific needs and preferences.

## Table of Contents
1. [Scripts](#scripts)
   - [i3lock](#i3lock)

## Scripts
### i3lock
A simple script designed for multi-monitor setups in the i3 window manager. It takes a screenshot of your desktop and
applies a transparent image on every monitor to create a custom lock screen. This script provides the flexibility to
use either a single image file or a directory containing multiple images to be applied to your monitors.

#### Usages
`i3lock.sh /path/to/your/image.png` or `i3lock.sh /path/to/your/direcotry`

#### Image Position
| Filename Pattern    | Position on Monitor                                  |
| --------------------| --------------------------------------------         |
| *.center.png        | Centered on the monitor                              |
| *.bottom.png        | Positioned at the bottom of the monitor              |
| *.right.png         | Positioned on the right side of the monitor          |
| *.left.png          | Positioned on the left side of the monitor           |
| *.bottom-right.png  | Positioned at the bottom-right corner of the monitor |
| *.bottom-left.png   | Positioned at the bottom-left corner of the monitor  |
| *.top-right.png     | Positioned at the top-right corner of the monitor    |
| *.top-left.png      | Positioned at the top-left corner of the monitor     |

## Contributing
We welcome contributions to this collection of scripts. If you have improvements, bug fixes, or additional scripts that
you'd like to add, please feel free to fork this repository, make your changes, and submit a pull request.
Your contributions are highly appreciated!

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
