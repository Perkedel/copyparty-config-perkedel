# Hooks & Parsers

## How to read Hooks triggers:

Hooks happens according to when something happen

- `xbu` executes CMD before a file upload starts
- `xau` executes CMD after  a file upload finishes
- `xiu` executes CMD after  all uploads finish and volume is idle
- `xbc` executes CMD before a file copy
- `xac` executes CMD after  a file copy
- `xbr` executes CMD before a file rename/move
- `xar` executes CMD after  a file rename/move
- `xbd` executes CMD before a file delete
- `xad` executes CMD after  a file delete
- `xm` executes CMD on message
- `xban` executes CMD if someone gets banned

## Raw docs

`copyparty-sfx.py --help-hooks`

```
# hooks help page (execute commands before/after various events)

execute a command (a program or script) before or after various events;
 xbu executes CMD before a file upload starts
 xau executes CMD after  a file upload finishes
 xiu executes CMD after  all uploads finish and volume is idle
 xbc executes CMD before a file copy
 xac executes CMD after  a file copy
 xbr executes CMD before a file rename/move
 xar executes CMD after  a file rename/move
 xbd executes CMD before a file delete
 xad executes CMD after  a file delete
 xm executes CMD on message
 xban executes CMD if someone gets banned

can be defined as --args or volflags; for example
 --xau foo.py
 -v .::r:c,xau=bar.py

hooks specified as commandline --args are appended to volflags;
each commandline --arg and volflag can be specified multiple times,
each hook will execute in order unless one returns non-zero

optionally prefix the command with comma-sep. flags similar to -mtp:

 f forks the process, doesn't wait for completion
 c checks return code, blocks the action if non-zero
 j provides json with info as 1st arg instead of filepath
 wN waits N sec after command has been started before continuing
 tN sets an N sec timeout before the command is abandoned
 iN xiu only: volume must be idle for N sec (default = 5)

 ar only run hook if user has read-access
 arw only run hook if user has read-write-access
 arwmd ...and so on... (doesn't work for xiu or xban)

 kt kills the entire process tree on timeout (default),
 km kills just the main process
 kn lets it continue running until copyparty is terminated

 c0 show all process output (default)
 c1 show only stderr
 c2 show only stdout
 c3 mute all process otput

examples:

 --xm some.py runs some.py msgtxt on each 📟 message;
  msgtxt is the message that was written into the web-ui

 --xm j,some.py runs some.py jsontext on each 📟 message;
  jsontext is the message info (ip, user, ..., msg-text)

 --xm aw,j,some.py requires user to have write-access

 --xm aw,,notify-send,hey,-- shows an OS alert on linux;
  the ,, stops copyparty from reading the rest as flags and
  the -- stops notify-send from reading the message as args
  and the alert will be "hey" followed by the messagetext

 --xau zmq:pub:tcp://*:5556 announces uploads on zeromq;
 --xau t3,zmq:push:tcp://*:5557 also works, and you can
 --xau t3,j,zmq:req:tcp://localhost:5555 too for example

each hook is executed once for each event, except for xiu
which builds up a backlog of uploads, running the hook just once
as soon as the volume has been idle for iN seconds (5 by default)

xiu is also unique in that it will pass the metadata to the
executed program on STDIN instead of as argv arguments, and
it also includes the wark (file-id/hash) as a json property

xban can be used to overrule / cancel a user ban event;
if the program returns 0 (true/OK) then the ban will NOT happen

effects can be used to redirect uploads into other
locations, and to delete or index other files based
on new uploads, but with certain limitations. See
bin/hooks/reloc* and docs/devnotes.md#hook-effects

except for xm, only one hook / one action can run at a time,
so it's recommended to use the f flag unless you really need
to wait for the hook to finish before continuing (without f
the upload speed can easily drop to 10% for small files)
```

## Sauces

- https://github.com/9001/copyparty/blob/hovudstraum/bin/mtag/README.md
- https://github.com/9001/copyparty/blob/hovudstraum/bin/hooks