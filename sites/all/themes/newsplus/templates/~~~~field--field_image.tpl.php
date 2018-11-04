<?php if (!$label_hidden) : ?>
    <div class="field-label"<?php print $title_attributes; ?>><?php print $label ?>:&nbsp;</div>
<?php endif; ?>

<?php
// Reduce number of images in teaser view mode to single image
if ($element['#view_mode'] == 'teaser') : ?>
    <div class="field-item field-type-image even clearfix"<?php print $item_attributes[0]; ?>><div class="overlayed-teaser"><?php print render($items[0]); ?></div></div>
    <?php return; endif; ?>

<?php $node=$element['#object']; $lang="und"; ?>
<?php
    // make sure preferred style is available
    $image_styles = image_style_options();
    if (isset($image_styles['article600'])) {
        $image_style = 'article600';
    } else {
        $image_style = 'large';
    }
?>
    <div class="images-container clearfix">

        <div class="image-preview clearfix">

            <div class="image-wrapper clearfix">
                <img src="<?php print image_style_url($image_style, $node->field_image[$lang][0]['uri']); ?>" alt="<?php print $node->field_image[$lang][0]['alt']; ?>" title="<?php print $node->field_image[$lang][0]['title']; ?>"/>
            </div>

            <?php if ($node->field_image[$lang][0]['title']) :?>
                <div class="image-caption clearfix">
                    <?php if ($node->field_image[$lang][0]['title']) :?>
                        <p><?php print $node->field_image[$lang][0]['title']; ?></p>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>
    </div>