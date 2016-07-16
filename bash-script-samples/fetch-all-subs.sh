export PATH=~/scripts/video:$PATH
for file in `ls | grep ".mkv"`; do qnapi -c $file; txt=`echo $file | sed s/...$/txt/`; echo $txt; mv $txt $txt.tmp; convert-txt-cp1250-utf8.sh $txt.tmp > $txt; rm $txt.tmp; done
