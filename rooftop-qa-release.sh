# get the latest rooftop-cms from qa
git checkout qa 
git pull

current=`pwd`

echo "Checking out qa repositories..."
echo ""

cd public/web/app/mu-plugins/
for dir in rooftop-*/; do echo $dir && cd $dir && git checkout qa && git pull  && git merge development && git push ; cd .. ; done 
cd $current

cd public/web/app/plugins/
for dir in rooftop-*/; do echo $dir && cd $dir && git checkout qa && git pull && git merge development && git push ; cd .. ; done 
cd $current

cd public/web/app/themes/
for dir in rooftop-*/; do echo $dir && cd $dir && git checkout qa && git pull && git merge development && git push ; cd .. ; done 
cd $current

