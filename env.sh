#
# Initializes the bash
#

RVM_RUBY=1.9.3

function readlink_f(){
	cd $1;
	pwd;
}

function source_dir(){
	reldir=`dirname $BASH_SOURCE`
	readlink_f $reldir
}

rvm use $RVM_RUBY

if [ ! -d "$RSTY_PATH" ]
then
	echo "bundle install --binstubs"
	bundle install --binstubs=$RSTY_PATH
fi

RSTY_PATH=`source_dir`/.bin
export PATH=$RSTY_PATH:$PATH
	