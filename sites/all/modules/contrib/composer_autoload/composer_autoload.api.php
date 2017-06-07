<?php
/**
 * @file
 * Shows the api functions for composer_autoload
 *
 * @ingroup composer_autoload
 * @{
 */

/**
 * Allow modules to alter the list of loaders before they are cached.
 *
 * @param array $loaders
 */
function hook_composer_autoload_loaders_alter(&$loaders) {
  $key = array_search('sites/all/modules/custom/my_module/phpunit/vendor/utoload.php', $loaders);
  if ($key !== FALSE) {
    unset($loaders[$key]);
  }
}
