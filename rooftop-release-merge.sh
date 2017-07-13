# get the latest rooftop-cms from master
git checkout master 
git pull

current=`pwd`

echo "Checking out master repositories..."
echo ""

cd public/web/app/mu-plugins/
for dir in rooftop-*/; do echo $dir && cd $dir && git checkout master && git pull  && git merge qa && git push ; cd .. ; done 
cd $current

cd public/web/app/plugins/
for dir in rooftop-*/; do echo $dir && cd $dir && git checkout master && git pull && git merge qa && git push ; cd .. ; done 
cd $current

cd public/web/app/themes/
for dir in rooftop-*/; do echo $dir && cd $dir && git checkout master && git pull && git merge qa && git push ; cd .. ; done 
cd $current

