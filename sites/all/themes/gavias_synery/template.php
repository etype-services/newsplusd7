<?php
/**
 * @file
 * controls load theme.
 */
// Split funtions and stuff into seperate files for eaiser house keeping.
$theme_path = drupal_get_path('theme', 'gavias_synery');
global $theme_root, $parent_root;
$theme_root = base_path() . path_to_theme();
$parent_root = base_path() . drupal_get_path('theme', 'gavias_synery');
include_once $theme_path . '/includes/template.functions.php';
include_once $theme_path . '/includes/functions.php';
include_once $theme_path . '/includes/dynamic_style.php';

/**
 * Assign theme hook suggestions for custom templates and pass color theme
 * setting
 */
function gavias_synery_preprocess_page(&$vars, $hook)
{
    if (isset($vars['node'])) {
        $suggest = "page__node__{$vars['node']->type}";
        $vars['theme_hook_suggestions'][] = $suggest;
    }

    if (arg(0) == 'taxonomy' && arg(1) == 'term') {
        $term = taxonomy_term_load(arg(2));
        $vars['theme_hook_suggestions'][] = 'page--taxonomy--vocabulary--' . $term->vid;
    }
    $alias = drupal_get_path_alias($_GET['q']);
    if ($alias != $_GET['q']) {
        $vars['theme_hook_suggestions'][] = 'page__' . str_replace('-', '_', $alias);
    }
}

/**
 * Override or insert variables into the html template.
 *
 * @param $vars
 *   An array of variables to pass to the theme template.
 */
function gavias_synery_preprocess_html(&$vars)
{

    /* add site-specific css */
    $base_path = base_path();
    $conf_path = conf_path();
    $site_css = $base_path . $conf_path . '/site.css';
    $site_js = $base_path . $conf_path . '/site.js';

    if (file_exists($_SERVER['DOCUMENT_ROOT'] . $site_css)) {
        drupal_add_css(
            $site_css,
            array(
                'media' => 'all',
                'preprocess' => FALSE,
                'every_page' => TRUE,
                'weight' => 9999,
                'group' => CSS_THEME
            )
        );
    }

    if (file_exists($_SERVER['DOCUMENT_ROOT'] . $site_js)) {
        drupal_add_js($_SERVER['DOCUMENT_ROOT'] . $site_js);
    }

    global $parent_root;
    $skin = theme_get_setting('theme_skin');
    if (theme_get_setting('rtl') == 1) {
        drupal_add_css(drupal_get_path('theme', 'gavias_synery') . '/css/' . ($skin ? ('skins/' . $skin . '/') : '') . 'template.css', [
            'group' => CSS_DEFAULT,
            'type' => 'file',
        ]);
        drupal_add_css(drupal_get_path('theme', 'gavias_synery') . '/css/' . ($skin ? ('skins/' . $skin . '/') : '') . 'bootstrap-rtl.css', [
            'group' => CSS_DEFAULT,
            'type' => 'file',
        ]);
        $vars['language']->dir = 'rtl';
        $vars['classes_array'][] = 'rtl';
    } else {
        drupal_add_css(drupal_get_path('theme', 'gavias_synery') . '/css/' . ($skin ? ('skins/' . $skin . '/') : '') . 'template.css', [
            'group' => CSS_DEFAULT,
            'type' => 'file',
        ]);
        drupal_add_css(drupal_get_path('theme', 'gavias_synery') . '/css/' . ($skin ? ('skins/' . $skin . '/') : '') . 'bootstrap.css', [
            'group' => CSS_DEFAULT,
            'type' => 'file',
        ]);
    }

    $viewport = [
        '#type' => 'html_tag',
        '#tag' => 'meta',
        '#attributes' => [
            'name' => 'viewport',
            'content' => 'width=device-width, initial-scale=1, maximum-scale=1',
        ],
        '#weight' => 1,
    ];

    $background_image = [
        '#type' => 'markup',
        '#markup' => "<style type='text/css'>body {background-image:url(" . $parent_root . "/images/patterns/" . theme_get_setting('background_select') . ".png);}</style> ",
        '#weight' => 2,
    ];

    $background_color = [
        '#type' => 'markup',
        '#markup' => "<style type='text/css'>body {background-color: #" . theme_get_setting('body_background_color') . " !important;}</style> ",
        '#weight' => 3,
    ];

    drupal_add_html_head($viewport, 'viewport');

    if (theme_get_setting('site_layout') == "boxed") {
        drupal_add_html_head($background_image, 'background_image');
    }

    if (theme_get_setting('body_background') == "custom_background_color") {
        drupal_add_html_head($background_color, 'background_color');
    }
    // Add boxed class if layout is set that way.
    if (theme_get_setting('site_layout') == 'boxed') {
        $vars['classes_array'][] = 'boxed';
    }
    // add theme identifier
    $vars['classes_array'][] = 'synergy';

    /* Google Analytics code */
    $etype_google_analytics_property_id = variable_get('etype_google_analytics_property_id');
    if (!empty($etype_google_analytics_property_id)) {
        drupal_add_js('
(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,\'script\',\'//www.google-analytics.com/analytics.js\',\'ga\');
ga(\'create\', \'' . $etype_google_analytics_property_id . '\', \'auto\');
ga(\'send\', \'pageview\');
    ', [
                'type' => 'inline',
                'scope' => 'header',
                'weight' => 108,
            ]
        );
    }

    /**
     * Add Javascript - Enable/disable Bootstrap 3 Javascript.
     * This was a test
     */
    // drupal_add_js(drupal_get_path('theme', 'gavias_synery') . '/js/bootstrap.min.js');
}

/**
 * @param $vars
 */
function gavias_synery_process_html(&$vars)
{
    $vars['head_scripts'] = drupal_get_js('head_scripts');
}

/**
 * @param $vars
 */
function gavias_synery_process_node(&$vars)
{
    if ($vars['type'] == 'article') {
        /* author info */
        $node = node_load('node', $vars['nid']);
        // dpm($vars);
        $wrapper = entity_metadata_wrapper('node', $node);
        $vars['dateline'] = $wrapper->field_dateline->value();
        if ($vars['teaser'] === FALSE) {
            $byline = $wrapper->field_byline->value();
            if (!empty($byline)) {
                $email = $wrapper->field_email->value();
                if (!empty($email)) {
                    $vars['byline'] = '<a href="mailto:' . $email . '">' . $byline . '</a>';
                } else {
                    $vars['byline'] = $byline;
                }
            } else {
                $vars['byline'] = $vars['name'];
            }
        }
    }
}

/**
 * Implements hook_preprocess_region().
 */
function gavias_synery_preprocess_region(&$variables)
{
    global $theme;
    static $wells;
    if (!isset($wells)) {
        foreach (system_region_list($theme) as $name => $title) {
            $wells[$name] = theme_get_setting('gavias_synery_region_well-' . $name);
        }
    }
    switch ($variables['region']) {
        case 'content':
            $variables['theme_hook_suggestions'][] = 'region__no_wrapper';
            break;
        case 'help':
            $variables['content'] = _gavias_synery_icon('question-sign') . $variables['content'];
            $variables['classes_array'][] = 'alert';
            $variables['classes_array'][] = 'alert-info';
            break;
    }
    if (!empty($wells[$variables['region']])) {
        $variables['classes_array'][] = $wells[$variables['region']];
    }
}

/**
 *  Implements theme_css_alter().
 */
function gavias_synery_css_alter(&$css)
{
    if (theme_get_setting('rtl') == 1) {
        unset($css[drupal_get_path('theme', 'gavias_synery') . '/css/bootstrap.css']);
    }
}

function gavias_synery_preprocess_search_results(&$variables) {
    $e_edition = variable_get('etype_e_edition');
    $site_name = variable_get('site_name');
    $variables['extra_content'] = '';
    if ($site_name == 'Lampasas Dispatch Record') {
        $variables['extra_content'] = "<p>If you are a subscriber, <a href=\"/content/custom-login-page\">please log in to search the PDF archives</a>.</p>
        <p>If you are not yet a subscriber, <a href=\"https://etypeservices.com/$e_edition\">become one today!</a></p>";
    }
}
