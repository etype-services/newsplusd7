<?php
/**
 * @file
 * Gavias's theme implementation to display a single Drupal page.
 */
?>
<div class="body">
   
   <?php require(drupal_get_path('theme', 'gavias_synery') . '/template/page/header.tpl.php'); ?>

	<div role="main" class="main main-page">
		<?php if ($title && $breadcrumb && !drupal_is_front_page()): ?>
			<section class="page-top breadcrumb-wrap">
				<div class="container">
					<?php //if (theme_get_setting('breadcrumbs') == '1'): ?>
						<div class="row">
							<div class="col-md-12">
								<div id="breadcrumbs"><?php print $breadcrumb; ?> </div>
							</div>
						</div>
					<?php //endif; ?>
				</div>
			</section>
		<?php endif; ?>

		<?php if ($page['promotion']) { ?>
			<div class="promotion area">
				<div class="container">
					<div class="area-inner">
						<div class="">
							<?php if ($page['promotion']) { ?>
								<div class="promotion-one <?php print ($page['promotion_second'] ? 'col-md-6' : 'col-xs-12') ?>">
									<?php print render($page['promotion']); ?>	
								</div>
							<?php } ?>

							<?php if ($page['promotion_second']) { ?>
								<div class="promotion-second no-padding <?php print ($page['promotion'] ? 'col-md-6' : 'col-xs-12') ?>">
									<?php print render($page['promotion_second']); ?>	
								</div>
							<?php } ?>
						</div>
					</div>	
				</div>	
			</div>
		<?php } ?>

		<?php if ($page['before_content']) { ?>
			<div class="before_content area">
				<?php print render($page['before_content']); ?>
			</div>
		<?php } ?>

		<div id="content" class="content content-full">
			<div class="container">
				<div class="content-main-inner">
					<div class="row">
						<?php if(isset($messages) && $messages){ ?>
							<div class="col-xs-12">
								<?php print $messages; ?>
							</div>	
						<?php } ?>

						<div id="page-main-content" class="main-content <?php if (($page['sidebar_right']) AND ($page['sidebar_left'])) {
								echo "col-xs-12 col-md-6 col-md-push-3 sb-r sb-l";
						} elseif (($page['sidebar_right']) OR ($page['sidebar_left'])) {
								if($page['sidebar_right']) echo "col-xs-12 col-md-9 sb-r";
								if($page['sidebar_left']) echo "col-xs-12 col-md-9 col-md-push-3 sb-l";
						} else {
								echo "col-md-12";
						} ?>">

							<div class="main-content-inner">
								<?php if ($tabs = render($tabs)): ?>
										<div id="drupal_tabs" class="tabs ">
												<?php print render($tabs); ?>
										</div>
								<?php endif; ?>
								<?php print render($page['help']); ?>
								<?php if ($action_links): ?>
										<ul class="action-links">
												<?php print render($action_links); ?>
										</ul>
								<?php endif; ?>

								<?php if ($page['content_top']) { ?>
									<div class="content-top">
										<?php print render($page['content_top']); ?>
									</div>	
								<?php } ?>

								<?php if ($page['content']) { ?>
									<div class="content-main">
										<?php print render($page['content']); ?>
									</div>	
								<?php } ?>

								<?php if ($page['content_bottom']) { ?>
									<div class="content-bottom">
										<?php print render($page['content_bottom']); ?>		
									</div>	
								<?php } ?>
							</div>
						</div>	

						<?php if (($page['sidebar_left'])) : ?>
							<div class="col-md-3 col-md-pull-6 col-sm-12 col-xs-12">
								<aside id="sidebar-left" class="sidebar sidebar-left">
									<div class="sidebar-inner">
										<?php print render($page['sidebar_left']); ?>
									</div>	
								</aside>
							</div>
						<?php endif; ?>

						<?php if (($page['sidebar_right'])) : ?>
							<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
								<aside id="sidebar-right" class="sidebar sidebar-right">
									<div class="sidebar-inner">
										<?php print render($page['sidebar_right']); ?>
									</div>	
								</aside>
							</div>
						<?php endif; ?>
					</div>	
				</div>
			</div>
		</div>

		<?php if ($page['highlighted']) { ?>
			<div class="container">
				<div class="highlighted area">
					<?php print render($page['highlighted']); ?>
				</div>
			</div>	
		<?php } ?>

		<?php if ($page['after_content']) { ?>
			<div class="after_content">
				<div class="container">
					<?php print render($page['after_content']); ?>
				</div>	
			</div>
		<?php } ?>
	</div>
	<?php require(drupal_get_path('theme', 'gavias_synery') . '/template/page/footer.tpl.php'); ?>

</div>   