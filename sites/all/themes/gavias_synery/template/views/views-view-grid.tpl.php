<?php

/**
 * @file
 * Default simple view template to display a rows in a grid.
 *
 * - $rows contains a nested array of rows. Each row contains an array of
 *   columns.	  <h1><?php print count($column_classes[$column_number]); ?></h1>
 */
?>
<?php if (!empty($title)) : ?>
  <h2><?php print $title; ?></h2>
<?php endif; ?>
<div class="<?php print $class; ?>"<?php print $attributes; ?>>
	
	
<?php
	$cw = isset($rows[0])?count($rows[0]) : 3;
    $class = 'col-lg-4 col-md-4 col-sm-4 col-xs-12';
    switch ($cw) {
       case '1':
        $class = 'col-xs-12';
        break;
      case '2':
        $class = 'col-lg-6 col-md-6 col-sm-6 col-xs-12';
        break;
      case '3':
        $class = 'col-lg-4 col-md-4 col-sm-4 col-xs-12';
        break;
      case '4':
        $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12';
        break;
      case '6':
        $class = 'col-lg-2 col-md-2 col-sm-6 col-xs-12';
        break;  
      default:
        $class = 'col-lg-'. floor( 12/count($rows[0]) ) .' col-md-'.floor( 12/count($rows[0]) ).' col-sm-12 col-xs-12';
        break;
    }
?>	
	
  <?php foreach ($rows as $row_number => $columns): ?>
    <div class="views-row row <?php print $row_classes[$row_number]; ?> clearfix">
      <?php foreach ($columns as $column_number => $item): ?>
        <?php if (!empty($item)):?>	
          <div class="grid <?php echo $class; ?> <?php print $column_classes[$row_number][$column_number]; ?>">		
            <div class="grid-inner col-inner clearfix">
              <?php print $item; ?>
            </div>
          </div>
        <?php endif; ?>
      <?php endforeach; ?>
    </div>
  <?php endforeach; ?>
</div>
