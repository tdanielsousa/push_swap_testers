#!/bin/bash
echo "*************************************"
echo "** tdaniel- push_swap_testers_2025 **"
echo "*************************************"
echo "DISCLAIMER: "
echo "These testers were originally made by gemartin and yfu."
echo "I just did some updates on both, also yfu can do more tests, check readme!"
echo "*************************************"
echo "Choose a tester:"
echo " 1 - gemartin's tester - Tests all inputs and errors."
echo " 2 - yfu Basic test - Parsing test, identity test, small stack test."
echo " 3 - yfu 100 size stack test - Sorts 100 numbers, 20 times."
echo " 4 - yfu 500 size stack test - Sorts 500 numbers, 20 times."
echo "Enter your choice (1-4):"
read choice

case $choice in
  1)
    if [ -d "push_tester_GEMARTIN" ]; then
      cd push_tester_GEMARTIN && ./push_test.sh
    else
      echo "Error: failed to find 'push_tester_GEMARTIN' directory."
    fi
    ;;
  2)
    if [ -d "push_swap_tester_YFU" ]; then
      cd push_swap_tester_YFU && ./basic_test.sh
    else
      echo "Error: failed to find 'push_swap_tester_YFU' directory."
    fi
    ;;
  3)
    if [ -d "push_swap_tester_YFU" ]; then
      cd push_swap_tester_YFU && ./loop.sh 100 20
    else
      echo "Error: failed to find 'push_swap_tester_YFU' directory."
    fi
    ;;
  4)
    if [ -d "push_swap_tester_YFU" ]; then
      cd push_swap_tester_YFU && ./loop.sh 500 20
    else
      echo "Error: failed to find 'push_swap_tester_YFU' directory."
    fi
    ;;
  *)
    echo "Invalid choice. Please enter 1, 2, 3, or 4."
    ;;
esac
