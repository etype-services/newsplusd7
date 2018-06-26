<div class="field-sponsor-ad-image-wrapper">
    <?php foreach ($field_sponsor_ad_image_items as $arr): ?>
        <div class="field-sponsor-ad-image">
            <a href="<?php print $arr['img_url'] ?>" target="_blank"><img src="<?php print $arr['img_src']; ?>" /></a>
        </div>
    <?php endforeach; ?>
</div>