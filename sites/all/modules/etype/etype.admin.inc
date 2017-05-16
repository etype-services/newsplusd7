<?php

/* admin settings form */
function etype_admin() {

  $form = array();

  $form['e_edition'] = array(
    '#type' => 'fieldset',
    '#title' => t('e-Edition'),
  );

  $form['e_edition']['etype_e_edition'] = array(
    '#type' => 'textfield',
    '#title' => t('e-Edition'),
    '#description' => t('For one paper enter the e-Edition like <code>Mitchell%20News-JournalID617</code>, for more than one format like this: <code>Mitchell%20News-JournalID617|Mitchell News Journal,The%20Yorktown%20News-ViewID84|The Yorktown News View</code>'),
    '#size' => 101,
    '#default_value' => variable_get('etype_e_edition'),
  );

  $form['e_edition']['etype_pub'] = array(
    '#type' => 'textfield',
    '#title' => t('eType Pub'),
    '#description' => t('Separate multiple entries with a comma, in the same order as the e-Editions'),
    '#size' => 55,
    '#default_value' => variable_get('etype_pub'),
  );

  $form['e_edition']['etype_ptype'] = array(
    '#type' => 'textfield',
    '#title' => t('eType PType'),
    '#description' => t('Separate multiple entries with a comma, in the same order as the e-Editions'),
    '#size' => 55,
    '#default_value' => variable_get('etype_ptype'),
  );

  $form['facebook'] = array(
    '#type' => 'fieldset',
    '#title' => t('Facebook'),
  );

  $form['facebook']['etype_facebook_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Facebook URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_facebook_url'),
  );

  $form['facebook']['etype_facebook_top'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add Facebook page link to main navigation bar'),
    '#default_value' => variable_get('etype_facebook_top', 0),
  );

  $form['facebook']['etype_facebook_footer'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add Facebook page link to footer area'),
    '#default_value' => variable_get('etype_facebook_footer', 0),
  );

  $form['etype_twitter_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Twitter'),
    '#description' => t('Twitter URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_twitter_url'),
  );

  $form['etype_googleplus_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Google Plus'),
    '#description' => t('Google Plus URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_googleplus_url'),
  );

  $form['etype_youtube_url'] = array(
    '#type' => 'textfield',
    '#title' => t('YouTube'),
    '#description' => t('YouTube URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_youtube_url'),
  );

  $form['etype_instagram_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Instagram'),
    '#description' => t('Instagram URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_instagram_url'),
  );

  $form['etype_pinterest_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Pinterest'),
    '#description' => t('Pinterest URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_pinterest_url'),
  );

  $form['etype_vimeo_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Vimeo'),
    '#description' => t('Vimeo URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_vimeo_url'),
  );

  $form['etype_rss_feed'] = array(
    '#type' => 'textfield',
    '#title' => t('RSS Feed'),
    '#description' => t('Enter "Yes" to turn this on'),
    '#size' => 55,
    '#default_value' => variable_get('etype_rss_feed'),
  );

  return system_settings_form($form);
}