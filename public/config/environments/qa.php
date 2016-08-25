<?php
define('SAVEQUERIES', true);
define('WP_DEBUG', true);
define('WP_DEBUG_DISPLAY', true);
define('SCRIPT_DEBUG', true);

// Rollbar config
$rollbar_lib_path = ABSPATH."../../vendor/rollbar/rollbar/src/rollbar.php";
if( $token = getenv( 'ROLLBAR_ACCESS_TOKEN' ) && file_exists( $rollbar_lib_path ) ) {
    require_once $rollbar_lib_path;

    $config = array(
        // required
        'access_token' => $token,
        'environment' => getenv('WP_ENV'),
        // optional - path to directory your code is in. used for linking stack traces.
        'root' => ABSPATH
    );
    Rollbar::init($config);
}
