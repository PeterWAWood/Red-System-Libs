#!/usr/bin/rebol -qs

REBOL [ 
  Purpose:    "Builds and runs Red/System Library tests"
  Author:     "Peter W A Wood"
  Version:     0.0.1
  Rights:      Copyright © 2011 Peter W A Wood. All rights reserved.
  License:     BSD-3 - https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt

  Notes:       "Requires the file path-to-red-system.txt to be in the same directory."
]

;; windows ?
  windows-os?: system/version/4 = 3
  
  ;; use Cheyenne call with REBOL v2.7.8 on Windows (re: 'call bug on Windows 7)
  if all [
    windows-os?
    system/version/3 = 8              
  ][
		do %call.r					               
		set 'call :win-call
	]

;; extract the program name from the source file and
;; work out where everything is
source-file: to file! system/script/args
pgm-name: second split-path source-file
either windows-os? [
  base-dir: system/script/path ;; this script can only be run from the same
                               ;;  directory as the script under Windows
][
  base-dir: system/options/path
]
red-system-libs-dir: system/script/path
runnable-dir: red-system-libs-dir/Runnable
compiler-dir: to file! read %path-to-red-system.txt
builds-dir: compiler-dir/builds

;; make runnable directory if needed
make-dir runnable-dir

;; set temporary files names
comp-echo: runnable-dir/comp-echo.txt
comp-r: runnable-dir/comp.r

;; declarations
output: copy ""

;; compile the test program
  ;; workout executable name
exe: copy/part pgm-name find pgm-name ".r"
if windows-os? [
  exe: join exe [".exe"]
]
  ;; compose and write compilation script
comp: mold compose [
  REBOL []
  halt: :quit
  change-dir (compiler-dir)
  echo (comp-echo)
  do/args %rsc.r "***src***"
]
replace comp "***src***" clean-path base-dir/:source-file
write comp-r comp

  ;; compose command line and call it
cmd: join to-local-file system/options/boot [" -sc " comp-r]
call/wait/output cmd make string! 1024	;; redirect output to anonymous buffer
    
  ;; collect compiler output & tidy up
comp-ok?: false
if exists? comp-echo [
  print read comp-echo
  comp-ok?: if find read comp-echo "output file size:" [true]
  delete comp-echo
]
if exists? comp-r [delete comp-r]
    
if comp-ok? [
  ;; move the executable from /builds to /Runnable
  built: builds-dir/:exe
  runner: runnable-dir/:exe
  if exists? built [
    write/binary runner read/binary built
    delete built
    if not windows-os? [
      r: open runner
      set-modes r [
        owner-execute: true
        group-execute: true
      ]
      close r
    ]
  ]
  
  ;; run the test and display the output
  exec: to-local-file runner
  clear output
  call/output/wait exec output
  print output
]
