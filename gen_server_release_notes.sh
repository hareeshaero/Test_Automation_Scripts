################################################################################
function usage(){
  echo "************************************************"
  echo "execute the script with the following arguements"
  echo "source gen_bk.sh \$build_number"
  echo "Example usage : source gen_bk.sh 3.3.18"
  echo "************************************************"
}
################################################################################

if [ -z "$1" ]
then
  usage
  return 
fi

# creates the temporary output file
echo "creates the output file***************************"
>./test_bk.txt

if [ ! -f "email_content" ]
then
  echo "###############WARNING->File email_content does not exist##############"
  echo "INFO:Copy of contents of the release email to the file email_content
  and re run the script"
  return 
fi

#Get the input from the server release email"
less email_content  | cat >> test_bk.txt
echo $'\n' | cat >> test_bk.txt


#inserts the componenet information
echo "**********Componenet information input to the temp file **********"
echo $'Components:\n' | cat >> test_bk.txt
less tags.yml | cat >> test_bk.txt
echo $'\n' | cat >> test_bk.txt

#inserts the releases information
echo "**********Release information inserted to the output file**********"
ssh citrusleaf@bunnycentos6 ls -RC1 $"/mnt/release/server/$1" | cat >> test_bk.txt
echo $'\n' | cat >> test_bk.txt

#inserts the changelog information"
echo "**********Changelog information inserted to the output file**********"
echo $'Changelog:' | cat >> test_bk.txt
sort -u build/CHANGELOG | cat >> test_bk.txt
