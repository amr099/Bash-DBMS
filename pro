#!/bin/bash

function createdb {

        echo -e 'Enter name of database you wanna create: \c' 
        read dbname
        if [ -d $dbname ]
        then
                echo Database name exists!
                exit;
        else
                mkdir $dbname
                echo ====$dbname has been created successfully====
        fi
}

function dropdb { 
        echo -e 'Enter name of database you wanna drop : \c'
        read dropdb
        if [ ! -d $dropdb ]
        then
                echo Database name does not exist!
                exit;
        else
                rm -r $dropdb
                echo =====$dropdb has been droped successfully=====
        fi
}
         
function connectdb {
        echo -e 'Enter Database you wanna connect to : \c'    
        read connect
        if [ ! -d $connect ]
        then
                echo Database name does not exist!
                exit;
        else	 
                echo =====You are connected to $connect=====
                cd $connect
        fi
}

function createtable {
        echo -e 'Enter table name : \c'
        read tablename

        if [ -f $tablename ]
        then
                echo 'Table name exists'
                exit;
        else
                #cd $connect
                touch $tablename
        fi

        echo -e 'Enter Primary Key : \c'
        read pk

        echo -n $pk "|" >> $tablename

        echo -e 'How many colmns do you wanna create ? \c'
        read col
        
        for i in $(seq ${col})
        do
                echo -e Enter colmn ${i} name:
                read colname
                echo -n $colname >> $tablename

                echo '1.INT'
                echo '2.STR'
                echo -e 'Select datatype : \c'
                read datatype
                case $datatype in
                        1) echo -n '(INT)' >> $tablename
                        ;;
                        2) echo -n '(STR)' >> $tablename
                        ;;
                        *) 
                        echo "Wrong Choice";
                        rm -r $tablename
                        exit;
                esac
                #Generate suitable number of spaces
                typeset -i var=15-${#name}
                for i in $(seq ${var})
                do
                        echo -n " " >> $tablename
                done
                echo -n '|' >> $tablename
        done

}

function droptable {
        echo -e 'Enter name of table you wanna drop : \c'
        read dropt
        cd $connect
        if [ ! -f $dropt ]
        then
                echo 'Table name does not exist!'
                exit;
        else
                rm -r $dropt
                echo =====$dropt has been droped succefully=====
        fi
        exit;
}

function selectfrom {
        echo -e 'Enter Table Name: \c'  
        read tname

        echo " 1. Select All        "
        echo " 2. Select Row        "
        echo " 3. Select Column     "
        echo -e "Enter Choice: \c"
        read ch1

        case $ch1 in
        1)		
        cd $connect
        awk '{print $0}' $tname;
        exit
        ;;


        2)
        echo -e 'Enter Row : \c'
        read row
        row=$((row+1))
        awk -v i="$row" '{if(NR==i){print $0}}' $tname	
        ;;


        3)
        echo -e 'Enter Column : \c'
        read col
        awk -v i="$col" -F "|" '{print $i}' $tname
        exit
        esac
}

function insert {
        echo TODO
}

function update {
        echo TODO
}

function delete {
        echo TODO
}


 

clear

if [ ! -d databases ]
then
        mkdir databases;
fi
cd databases

echo '                             +++++ Welcome To Team3 Database +++++'

echo '_____________________________________________________________________________________________________________'
echo '                                                                                                             '
echo "                                  1. Create Database       "
echo "                                  2. List Databases        "
echo "                                  3. Drop Database         "
echo "                                  4. Connect to Database   "
echo "                                  5. Exit                  "
echo -e "Enter: \c"

read select1
case $select1 in
        1) createdb ;;

        2) ls ;;

        3) dropdb ;;
        
        4) connectdb ;;
        
        5) exit ;;
  

        *) echo 'Please enter valid choice [1 - 5]' ; exit;
        
        
esac       	 

# ========================================================================================================================

echo "                                  1. Create Table       "
echo "                                  2. List Tables        "
echo "                                  3. Drop Table         "
echo "                                  4. Insert Into Table  "
echo "                                  5. Select From Table  "
echo "                                  6. Update Table       "
echo "                                  7. Delete From Table  "
echo "                                  8. Exit               "

echo -e "Enter: \c"
read select2
case $select2 in
        1)createtable ;;
        
        2) ls ;; 

        3)droptable ;;

        4) insert ;;

        5) selectfrom ;;
        
        6) echo 'Update';;

        7) 
        echo -e 'Enter Table Name: \c'
        read dt
        sed -i '2,$d' $dt;	
        ;;
        
        8) exit ;;

esac



