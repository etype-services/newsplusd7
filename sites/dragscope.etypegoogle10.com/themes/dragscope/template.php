<?php

/**
* @param $variables
* Preprocess variables for page template.
*/
function newsplus_preprocess_page(&$variables) {
  $variables['header_top_inside_left_grid_class'] = 'col-md-4';
  $variables['header_top_inside_right_grid_class'] = 'col-md-8';
}