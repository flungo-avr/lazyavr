# The MIT License (MIT)
#
# Copyright (c) 2015 Fabrizio Lungo <fab@lungo.co.uk>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Helper script for automation of c header files.

arg_check(){
  [[ $# > $1 ]] ||  >&2 echo "Expected $1 arguments, but got $(($# - 1))" && exit 1;
}

# Initialise the file (Make it blank)
init(){
  echo -n > $1
}

write() {
  arg_check 2
  echo "$*"
}

header(){
  COUNT=$(echo "$*" | wc -c)

  echo -n '/'
  local counter=0
  while [ $counter -lt $COUNT ]; do
    echo -n '*'
    let counter=counter+1
  done
  echo '*******/'

  echo '/*** '$*' ***/'


  echo -n '/'
  counter=0
  while [ $counter -lt $COUNT ]; do
    echo -n '*'
    let counter=counter+1
  done
  echo '*******/'
}

comment(){
  echo "// ${@:2}"
}
