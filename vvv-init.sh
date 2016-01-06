if [ ! -f "public/.env" ]; then
    cp ./.env.example public/.env;
fi

source public/.env;

if [ ! -d "web/wp/wp-admin" ]; then
	echo 'Configuring hosted wordpress CMS for vvv'
	cd ./public
	composer install
	echo "Creating database (if it's not already there)"
	mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME"
	mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'$DB_HOST' IDENTIFIED BY '$DB_PASSWORD';"
	wp core multisite-install --subdomains --url=$WP_URL --title="Hosted Wordpress" --admin_user=admin
	--admin_password=password --admin_email=hosting@errorstudio.co.uk --allow-root --path=public/web/wp
	# wp theme delete twentythirteen --allow-root; wp theme delete twentyfourteen --allow-root; wp theme delete twentyfifteen --allow-root; wp plugin delete hello --allow-root; wp plugin delete aksimet --allow-root;
	
	cd -

fi
