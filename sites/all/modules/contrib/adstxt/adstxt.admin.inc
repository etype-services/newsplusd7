<?php

/**
 * @file
 * Administrative page callbacks for the adstxt module.
 */

/**
 * Administration settings form.
 *
 * @see system_settings_form()
 */
function adstxt_admin_settings() {
  $form['adstxt'] = array(
    '#type' => 'textarea',
    '#title' => t('Contents of ads.txt'),
    '#default_value' => variable_get('adstxt', ''),
    '#cols' => 60,
    '#rows' => 20,
    '#wysiwyg' => FALSE,
  );

  return system_settings_form($form);
}
