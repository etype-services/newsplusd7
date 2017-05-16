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
<div class="navigation-social-bookmarks">
    <ul class="social-bookmarks">';

  $facebook = variable_get('etype_facebook_top');
  $twitter = variable_get('etype_twitter_top');
  $googleplus = variable_get('etype_pinterest_top');
  $instagram = variable_get('etype_pinterest_top');

  if ($facebook > 0) {
    $url = variable_get('etype_facebook_url');
    $output .= '<li><a href="' . $url . '"><i class="fa fa-facebook"></i></a></li>';
  }

  if ($twitter > 0) {
    $url = variable_get('etype_twitter_url');
    $output .= '<li><a href="' . $url . '"><i class="fa fa-twitter"></i></a></li>';
  }

  if ($googleplus > 0) {
    $url = variable_get('etype_googleplus_url');
    $output .= '<li><a href="' . $url . '"><i class="fa fa-google-plus"></i></a></li>';
  }

  if ($instagram > 0) {
    $url = variable_get('etype_instagram_url');
    $output .= '<li><a href="' . $url . '"><i class="fa fa-instagram"></i></a></li>';
  }

  $output .= '
</ul>';

  if (module_exists('search')) {
    $output .= '
    <div class="dropdown search-bar block-search">
    <a data-toggle="dropdown" href="#" class="trigger"></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
    <li>';
    $block = module_invoke('search', 'block_view', 'search');
    $output .= render($block);
    $output .= '</li></ul></div>';
  }
  $output .= '</div>';

  return $output;

}