# Helper script for automation of c header files.

arg_check(){
  [[ $# > $1 ]] && >2& echo "Expected $1 arguments, but got $(($# - 1))" && exit 1;
}

# Initialise the file (Make it blank)
init(){
  echo -n
}

write() {
  arg_check 2
  echo "$*"
}

header(){
  COUNT=$(echo "$*" | wc -c)

  echo -n "//"
  local counter=0
  while [ $counter -lt $COUNT ]; do
    echo -n '#'
    let counter=counter+1
  done
  echo "#######"

  echo "//### $* ###"

  echo -n "//"
  counter=0
  while [ $counter -lt $COUNT ]; do
    echo -n '#'
    let counter=counter+1
  done
  echo "#######"
}

comment(){
  echo "// ${@:2}"
}
