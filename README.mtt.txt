News+ 5.1.1 README
======================

Thank you for downloading News+ - Standalone distribution.
This distribution includes a built-in Drupal installation profile,
a state-of-the-art theme and full-layered .psd source file(s),
so it's ready to run (almost) out the box.

Overview
--------

Specifically, your theme pack consists of the following four
directories:

    * [license]
      Includes the License information and references to
      third-party licenses.
    * [psd]
      Includes the full-layered psd file(s) this theme is
      based on.
    * [site]
      Includes a full core Drupal distribution
       * [d7] Drupal 7.x distribution with an installation profile.
       * [d8] Drupal 8.x site with the premium theme
    * [site/d8/_data]
      Includes the corresponding .sql file to use during Drupal 8 installation.

You can use the files to build a static web site or to create
your own theme for any platform, as long as this is permitted by
the License. You can dig into the source psd files and modify them
the way you want and reuse, as long as this is permitted by the
License. Lastly, you can use our installation profile to setup
your drupal.

Change Log
----------
Check:
Drupal 7.x: http://wiki.morethanthemes.com/index.php?title=newsplus
Drupal 8.x: http://support.morethanthemes.com/customer/portal/articles/2362420

Brief installation guide for a Drupal Site (Drupal 8.x)
-------------------------------------------------------

   1. Unzip the News+ Drupal theme package.
   2. Locate the [site]/[d8] directory and upload its content to your
      server. This directory includes Drupal core and all of the
      required modules that are used in the theme. If you wish to
      install the theme in your root directory (often called the
      "/public_html/" directory), simply place all the extracted
      files and folders into this directory. Place all files in a
      sub-directory, if you want the theme installed in a sub-directory
      of your website.
   3. (important) Create the MySQL database. Make a note of the complete
      database name. You will need your database username and password
      during the first couple of steps of your theme installation.
   4. Import the "[site]/[d8]/[_data]/db_instance.sql" file in your newply
      created MySQL database.
   5. Start the Drupal installation wizard by pointing your browser to the
      recently created folder, in your Apache server path.
   6. Continue the installation by selecting the "Standard" installation profile.
   7. Enter your recently created database information. This includes the database name
      and credentials (username/password) you have chosen when creating it.
   8. The installation wizard will recognise that you are using an already populated
      database and will inform you accordingly. At the same time, the wizard should
      create all the necessary files your Drupal site needs in order to work properly on
      your server.
   9. You are done. Click on the "visit existing site" link, to visit your new site.

Once you are done with the above, please login to this site by using the following
credentials:
   u: admin​
   p: password​


Brief installation guide for a Drupal Site (Drupal 7.x)
-------------------------------------------------------

If you are unfamiliar with Drupal installation please take a break
and read Drupal's INSTALL.txt. The file is located into the [site] folder.

   1. Unzip the News+ Drupal theme package.
   2. Locate the [site]/[d7] directory and upload its content to your
      server. This directory includes Drupal core and all of the
      required modules that are used in the theme. If you wish to
      install the theme in your root directory (often called the
      "/public_html/" directory), simply place all the extracted
      files and folders into this directory. Place all files in a
      sub-directory, if you want the theme installed in a sub-directory
      of your website.
   3. (important) Create the MySQL database. Make a note of the complete
      database name. You will need your database username and password
      during the first couple of steps of your theme installation.
   4. Once all the files have been uploaded, browse to the website
      address where you have uploaded the files. Next select
      News+ 7.x Installer
   5. On the next  page you will see a message asking you to copy
      default.settings.php to settings.php. Locate the /sites/default
      folder and create there the settings.php file as a copy of
      default.setting.php which also is located there.
      (This step may not be required depending on your hosting environment.)
   6. In the next step you will be asked for the Database name, user and password.
      You can also give some information about your Drupal installation as the
      site name or title, admin name, admin email address and so on.
   7. Finally, follow the next steps to complete the installation process.


Full documentation is available online at:
http://support.morethanthemes.com

Problems
--------
If you experience any problems with one of our themes, please see the
resources listed at:
http://support.morethanthemes.com

Questions
---------
Questions? Try the docs at:
http://support.morethanthemes.com

Alternatively, contact MorethanThemes directly. See the contact info at:
http://support.morethanthemes.com

User Guide
----------
How to use your all-new-theme? Try the docs at:
http://support.morethanthemes.com


Happy theming and thank you for using a MorethanThemes product!

The MorethanThemes Team
