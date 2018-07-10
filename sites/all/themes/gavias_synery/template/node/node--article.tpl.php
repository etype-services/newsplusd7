<?php
$uid = user_load($node->uid);
if (module_exists('profile2')) {
    $profile = profile2_load_by_user($uid, 'main');
}
global $parent_root;
$post_format = "none";
if (isset(field_get_items('node', $node, 'field_post_format')[0]['value']) && field_get_items('node', $node, 'field_post_format')[0]['value']) {
    $post_format = field_get_items('node', $node, 'field_post_format')[0]['value'];
}
?>

<?php if ($teaser): ?>

    <article id="node-<?php print $node->nid; ?>"
             class="node-teaser-display post-format-<?php echo $post_format ?> <?php print $classes; ?> post post-medium-image"<?php print $attributes; ?>>
        <div class="post-block">
            <div class="row">
                <div class="col-xs-6">
                    <?php if ($post_format == 'gallery') { ?>
                        <?php if (render($content['field_post_gallery'])) { ?>
                            <div class="post-image post-gallery">
                                <div class="carousel-gallery">
                                    <?php if (render($content['field_post_gallery'])) : ?>
                                        <?php print render($content['field_post_gallery']); ?>
                                    <?php endif; ?>
                                </div>
                            </div>
                        <?php } else {
                            print render($content['field_image']);
                        } ?>
                    <?php } elseif ($post_format == 'video' || $post_format == 'audio') { ?>
                        <?php if (render($content['field_post_embed'])) { ?>
                            <div class="video-media video-responsive">
                                <?php
                                gavias_synery_include('gavias_synery', 'includes/oembed.php');
                                $autoembed = new AutoEmbed();
                                if ($embed = field_get_items('node', $node, 'field_post_embed')[0]['value']) {
                                    print ($autoembed->parse($embed));
                                }
                                ?>
                            </div>
                        <?php } else {
                            print render($content['field_image']);
                        } ?>
                    <?php } else {
                        print render($content['field_image']);
                    }
                    ?>
                </div>
                <div class="col-xs-6">
                    <div class="post-content">
                        <div class="post-meta-wrap">
                            <div class="post-title">
                                <?php print render($title_prefix); ?>
                                <h3 <?php print $title_attributes; ?>><a
                                            href="<?php print $node_url; ?>"><?php print $title; ?></a>
                                </h3>
                                <?php print render($title_suffix); ?>
                            </div>
                            <?php if (!$page && $teaser): ?>
                                <div class="post-meta">
                                    <span class="post-date-blog"><?php print format_date($dateline, 'custom', 'M d, Y'); ?></span>
                                    <?php if (module_exists('comment')): ?>
                                        <span> / </span>
                                        <span class="post-meta-comments"> <a
                                                    href="<?php print $node_url; ?>/#comments"><?php print $comment_count; ?><?php print t('Comment'); ?><?php if ($comment_count != "1") {
                                                    echo "s";
                                                } ?></a></span>
                                    <?php endif; ?>
                                </div>
                            <?php endif; ?>
                        </div>
                        <div class="post-content-inner"<?php print $content_attributes; ?>>
                            <?php
                            // Hide comments, tags, and links now so that we can render them later.
                            hide($content['taxonomy_forums']);
                            hide($content['comments']);
                            hide($content['links']);
                            hide($content['field_tags']);
                            hide($content['field_image']);
                            hide($content['field_post_gallery']);
                            hide($content['field_post_embed']);
                            hide($content['field_post_format']);
                            print render($content);
                            ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </article>

<?php endif; ?>

<?php if (!$teaser): //Display node blog single ?>

    <article id="node-<?php print $node->nid; ?>"
             class="<?php print $classes; ?> post post-large blog-single-post"<?php print $attributes; ?>>

        <div class="content-first">
            <?php if ($display_submitted): ?>
                <div class="post-date">
                    <span class="day"><?php print format_date($dateline, 'custom', 'd'); ?></span>
                    <span class="month"><?php print t(format_date($dateline, 'custom', 'M')); ?></span>
                </div>
            <?php endif; ?>
            <div class="post-title">
                <?php print render($title_prefix); ?>
                <h1 <?php print $title_attributes; ?>><a
                            href="<?php print $node_url; ?>"><?php print $title; ?></a>
                </h1>
                <?php print render($title_suffix); ?>
            </div>

            <?php if ($display_submitted): ?>

                <div class="post-meta">
                    <?php if (module_exists('comment')): ?>
                        <span class="post-meta-comments"><i
                                    class="icon icon-comments"></i> <a
                                    href="<?php print $node_url; ?>/#comments"><?php print $comment_count; ?><?php print t('Comment'); ?><?php if ($comment_count != "1") {
                                    echo "s";
                                } ?></a></span>
                    <?php endif; ?>
                </div>
                <div class="clearfix"></div>
            <?php endif; ?>
        </div>

        <div class="clearfix"></div>
        <div class="post-content">
            <div class="article_content"<?php print $content_attributes; ?>>
                <?php
                // Hide comments, tags, and links now so that we can render them later.
                hide($content['taxonomy_forums']);
                hide($content['comments']);
                hide($content['links']);
                hide($content['field_tags']);
                print render($content);
                ?>
            </div>


            <!-- AddThis Smart Layers BEGIN -->
            <!-- Go to http://www.addthis.com/get/smart-layers to customize -->
            <?php $js_url = '//s7.addthis.com/js/300/addthis_widget.js';
            if (!empty($idAddthis)) {
                $js_url .= '#pubid=' . $idAddthis;
            }
            ?>
            <script type="text/javascript"
                    src="<?php echo $js_url; ?>"></script>
            <script type="text/javascript">
                addthis.layers({
                    'theme': 'Transparent',
                    'share': {
                        'position': 'left',
                        'services': 'facebook, twitter, gmail, google_plusone_share, email, pinterest, linkedin',
                        'desktop': true,
                        'mobile': true,
                        'theme': 'Transparent'
                    }
                });
            </script>
            <!-- AddThis Smart Layers BEGIN -->
            <!-- Go to http://www.addthis.com/get/smart-layers to customize -->

            <?php
            // Only display the wrapper div if there are links.
            $links = render($content['links']);
            if ($links):
                ?>
                <?php if (!$teaser): ?>
                <div class="link-wrapper">
                    <?php print $links; ?>
                </div>
            <?php endif; ?>
            <?php endif; ?>

            <?php if ((!$teaser) AND (module_exists('profile2'))): ?>

                <?php if (render($content['field_tags'])): ?>
                    <span class="post-meta-tag"><i
                                class="icon icon-tag"></i> <?php print render($content['field_tags']); ?> </span>
                <?php endif; ?>
                <?php if (render($content['field_term'])): ?>
                    <span class="post-meta-tag"><i
                                class="icon icon-tag"></i> <?php print render($content['field_term']); ?> </span>
                <?php endif; ?>

            <?php endif; ?>

            <?php
            // Remove the "Add new comment" link on the teaser page or if the comment
            // form is being displayed on the same page.
            if ($teaser || !empty($content['comments']['comment_form'])) {
                unset($content['links']['comment']['#links']['comment-add']);
            }
            print render($content['comments']); ?>

    </article>
    <!-- /node -->
<?php endif; ?>