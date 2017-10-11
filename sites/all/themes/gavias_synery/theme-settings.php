<?php
/**
 * @file
 * Theme setting callbacks for the gavias_synery theme.
 */

/**
 * Implements hook_form_system_theme_settings_alter()
 */
function gavias_synery_form_system_theme_settings_alter(&$form, &$form_state) {
  
  // Main settings wrapper
  $form['options'] = array(
    '#type' => 'vertical_tabs',
    '#default_tab' => 'defaults',
    '#weight' => '-10',
    '#attached' => array(
      'css' => array(drupal_get_path('theme', 'gavias_synery') . '/css/theme-settings.css'),
    ),
  );
  
  // Default Drupal Settings    
  $form['options']['drupal_default_settings'] = array(
    '#type' => 'fieldset',
    '#title' => t('Drupal Core Settings'),
  );
  
    // "Toggle Display" 
    $form['options']['drupal_default_settings']['theme_settings'] = $form['theme_settings'];
    
    // "Unset default Toggle Display settings" 
    unset($form['theme_settings']);
    
    // "Logo Image Settings" 
    $form['options']['drupal_default_settings']['logo'] = $form['logo'];
    
    // "Unset default Logo Image Settings" 
    unset($form['logo']);
    
    // "Shortcut Icon Settings" 
    $form['options']['drupal_default_settings']['favicon'] = $form['favicon'];   
    
    // "Unset default Shortcut Icon Settings" 
    unset($form['favicon']);
  
  // General
  $form['options']['general'] = array(
    '#type' => 'fieldset',
    '#title' => t('General'),
  );
   
  $form['options']['general']['enable_skin_color'] =array(
    '#type' => 'select',
    '#title' => t('Enable Color Scheme'),
    '#default_value' => theme_get_setting('enable_skin_color'),
    '#options' => array(
      '0'        => t('Disable'),
      '1'        => t('Enable')
     ) 
  ); 
    
  // Custom Skin Color
  $form['options']['general']['skin_color'] =array(
    '#type' => 'jquery_colorpicker',
    '#title' => t('Color Scheme'),
    '#default_value' => theme_get_setting('skin_color'),
  ); 
    
  // Background Color
  $form['options']['general']['theme_skin'] = array(
    '#type' => 'select',
    '#title' => t('Theme Skin'),
    '#default_value' => theme_get_setting('theme_skin'),
    '#options' => array(
      ''        => t('Default'),
      'green'   => t('Green'),
      'lilac'   => t('Lilac'),
      'orange'  => t('Orange'),
      'red'     => t('Red'),
      'yellow'  => t('Yellow'),
    ),
  );
    $form['options']['general']['rtl'] =array(
    '#type' => 'select',
    '#title' => t('Enable Right to left'),
    '#default_value' => theme_get_setting('rtl'),
    '#options' => array(
      '0'        => t('Disable'),
      '1'        => t('Enable')
     ) 
  ); 
  // Site Layout
  $form['options']['layout']['site_layout'] = array(
    '#type' => 'select',
    '#title' => t('Body Layout'),
    '#default_value' => theme_get_setting('site_layout'),
    '#options' => array(
      'wide' => t('Wide (default)'),
      'boxed' => t('Boxed'),
    ),
  );
    
  //Background
  $form['options']['layout']['background'] = array(
    '#type' => 'fieldset',
    '#title' => '<h3 class="options_heading">Background</h3>',
    '#states' => array (
        'visible' => array(
          'select[name=site_layout]' => array('value' => 'boxed')
        )
      )
  );
    
  // Body Background 
  $form['options']['layout']['background']['body_background'] = array(
    '#type' => 'select',
    '#title' => t('Body Background'),
    '#default_value' => theme_get_setting('body_background'),
    '#options' => array(
      'gavias_backgrounds' => t('Background Image (default)'),
      'custom_background_color' => t('Background Color'),
    ),
  );
    
  // Gavias Background Choices
  $form['options']['layout']['background']['background_select'] = array(
    '#type' => 'radios',
    '#title' => t('Select a background pattern:'),
    '#default_value' => theme_get_setting('background_select'),
    '#options' => array(
      'az_subtle' => 'item',
      'blizzard' => 'item',
      'bright_squares' => 'item',
      'denim' => 'item',
      'fancy_deboss' => 'item',
      'gray_jean' => 'item',
      'honey_im_subtle' => 'item',
      'linen' => 'item',
      'pw_maze_white' => 'item',
      'random_grey_variations' => 'item',
      'skin_side_up' => 'item',
      'stitched_wool' => 'item',
      'straws' => 'item',
      'subtle_grunge' => 'item',
      'textured_stripes' => 'item',
      'wild_oliva' => 'item',
      'worn_dots' => 'item',
    ),
    '#states' => array (
        'visible' => array(
          'select[name=body_background]' => array('value' => 'gavias_backgrounds')
        )
      )
    );  
    
  // Custom Background Color
  $form['options']['layout']['background']['body_background_color'] =array(
    '#type' => 'jquery_colorpicker',
    '#title' => t('Body Background Color'),
    '#default_value' => theme_get_setting('body_background_color'),
    '#states' => array (
      'visible' => array(
        'select[name=body_background]' => array('value' => 'custom_background_color')
      )
    )
  );   
      
  // CSS
  $form['options']['css'] = array(
    '#type' => 'fieldset',
    '#title' => t('CSS'),
  );
  
  // User CSS
  $form['options']['css']['user_css'] = array(
    '#type' => 'textarea',
    '#title' => t('Add your own CSS'),
    '#default_value' => theme_get_setting('user_css'),
  ); 
            
}
