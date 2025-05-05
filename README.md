# Two push swap testers updated - 2025

### Scope and Changes

I picked up two popular push swap testers and made a few tweaks on both.

yfu -> Now works on Linux, cleans after itself (make, clean automatically...), minor tweaks, changed ALL memory tests from leaks to Valgrind, just be sure to have valgrind installed!

gemartin -> Files no longer needs to be on root its on a folder, now before being run it: fclean, make, clean (this prevents errors when changing stuff around or having old push_swap programs)


### Usage

To use the testers:

You will need your folder with your .c, .h and Makefile files.


push_tester_GEMARTIN: Copy the tester folder to the folder with all your stuff, go inside the tester folder and run: 

```./push_test.sh```



push_swap_tester_YFU: Copy the tester folder to the folder with all your stuff, go inside the tester folder and run:  

```./basic_test.sh```  -  Parsing test (ERROR_TEST), identity test, and small stack test (size 3 and 5)

```./loop.sh 100 10``` - ./loop.sh <stack size> <loop times>  Choose a size, and the nr of times to run it.




YFU's tester has more features, i DID not test them all, check out his github repo where you have a readme with all the stuff:
https://github.com/LeoFu9487/push_swap_tester
(Beware it's a MacOs version here)

GEMARTIN's tester:
https://github.com/gemartin99/Push-Swap-Tester


