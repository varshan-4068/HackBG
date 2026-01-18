#!/usr/bin/env bash

df --total -h / | tail -1 | awk '{print $3}'


