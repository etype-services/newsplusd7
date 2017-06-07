# Composer Autoload

Caches a list of [Composer](https://getcomposer.org/)-built autoload.php files and automatically includes them during hook_init().

## Usage

1. Install the Composer Autoload module

2. Set any customized path to your own autoload.php file in admin/config/development/composer_autoload .
  - Alternatively use something like the following in settings.php:
    ``` php
    $conf['composer_autoload_path'] = 'vendor/autoload.php';
    ```

3. Now any found autoload.php files will be loaded on each page request
