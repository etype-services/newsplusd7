<?php

/* admin settings form */
function etype_fb_autopost_admin() {

  $fb_app_id = variable_get('etype_facebook_app_id');

  $form = [];

  $form['etype_facebook_app_id'] = array(
    '#type' => 'textfield',
    '#title' => t('Facebook App Id'),
    '#description' => t('The App Id allows for Facebook functionality including autoposting. Set up an App <a href="https://developers.facebook.com/apps">here</a>. You will need to log in to Facebook with an account that can administer the Page you want to autopost to. Once you save the App Id you will be able to select a Facebook Page.'),
    '#size' => 55,
    '#default_value' => $fb_app_id,
  );

  if (! empty($fb_app_id)) {

    $form['etype_facebook_login'] = array(
      '#markup' => '<div id="etype_fb_login" class="link description"></div>'
    );

    $options = [
      0 => t('Select'),
    ];
    $etype_facebook_page_id = variable_get('etype_facebook_page_id', 0);
    if ($etype_facebook_page_id > 0) {
      $form['facebook']['etype_facebook_page_markup'] = array(
        '#markup' => '<div class="description">Saved Facebook Page Id is ' . $etype_facebook_page_id . '.</div>',
      );
    }

    $form['etype_facebook_page_id'] = array(
      '#type' => 'select',
      '#title' => t('Facebook Page Id '),
      '#description' => t('Facebook pages for which you are an admin appear here. Select the page you want to post stories to.'),
      '#options' => $options,
      '#validated' => TRUE
    );

  }


  return system_settings_form($form);
}
