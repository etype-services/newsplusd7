<?php

/* admin settings form */
function etype_admin() {

  $form = array();

  /* e_edition settings */
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

  /* facebook */
  $form['facebook'] = array(
    '#type' => 'fieldset',
    '#title' => t('Facebook'),
  );

  $form['facebook']['etype_facebook_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Facebook '),
    '#description' => t('Full Facebook URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_facebook_url', 'https://www.facebook.com/'),
  );

  $form['facebook']['etype_facebook_top'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to main navigation bar'),
    '#default_value' => variable_get('etype_facebook_top', 0),
  );

  $form['facebook']['etype_facebook_footer'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to footer area'),
    '#default_value' => variable_get('etype_facebook_footer', 0),
  );

  $form['facebook']['etype_facebook_contact'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to Contact page'),
    '#default_value' => variable_get('etype_facebook_contact', 0),
  );

  $form['facebook']['etype_facebook_app_id'] = array(
    '#type' => 'textfield',
    '#title' => t('Facebook App Id'),
    '#description' => t('The App Id allows for Facebook functionality including autoposting. Set up an App <a href="https://developers.facebook.com/apps">here</a>. You will need to log in to Facebook with an account that can administer the Page you want to autopost to, and be logged in to this account when creating new content.'),
    '#size' => 55,
    '#default_value' => variable_get('etype_facebook_app_id', ''),
  );

  $form['facebook']['etype_facebook_login'] = array(
    '#markup' => '<div id="etype_fb_login" class="link"></div>'
  );

  $options = [
    0 => t('Select'),
  ];
  $etype_facebook_page_id = variable_get('etype_facebook_page_id', 0);
  $form['facebook']['etype_facebook_page_id'] = array(
    '#type' => 'select',
    '#title' => t('Facebook Page Id '),
    '#description' => t('Facebook pages for which you are an admin appear here. Select the page you want to post stories to.'),
    '#options' => $options,
    '#validated' => TRUE
  );


  /* twitter */
  $form['twitter'] = array(
    '#type' => 'fieldset',
    '#title' => t('Twitter'),
  );

  $form['twitter']['etype_twitter_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Twitter'),
    '#description' => t('Full Twitter URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_twitter_url', 'https://twitter.com/'),
  );

  $form['twitter']['etype_twitter_top'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to main navigation bar'),
    '#default_value' => variable_get('etype_twitter_top', 0),
  );

  $form['twitter']['etype_twitter_footer'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to footer area'),
    '#default_value' => variable_get('etype_twitter_footer', 0),
  );

  $form['twitter']['etype_twitter_contact'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to Contact page'),
    '#default_value' => variable_get('etype_twitter_contact', 0),
  );

  /* googleplus */
  $form['googleplus'] = array(
    '#type' => 'fieldset',
    '#title' => t('Google Plus'),
  );

  $form['googleplus']['etype_googleplus_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Google Plus'),
    '#description' => t('Full Google Plus URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_googleplus_url', 'https://plus.google.com/'),
  );

  $form['googleplus']['etype_googleplus_top'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to main navigation bar'),
    '#default_value' => variable_get('etype_googleplus_top', 0),
  );

  $form['googleplus']['etype_googleplus_footer'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to footer area'),
    '#default_value' => variable_get('etype_googleplus_footer', 0),
  );

  $form['googleplus']['etype_googleplus_contact'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to Contact page'),
    '#default_value' => variable_get('etype_googleplus_contact', 0),
  );

  /* youtube */
  $form['youtube'] = array(
    '#type' => 'fieldset',
    '#title' => t('YouTube'),
  );

  $form['youtube']['etype_youtube_url'] = array(
    '#type' => 'textfield',
    '#title' => t('YouTube'),
    '#description' => t('Full YouTube URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_youtube_url', 'https://youtube.com/'),
  );

  $form['youtube']['etype_youtube_top'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to main navigation bar'),
    '#default_value' => variable_get('etype_youtube_top', 0),
  );

  $form['youtube']['etype_youtube_footer'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to footer area'),
    '#default_value' => variable_get('etype_youtube_footer', 0),
  );

  $form['youtube']['etype_youtube_contact'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to Contact page'),
    '#default_value' => variable_get('etype_youtube_contact', 0),
  );

  /* instagram */
  $form['instagram'] = array(
    '#type' => 'fieldset',
    '#title' => t('Instagram'),
  );

  $form['instagram']['etype_instagram_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Instagram'),
    '#description' => t('Full Instagram URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_instagram_url', 'https://instagram.com/'),
  );

  $form['instagram']['etype_instagram_top'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to main navigation bar'),
    '#default_value' => variable_get('etype_instagram_top', 0),
  );

  $form['instagram']['etype_instagram_footer'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to footer area'),
    '#default_value' => variable_get('etype_instagram_footer', 0),
  );

  $form['instagram']['etype_instagram_contact'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to Contact page'),
    '#default_value' => variable_get('etype_instagram_contact', 0),
  );

  /* pinterest */
  $form['pinterest'] = array(
    '#type' => 'fieldset',
    '#title' => t('Pinterest'),
  );

  $form['pinterest']['etype_pinterest_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Pinterest'),
    '#description' => t('Full Pinterest URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_pinterest_url', 'https://pinterest.com/'),
  );

  $form['pinterest']['etype_pinterest_top'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to main navigation bar'),
    '#default_value' => variable_get('etype_pinterest_top', 0),
  );

  $form['pinterest']['etype_pinterest_footer'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to footer area'),
    '#default_value' => variable_get('etype_pinterest_footer', 0),
  );

  $form['pinterest']['etype_pinterest_contact'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to Contact page'),
    '#default_value' => variable_get('etype_pinterest_contact', 0),
  );

  /* vimeo */
  $form['vimeo'] = array(
    '#type' => 'fieldset',
    '#title' => t('Vimeo'),
  );

  $form['vimeo']['etype_vimeo_url'] = array(
    '#type' => 'textfield',
    '#title' => t('Vimeo'),
    '#description' => t('Full Vimeo URL'),
    '#size' => 55,
    '#default_value' => variable_get('etype_vimeo_url', 'https://vimeo.com/'),
  );
  
  $form['vimeo']['etype_vimeo_top'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to main navigation bar'),
    '#default_value' => variable_get('etype_vimeo_top', 0),
  );

  $form['vimeo']['etype_vimeo_footer'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to footer area'),
    '#default_value' => variable_get('etype_vimeo_footer', 0),
  );

  $form['vimeo']['etype_vimeo_contact'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to Contact page'),
    '#default_value' => variable_get('etype_vimeo_contact', 0),
  );

  /* rss */
  $form['rss'] = array(
    '#type' => 'fieldset',
    '#title' => t('RSS'),
  );

  $form['rss']['etype_rss_top'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to main navigation bar'),
    '#default_value' => variable_get('etype_rss_top', 0),
  );

  $form['rss']['etype_rss_footer'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to footer area'),
    '#default_value' => variable_get('etype_rss_footer', 0),
  );

  $form['rss']['etype_rss_contact'] = array(
    '#type' => 'checkbox',
    '#title' => t('Add link to Contact page'),
    '#default_value' => variable_get('etype_rss_contact', 0),
  );

  return system_settings_form($form);
}