#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.thetacore/thetad.pid file instead
theta_pid=$(<~/.thetacore/testnet3/thetad.pid)
sudo gdb -batch -ex "source debug.gdb" thetad ${theta_pid}
