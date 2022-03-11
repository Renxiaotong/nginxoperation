#!/bin/bash

#进度条函数
i=0; bar='';lable=('|' '/' '-' '\\');index=0;
while [ $i -le 100 ]
  do
    printf  "[%-100s][%d%%][%c] \r" "$bar" "$i" "${lable[$index]}"            
  	 bar='#'$bar
 	 let i++
   	 let index++
   	 let index%=4
 	 sleep 0.1;
done 
printf "\n"

