<?php

/**
 * @file
 * Configuration file for Drupal's multi-site directory aliasing feature.
 *
 * This file allows you to define a set of aliases that map hostnames, ports, and
 * pathnames to configuration directories in the sites directory. These aliases
 * are loaded prior to scanning for directories, and they are exempt from the
 * normal discovery rules. See default.settings.php to view how Drupal discovers
 * the configuration directory when no alias is found.
 *
 * Aliases are useful on development servers, where the domain name may not be
 * the same as the domain of the live server. Since Drupal stores file paths in
 * the database (files, system table, etc.) this will ensure the paths are
 * correct when the site is deployed to a live server.
 *
 * To use this file, copy and rename it such that its path plus filename is
 * 'sites/sites.php'. If you don't need to use multi-site directory aliasing,
 * then you can safely ignore this file, and Drupal will ignore it too.
 *
 * Aliases are defined in an associative array named $sites. The array is
 * written in the format: '<port>.<domain>.<path>' => 'directory'. As an
 * example, to map http://www.drupal.org:8080/mysite/test to the configuration
 * directory sites/example.com, the array should be defined as:
 * @code
 * $sites = array(
 *   '8080.www.drupal.org.mysite.test' => 'example.com',
 * );
 * @endcode
 * The URL, http://www.drupal.org:8080/mysite/test/, could be a symbolic link or
 * an Apache Alias directive that points to the Drupal root containing
 * index.php. An alias could also be created for a subdomain. See the
 * @link http://drupal.org/documentation/install online Drupal installation guide @endlink
 * for more information on setting up domains, subdomains, and subdirectories.
 *
 * The following examples look for a site configuration in sites/example.com:
 * @code
 * URL: http://dev.drupal.org
 * $sites['dev.drupal.org'] = 'example.com';
 *
 * URL: http://localhost/example
 * $sites['localhost.example'] = 'example.com';
 *
 * URL: http://localhost:8080/example
 * $sites['8080.localhost.example'] = 'example.com';
 *
 * URL: http://www.drupal.org:8080/mysite/test/
 * $sites['8080.www.drupal.org.mysite.test'] = 'example.com';
 * @endcode
 *
 * @see default.settings.php
 * @see conf_path()
 * @see http://drupal.org/documentation/install/multi-site
 */

/* test, demo, and base sites */
$sites['www.etypegoogle10.com'] = 'demo.etypegoogle10.com';
$sites['demo.etypegoogle10.com'] = 'demo.etypegoogle10.com';
$sites['newsplus-base.etypegoogle10.com'] = 'newsplus-base.etypegoogle10.com';
$sites['synergy-base.etypegoogle10.com'] = 'synergy-base.etypegoogle10.com';

/* freemansd.etypegoogle10.com */
$sites['freemansd.etypegoogle10.com'] = 'freemansd.etypegoogle10.com';
$sites['www.freemansd.com'] = 'freemansd.etypegoogle10.com';

/* gunnisontimes.etypegoogle10.com */
$sites['gunnisontimes.etypegoogle10.com'] = 'gunnisontimes.etypegoogle10.com';
$sites['www.gunnisontimes.com'] = 'gunnisontimes.etypegoogle10.com';

/* thechronicle.etypegoogle10.com */
$sites['thechronicle.etypegoogle10.com'] = 'thechronicle.etypegoogle10.com';
$sites['www.thechronicle.news'] = 'thechronicle.etypegoogle10.com';

/* hartington.etypegoogle10.com */
$sites['hartington.etypegoogle10.com'] = 'hartington.etypegoogle10.com';
$sites['www.hartington.net'] = 'hartington.etypegoogle10.com';

/* lampasasdispatchrecord.etypegoogle10.com */
$sites['lampasasdispatchrecord.etypegoogle10.com'] = 'lampasasdispatchrecord.etypegoogle10.com';
$sites['www.lampasasdispatchrecord.com'] = 'lampasasdispatchrecord.etypegoogle10.com';

/* theexaminer.etypegoogle10.com */
$sites['theexaminer.etypegoogle10.com'] = 'theexaminer.etypegoogle10.com';
$sites['www.theexaminer.com'] = 'theexaminer.etypegoogle10.com';

/* beaumontbusinessjournal.etypegoogle10.com */
$sites['beaumontbusinessjournal.etypegoogle10.com'] = 'beaumontbusinessjournal.etypegoogle10.com';
$sites['www.beaumontbusinessjournal.com'] = 'beaumontbusinessjournal.etypegoogle10.com';

/* malakoffnews.etypegoogle10.com */
$sites['malakoffnews.etypegoogle10.com'] = 'malakoffnews.etypegoogle10.com';
$sites['www.malakoffnews.net'] = 'malakoffnews.etypegoogle10.com';

/* lakeoconeenews.etypegoogle10.com */
$sites['lakeoconeenews.etypegoogle10.com'] = 'lakeoconeenews.etypegoogle10.com';
$sites['www.lakeoconeenews.us'] = 'lakeoconeenews.etypegoogle10.com';