#!/bin/bash

MINISHELL=./minishell

input_test()
{
	TEST=$1
	ARG=$2
	printf '%s - %s :' "$TEST" "$ARG"
	printf '%s\n' "$ARG" >expected
	echo "$ARG" | "$MINISHELL" >result 2>/dev/null

	diff expected result >/dev/null && echo "✅input test OK" || echo "❌input test NG"
	rm -f expected result
}

exec_test()
{
	input_test $1 $2
}

#--- default text ---
TEST="default text"
#1
ARG=hello
exec_test $TEST $ARG
#2
ARG="ls -la"
exec_test $TEST $ARG

#--- space ---
TEST=space
#3
ARG=""
exec_test $TEST $ARG
#4
ARG=" "
exec_test $TEST $ARG
#5
ARG="	"
exec_test $TEST $ARG

#--- text and space ---
TEST="text and space"
#6
ARG="this is a pen "
exec_test $TEST $ARG
#7
ARG="word 	word    word"
exec_test $TEST $ARG

#--- quate ---
TEST="quate"
#8
ARG="'single quate'"
exec_test $TEST $ARG
#9
ARG="\"double quate\""
exec_test $TEST $ARG

#--- special ---
TEST="special"
#10
ARG="*"
exec_test $TEST $ARG
#11
ARG="?"
exec_test $TEST $ARG
#12
ARG="|"
exec_test $TEST $ARG
#13
ARG="&"
exec_test $TEST $ARG

#--- long text ---
#14
TEST="long text"
ARG="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
exec_test $TEST $ARG

#--- escape ---
TEST=escape
ARG="hello world \\\n this is a pen"
exec_test $TEST $ARG