#/bin/bash

FILE_NOT_FOUND_EXIT_CODE=0
FILE_FOUND_EXIT_CODE=1
EXIT_CODE_PASS=0

# Se não foi informado o nome do arquivo, então é feito uma busca pelo qual tipo de arquivo
if [ $1 != *. ]
then
	EXTENSION="ls | grep $1 | cut -d"." -f2-"
	SEP_EXTENSION="ls | grep $1 | cut -d"." -f1"
	FILE_NAME="$(eval $SEP_EXTENSION).$(eval $EXTENSION)"
else
	FILE_NAME=$SEP_EXTENSION
fi
echo $
if [ ! -f $FILE_NAME -o -d $FILE_NAME ]
then
	echo "Arquivo não encontrado"
	exit $FILE_NOT_FOUND_EXIT_CODE
fi

COMMAND_LINE="file $FILE_NAME | tr -d ' ' | cut -d: -f2"
echo "Procurando o texto $2 no arquivo $FILE_NAME. Arquivo do tipo $(eval $COMMAND_LINE)."
# "/dev/null" não deixar retornar nada no terminal após algum comando shell
grep $2 $FILE_NAME > /dev/null
EXIT_CODE=$?


if [ $EXIT_CODE -eq $EXIT_CODE_PASS ]
then
	echo "Texto encontrado!!! Recorrência do texto no arquivo: $(grep $2 $FILE_NAME | wc -l)"
	exit $FILE_FOUND_EXIT_CODE
elif [ $EXIT_CODE -eq 1 ]
then
	echo "Texto não encontrado"
	exit 0
fi