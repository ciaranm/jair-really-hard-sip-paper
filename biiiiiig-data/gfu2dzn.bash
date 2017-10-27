#!/bin/bash

graphType=${1}
if [[ $2 == true ]] ; then number=true ; else number=false ; fi

count=0
while read title ; do
    [[ ${title:0:1} == "#" ]] || { echo "bad title '$title'" ; exit 1; }
    title=${title/\#}

    count=$(( count + 1 ))
    if $number ; then
        title=${title}-${count}
    fi

    echo $title 1>&2
    [[ -f ${title}.dzn ]] && { echo "$title.dzn already exists" ; exit 1; }

    {
        echo '%' $title

        read vertices

        echo "${graphType:0:1} = $vertices;"

        echo -n "${graphType}Labels = ["

        for i in $(seq 1 $vertices ) ; do
            read label
            printf '%d, ' "'$label"
        done
        echo "];"

        read edgecount

        unset adj
        declare -A adj

        for i in $(seq 0 $(( vertices - 1 )) ) ; do
            for j in $(seq 0 $(( vertices - 1 )) ) ; do
                adj[x${i}y${j}]=0
            done
        done

        for i in $(seq 1 ${edgecount} ) ; do
            read e1 e2
            adj[x${e1}y${e2}]=1
            adj[x${e2}y${e1}]=1
        done

        echo -n "${graphType}Adj = ["
        for i in $(seq 0 $(( vertices - 1 )) ) ; do
            echo -n "| "
            for j in $(seq 0 $(( vertices - 1 )) ) ; do
                echo -n ${adj[x${i}y${j}]} ","
            done
            echo
        done
        echo "|];"
    } > ${title}.dzn
done
