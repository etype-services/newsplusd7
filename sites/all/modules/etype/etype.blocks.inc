<?php

/**
 * Implements hook_block_info().
 */
function etype_block_info() {
  $blocks = [];

  $blocks['e-Edition'] = [
    'info' => t('e-Edition'),
  ];

  $blocks['Social-Search'] = [
    'info' => t('eType Social & Search'),
  ];
  return $blocks;
}

/**
 * Implements hook_block_view().
 */
function etype_block_view($delta = '') {
  $block = [];
  switch ($delta) {
    case 'e-Edition':
      $block['subject'] = '';
      $block['content'] = _etype_e_edition_content();
      break;

    case 'Social-Search':
      $block['subject'] = '';
      $block['content'] = _etype_social_search_content();
      break;
  }
  return $block;
}

/**
 * e-Edition block
 */
function _etype_e_edition_content() {
  $e_editions = etype_e_editions();
  $output = '';
  foreach($e_editions as $e_edition) {
    $output .= '
<p><a href="' . $e_edition['path'] . '"><img src="' . $e_edition['image'] . '"></a></p>
<p><a href="' . $e_edition['path'] . '">Click here to read ' . $e_edition['site_name'] . '</a></p>
';
  }
  return $output;
}

/**
 * Social & Search block for Navigation bar
 */
function _etype_social_search_content() {

  $output = '
  <ul class="social-links">';
  $facebook = variable_get('etype_facebook_url');
  $twitter = variable_get('etype_twitter_url');
  $googleplus = variable_get('etype_pinterest_url');
  $instagram = variable_get('etype_pinterest_url');
  if (!empty($facebook)) {
    $output .= '<li><a class="facebook" href="' . $facebook . '"></a></li>';
  }
  if (!empty($twitter)) {
    $output .= '<li><a class="twitter" href="https://twitter.com/' . $twitter . '"></a></li>';
  }
  if (!empty($pinterest)) {
    $output .= '<li><a class="pinterest" href="https://www.pinterest.com/' . $pinterest . '"></a></li>';
  }
  if (!empty($instagram)) {
    $output .= '<li><a class="instagram" href="https://instagram.com/' . $instagram . '"></a></li>';
  }
  if (!empty($googleplus)) {
    $output .= '<li><a class="googleplus" href="https://plus.google.com/' . $googleplus . '"></a></li>';
  }
  if (!empty($rssfeed)) {
    $output .= '<li><a class="rss" href="/rss.xml"></a></li>';
  }
  $output .= '</ul>';
  return $output;
  return $output;
}