<?php
/**
 * Helper function for including theme files.
 *
 * @param string $theme
 *   Name of the theme to use for base path.
 * @param string $path
 *   Path relative to $theme.
 */
function gavias_synery_include($theme, $path) {
  static $themes = array();
  if (!isset($themes[$theme])) {
    $themes[$theme] = drupal_get_path('theme', $theme);
  }
  if ($themes[$theme] && ($file = DRUPAL_ROOT . '/' . $themes[$theme] . '/' . $path) && file_exists($file)) {
    include_once $file;
  }
}

function _gavias_synery_icon($name) {
  $output = '';
  // Attempt to use the Icon API module, if enabled and it generates output.
  if (module_exists('icon')) {
    $output = theme('icon', array('bundle' => 'bootstrap', 'icon' => 'glyphicon-' . $name));
  }
  if (empty($output)) {
    // Mimic the Icon API markup.
    $attributes = array(
      'class' => array('icon', 'glyphicon', 'glyphicon-' . $name),
      'aria-hidden' => 'true',
    );
    $output = '<i' . drupal_attributes($attributes) . '></i>';
  }
  return $output;
}