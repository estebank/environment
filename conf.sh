SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p ~/.myscripts
ln $SCRIPT_DIR/fancy_prompt.sh ~/.myscripts/fancy_prompt.sh

mv ~/.bashrc ~/.bashrc.bkp
ln $SCRIPT_DIR/bashrc.sh ~/.bashrc

mv ~/.vimrc ~/.vimrc.bkp
ln $SCRIPT_DIR/vimrc ~/.vimrc
