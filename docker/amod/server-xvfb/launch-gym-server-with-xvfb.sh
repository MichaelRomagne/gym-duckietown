#!/usr/bin/env bash

_kill_procs() {
  kill -TERM $gym
  wait $gym
#  kill -TERM $xvfb
}

## Setup a trap to catch SIGTERM and relay it to child processes
trap _kill_procs SIGTERM
trap _kill_procs INT

# Start Xvfb
Xvfb :99 -screen 0 1024x768x24 -ac +extension GLX +render -noreset &
xvfb=$!

export DISPLAY=:99

duckietown-start-gym $@ &
gym=$!

wait $gym
wait $xvfb

