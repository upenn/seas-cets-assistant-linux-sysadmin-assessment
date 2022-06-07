#!/usr/bin/env python3

# ./python_scripting.py -D -p hello goodbye

import os
import sys
import argparse

parser = argparse.ArgumentParser(description="my generic program")
parser.add_argument("-p",  "--printsomething", type=str, nargs="+", metavar="STRING", help="Something to print")
parser.add_argument("-v",  "--verbosity",      action="count", default=0,             help="Verbosity level")
parser.add_argument("-D",  "--debug",          action="store_true",                   help="Debug")
args = parser.parse_args()

if args.debug:
    args.verbosity=100

def dprint(*myargs, vlevel=0, **kwargs):
    if args.verbosity >= vlevel:
        print(*myargs, **kwargs, file=sys.stderr)
        sys.stderr.flush()

dprint("We are running!", vlevel=0)
dprint("We want to see more!", vlevel=1)

def myadd(num1, num2):
    dprint(f"calling myadd({num1}, {num2})", vlevel=10)
    return num1 + num2

def mycombine(list1, list2):
    dprint(f"calling mycombine({list1}, {list2})", vlevel=10)
    list1.extend(list2)
    return list1

print(myadd(37, 5))

l1 = [x * 2 for x in range(1,4)]
l2 = ["a", "b", "c"]
print(l1)
print(l2)
print(mycombine(l1, l2))
print(l1)
print(l2)

if args.printsomething:
    for something in args.printsomething:
        print(something)
