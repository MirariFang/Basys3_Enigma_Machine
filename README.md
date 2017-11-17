# Enigma machine on Basys3

**Note:**
This is only a naive simulation and it is **not** the most efficient way to simulate the behavior of an enigma machine. We made this only for fun (not really, it's a final project for a computer architecture class). 

More information about an enigma machine: https://en.wikipedia.org/wiki/Enigma_machine

**What it can do**

1. It can receive inputs from the keyboard using the USB HID port on Basys3 and display outputs on 4-digit 7-segment display as 01-26 (a-z). 
2. User can define the initial states of the rotors.

**What it cannot do**

1. It cannot simulate a plugboard.
2. It cannot simulate the different sequence of rotors (i.e., the sequence of the rotors is fixed).
