@echo off 
setlocal 
"C:\Program Files\Git\bin\bash.exe" --login -i "C:\Program Files\Docker Toolbox\start.sh" 

if [[ "$?" != 0 ]]; then
echo "Commnad Error"
else
echo "Commnad Success"
exit
fi

"C:\Users\agsuser\Desktop\test1.sh"