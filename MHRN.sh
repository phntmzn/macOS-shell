#!/bin/bash
sudo ngrep -d any -q -W byline "GET|POST" port 80
