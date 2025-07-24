# ModSecurity Backdoor

## Description

This is a proof-of-concept of malicious software running inside of ModSecurity
WAF.

Software has two main functions:
 * Retrieving content of files.
 * Running commands and retrieving output (remote shell).

Additionaly, it includes these functions:
 * Dynamic setting of control POST arguments names for harder detection.
 * Logging disabling for harder detection (only for attacker's requests
   identified by POST arguments names).
 * All other rules disabling (only for attacker's requests
   identified by POST arguments names).

## Prerequisities

 * ModSecurity compiled with Lua support
 * Lua
 * ModSecurity directives `SecStreamOutBodyInspection` and `SecContentInjection`
   are set to `On`

## Installation

Get files `backdoor.conf` and `backdoor.lua` and load the first one into the
web server.

## Configuration

Configuration can be done in the first rule in file `backdoor.conf`.

### tx.backdoor_file_argument_name

This setting can be used to set name of the POST argument used for retrieving
files content. Set it to anything random like `koomem6Shmog`.

### tx.backdoor_command_argument_name

This setting can be used to set name of the POST argument used for running
commands. Set it to anything random like `tys4Olhuibves`.

## Usage

Commands can be run on any address (domain) on the target server which is behind
the ModSecurity WAF. Output from commands is appended to the standard server
response.

### Usage examples

Retrieving file content:  
`curl -X POST -d "koomem6Shmog=/etc/passwd" "http://example.com/"`

Running command and getting output:  
`curl -X POST -d "tys4Olhuibves=/bin/ps aux" "http://example.com/"`

## License

Copyright (c) 2022 Jozef Sudolsky. All rights reserved.

"THE BEER-WARE LICENSE" (Revision 42):
<jozef@sudolsky.sk> wrote this file.  As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return.   Jozef Sudolsky
