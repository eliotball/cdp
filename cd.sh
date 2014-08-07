arg=$1

if [[ $1 =~ ^\.\..+$ ]]
then
  current=`pwd`
  search=`echo $1 | sed 's/^..//g'`
  while [[ ! `pwd | sed 's/^.*\///g'` =~ $search && ! `pwd` =~ ^/$ ]]
  do
    cd ..
  done
  if [[ `pwd` =~ ^/$ ]]
  then
    cd $current
    echo "$search not found in path $current"
  else
    new=`pwd`
    echo "cd $new"
  fi
elif [[ $1 =~ ^,.+$ ]]
then
  start=`pwd`
  search=`echo $1 | sed 's/^,//g'`
  queue=(`pwd`)
  next=0
  last=0
  while [[ "$next" -le "$last" ]]
  do
    current=${queue[$next]}
    cd $current 2> /dev/null
    if [[ `pwd | sed 's/.*\///g'` =~ ^$search$ ]]
    then
      new=`pwd`
      echo "cd $new"
      break
    fi
    cd $start
    for neighbour in `find $current/* -maxdepth 0 -type d 2> /dev/null`
    do
      queue+=("$neighbour")
      last=$(($last + 1))
    done
    if ! [ "$current" == "/" ]
    then
      queue+=("$current/..")
      last=$(($last + 1))
    fi
    next=$(($next + 1))
  done
else
  cd $1
fi
