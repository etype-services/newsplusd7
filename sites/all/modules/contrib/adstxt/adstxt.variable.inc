<?php

/**
 * @file
 * Definition of variables for Variable API module.
 */

/**
 * Implements hook_variable_info().
 */
function adstxt_variable_info($options = array()) {
  $variables['adstxt'] = array(
    'title' => t('Contents of ads.txt', array(), $options),
    'type' => 'text',
    'group' => 'adstxt',
    'localize' => TRUE,
    'multidomain' => TRUE,
  );

  return $variables;
}

/**
 * Implements hook_variable_group_info().
 */
function adstxt_variable_group_info() {
  $groups['adstxt'] = array(
    'title' => t('AdsTxt'),
    'description' => t('Configure ads.txt file.'),
    'access' => 'administer ads.txt',
    'path' => array('admin/config/system/adstxt'),
  );

  return $groups;
}
