# Godot-GeneralAI
Made to allow anyone to make an evolving simulation in the game engine Godot.

# More specifically
This is a single file AI project that allows you to create evolving creatures with a neural net. Heavily inspired by [davidrandallmiller](https://www.youtube.com/user/davidrandallmiller)'s project, and [The Bibites](https://www.youtube.com/c/TheBibitesDigitalLife). I made this project because there was nothing that fit the requirements for my project. Feel free to use.

# How do I use it?
Simply download "GeneralAI.gd", attach it to a Node, and call the "get_output()" function with an array of floats as input (make sure the size of the input array is the same as the input exported variable). This function returns the networks response to your inputs. Just set up the export variables and your good to go.

# How does it work?
It's very simple if you know how a neural network works. The main difference from your standard network is that the input and output neurons are arbitrary and can be switched on the fly. Other than that, mostly identical to [davidrandallmiller](https://www.youtube.com/user/davidrandallmiller)'s network.

# A word of warning
I am a really bad programmer. This was made over the course of 32 hours on no sleep and only a pack of sour skittles to keep me awake. It's unoptomised, buggy, and liable to cause headache inducing problems because I didn't make a proper visualizer and also didn't comment pretty much anything. If you can stomach all that, then it's pretty easy to use
