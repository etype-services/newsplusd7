<div class="profile clearfix"<?php print $attributes; ?>>

	<?php 
	if (isset($user_profile['field_mt_facebook'])) { $facebook = $field_mt_facebook[0]['value']; }
	if (isset($user_profile['field_mt_twitter'])) { $twitter = $field_mt_twitter[0]['value']; }
	if (isset($user_profile['field_mt_google_plus'])) { $googleplus = $field_mt_google_plus[0]['value']; }
	?>

	<?php if ($photo = render($user_profile['user_picture'])) { ?>
		<div class="with-user-image">
			<div class="photo-wrapper">
				<?php print render($photo); ?>

				<?php if (render($user_profile['field_mt_facebook']) || render($user_profile['field_mt_twitter']) || render($user_profile['field_mt_google_plus'])) { ?>
				<ul class="user-social-bookmarks">
					<?php if (render($user_profile['field_mt_facebook'])) { ?><li class="facebook"><a target="_blank" href="<?php print $facebook;?>"><i class="fa fa-facebook"></i></a></li><?php } ?>
					<?php if (render($user_profile['field_mt_twitter'])) { ?><li class="twitter"><a target="_blank" href="<?php print render($twitter);?>"><i class="fa fa-twitter"></i></a></li><?php } ?>
					<?php if (render($user_profile['field_mt_google_plus'])) { ?><li class="googleplus"><a target="_blank" href="<?php print render($googleplus);?>"><i class="fa fa-google-plus"></i></a></li><?php } ?>
				</ul>
				<?php } ?>
			</div>

			<?php print render($user_profile); ?>
		</div>
	<?php } else { ?>
		<?php 
			hide($user_profile['field_mt_facebook']);
			hide($user_profile['field_mt_twitter']);
			hide($user_profile['field_mt_google_plus']);
			print render($user_profile);
		?>
		<?php if (render($user_profile['field_mt_facebook']) || render($user_profile['field_mt_twitter']) || render($user_profile['field_mt_google_plus'])) { ?>
			<ul class="user-social-bookmarks">
				<?php if (render($user_profile['field_mt_facebook'])) { ?><li class="facebook"><a target="_blank" href="<?php print $facebook;?>"><i class="fa fa-facebook"></i></a></li><?php } ?>
				<?php if (render($user_profile['field_mt_twitter'])) { ?><li class="twitter"><a target="_blank" href="<?php print render($twitter);?>"><i class="fa fa-twitter"></i></a></li><?php } ?>
				<?php if (render($user_profile['field_mt_google_plus'])) { ?><li class="googleplus"><a target="_blank" href="<?php print render($googleplus);?>"><i class="fa fa-google-plus"></i></a></li><?php } ?>
			</ul>
		<?php } ?>
	<?php } ?>

</div>
