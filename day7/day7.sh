#!/bin/bash
input="../data.txt"
mkdir temp
cd temp
while IFS= read -r line
do
    # It would help to avoid using the root
    if [[ "$line" =~ cd[[:space:]]\/ ]]; then
        echo "Ignoring cd /"
    elif [[ "$line" =~ \$[[:space:]](cd[[:space:]][.a-z]+) ]]; then
        ${BASH_REMATCH[1]}
    elif [[ "$line" =~ dir[[:space:]]([.a-z]+) ]] then
        mkdir ${BASH_REMATCH[1]}
    elif [[ "$line" =~ ([0-9]+)[[:space:]]([.a-z]+) ]] then
        dd if=/dev/zero of=${BASH_REMATCH[2]} bs=${BASH_REMATCH[1]} count=1 &>/dev/null
    fi
done < "$input" 

cd /day7/temp

# part 1
sizesum=0
for f in $(find . -type d)
do
    size="$(find $f -type f -exec du -abs {} + | cut -f1 | awk '{s+=$1} END {print s}' )"
    if (( $size < 100000 )) then
        sizesum=$((sizesum + size))
    fi
done
echo $sizesum

# part 2
total=70000000
req=30000000
used="$(find . -type f -exec du -abs {} + | cut -f1 | awk '{s+=$1} END {print s}' )"
free=$((total-used))
needed=$((req-free))

currdel=99999999

for f in $(find . -type d)
do
    size="$(find $f -type f -exec du -abs {} + | cut -f1 | awk '{s+=$1} END {print s}' )"
    if (( $size >= $needed )) then
        if (( $size < $currdel )) then
            currdel=$size
        fi
    fi
done
echo $currdel
