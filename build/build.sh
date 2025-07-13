#!/bin/bash
set -e
set -u

dmd ../source/server.d -od../tmp -of../bin/server
dmd ../source/client.d -od../tmp -of../bin/client