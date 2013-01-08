SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo mv ~/.bashrc ~/.bashrc.bkp
echo ln $SCRIPT_DIR/bashrc.sh ~/.bashrc

echo mv ~/.vimrc ~/.vimrc.bkp
echo ln $SCRIPT_DIR/vimrc ~/.vimrc
