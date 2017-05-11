<?php

/**
 * @file
 * flippy.tpl.php
 *
 * Theme implementation to display a simple pager.
 *
 * Default variables:
 * - $links: An array of links to render, keyed by their class. The array
 *   contains 'title' and 'href'.
 * 
 * Other variables:
 * - $current['nid']: The Node ID of the current node.
 * - $first['nid']: The Node ID of the first node.
 * - $prev['nid']: The Node ID of the previous node.
 * - $next['nid']: The Node ID of the next node.
 * - $last['nid']: The Node ID of the last node.
 *
 * - $current['title']: The Node title of the current node.
 * - $first['title']: The Node title of the first node.
 * - $prev['title']: The Node title of the previous node.
 * - $next['title']: The Node title of the next node.
 * - $last['title']: The Node title of the last node.
 * 
 * - $show_empty: TRUE if links without hrefs should be rendered.
 *
 * @see template_preprocess_flippy()
 */
?>
<?php
$current_node = node_load($current['nid']);
?>
<?php if ($current_node->type == 'mt_post'): ?>
  <div class="node-navigation clearfix">
    <div class="col-xs-6">
      <?php if ($links['prev']['href']): ?>
        <div class="prev-node">
          <div class="text">Prev article</div>
            <?php print l($links['prev']['title'], $links['prev']['href'], array('html' => TRUE, 'attributes' => array('title' => $links['prev']['title']))); ?>
        </div>
        <i class="fa fa-angle-left"></i>
      <?php endif; ?>
    </div>
    <div class="col-xs-6">
      <?php if ($links['next']['href']): ?>
        <div class="next-node">
          <div class="text">Next article</div>
            <?php print l($links['next']['title'], $links['next']['href'], array('html' => TRUE, 'attributes' => array('title' => $links['next']['title']))); ?>
        </div>
        <i class="fa fa-angle-right"></i>
      <?php endif; ?>
    </div>
  </div>
<?php else: ?>
  <ul class="flippy">
    <?php foreach ($links as $key => $link): ?>
      <?php if (!$link['href'] && !$show_empty): ?>
        <?php continue; ?>
      <?php endif; ?>
      
      <li class="<?php print $key; ?><?php print !$link['href'] ? ' empty' : ''; ?>">
        <?php if (!$link['href']): ?>
          <?php print $link['title']; ?>
        <?php else: ?>
          <?php print l($link['title'], $link['href'], array('html' => TRUE, 'attributes' => array('title' => $link['title']))); ?>
        <?php endif; ?>
      </li>
    <?php endforeach; ?>
  </ul>
<?php endif; ?>