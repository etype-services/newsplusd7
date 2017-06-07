<?php

/**
 * @file
 * Administration settings for the Composer Autoload module.
 */

/**
 * Menu callback; Configuration settings for the Composer Autoload module.
 */
function composer_autoload_admin() {
  $form = array(
    '#submit' => array('composer_autoload_admin_clear_cache'),
  );

  $form['composer_autoload_path'] = array(
    '#type' => 'textfield',
    '#title' => t('Custom Composer Autoload Path'),
    '#default_value' => variable_get('composer_autoload_path', 'sites/all/vendor/autoload.php'),
    '#description' => t('Provide a custom path to your own autoload.php file, relative to the Drupal root.'),
  );

  return system_settings_form($form);
}

/**
 * Form callback; Called when the Composer Autoload form is submitted.
 *
 * Clears the Composer Autoload cache.
 */
function composer_autoload_admin_clear_cache() {
  // Clear the composer_autoload cache.
  cache_clear_all('composer_autoload', 'cache');

  // Reset the static cache for composer_autoload too.
  drupal_static_reset('composer_autoload');
}
