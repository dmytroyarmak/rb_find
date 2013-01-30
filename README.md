Find
======== 

You are to write find.rb, a simple utility mimicking find(1).
If you are familiar with find(1), be wary that the code we're asking you uses regexps where find(1) uses globing.
Also, the option format is slightly different, so you can use the ruby stdlib OptionParser.

find.rb returns a newline separated list of files, each of which validates a list of predicates.

For this exercise, you are to assume that all given options are composed with a logical AND.

Example:

`ruby find.rb / --name "s.*" --type d`

will return (at least):

`/sbin
/sys`

Invocation: find.rb DIRECTORY [OPTS]

Mandatory options:

`--name ARG : Where ARG is an extended regexp ("file-.." matches "file-XX" and "files-42"). Predicate matches if browsed file name matches.
--type ARG : (ARG == "f" or ARG == "d", for file and directory respectively). Predicate matches if browsed file is of desired type.`

Bonus options :

`--cnewer PATH : Predicate matches if browsed file is newer than the file at PATH.
--type ARG : Handle "l" for symbolic link and "s" for socket
--user UNAME : Predicate matches if browsed file is owned by UNAME
--maxdepth N : Do no go deeper than N subdirectories while crawling DIRECTORY`

