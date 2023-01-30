#/bin/bash

for ((i=0;i<10;i++));
do
    echo $i
done

for i in $(seq 1 9)
do
    echo $i
done

for i in 1 2 3 4 5
do
    echo $i
done  

for i in {10..20}; do echo "valor: $i"; done