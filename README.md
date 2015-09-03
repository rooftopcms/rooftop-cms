__This project is in private alpha, and is being actively developed.__
# Rooftop CMS - Wordpress, without borders
__The CMS you know, with the website you want__

## What is Rooftop?
Rooftop is a hosted, API-only implementation of the [Wordpress](http://wordpress.org) CMS. Write your content from the comfort of the familiar Wordpress content management tools, and use it anywhere you like, across mobile applications and websites.

## What problem does this solve?
At [Error](http://www.errorstudio.co.uk) we have built many projects where we needed to expose content in several different ways: a web application and marketing site, for example. Or maybe a native mobile app and a website. It's been fraught with complexity, and the solution is simple. Expose the content as data, without style, so we can display as we want.

### Wordpress: the CMS you know
There are loads of CMSs in the marketplace, but not all of them are open-source or used by millions of websites. You will almost certainly be familiar with Wordpress, and so will your clients. Why introduce something else to learn? With Rooftop you don't need to. Under the bonnet it's just Wordpress. You write a very simple theme to set up content types and taxonomies, and the Rooftop API takes care of the rest.

### The site you want
With Rooftop responsible for exposing the content as data, you need to consume it. Over time we're planning to build an ecosystem of client libraries. For launch, there will be Ruby, PHP and Swift libraries for you to simply integrate into your products.

## What's included?

### Wordpress plugins
Our aim for Rooftop is that you can make use of a set of well-used plugins, and get the data out of the Rooftop API to use in your own applications and sites. We've built the following plugins:

* `rooftop-api-authentication`: authenticate using a predefined key, which you add in the admin interface of your Rooftop instance.
* `rooftop-admin-theme`: hide a lot of the Wordpress complexity which we take care of, leaving you to concentrate on content
* `rooftop-preview-mode`: allow API clients to see content in draft if they pass the correct header
* `rooftop-admin-iframe`: include the Rooftop admin bar in your site, when the user is logged in
* `rooftop-response-sanitiser`: clean up output to the API, so the content is truly destination-agnostic
* `rooftop-queue-pusher`: send messages to a queue when data in Rooftop is updated
* `rooftop-events`: an extensible model for events management
* `rooftop-posts2posts-exposer`: expose https://github.com/scribu/wp-posts-to-posts data as part of your API responses
* `rooftop-gravityforms-exposer`: expose http://www.gravityforms.com/ data as part of your API responses. If you use the hosted Rooftop solution, you won't need to pay a separate licence fee.
* `rooftop-act-exposer`: expose http://www.advancedcustomfields.com/ data pas part of your API responses. If you use the hosted Rooftop solution, you won't need to pay a separate licence fee.
* `rooftop-search`: a more powerful search, based on ElasticSearch.

### Other Services

* A ruby gem to send webhook messages to your configured endpoint

## What's the licence for Rooftop?
This project is MIT licenced (see the LICENCE file in this repo), so if you want to host it yourself, you can.

Of course, there's a non-trivial amount of hassle involved in maintaining a secure Wordpress multisite installation, so we do the hard work for you at http://www.rooftopcms.com. 

## How do I get started?
If you're trying the project out in development, we use the [VVV](https://github.com/rooftopcms/VVV) project to spin up a vagrant box with everything you need to get started:

```
git clone https://github.com/rooftopcms/VVV.git
cd VVV/www
git clone https://github.com/rooftopcms/rooftop-cms.git
composer install
vagrant up
```

You should be able to get to your rooftop site at http://rooftop-cms.dev.
