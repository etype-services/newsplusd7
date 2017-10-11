<footer id="footer" class="footer">
   
   <?php if ($page['before_footer']) { ?>
   <div class="footer-top">
      <div class="container">
         <div class="row">
            <div class="col-xs-12">
               <div class="before_footer area">
                  <?php print render($page['before_footer']); ?>
               </div>
            </div>
      </div>     
   </div>    
   <?php } ?>
   
   <div class="footer-center">
      <div class="container">      
         <div class="row">
            <?php 
               $footer_count = 0;
               foreach (array('first', 'second', 'third', 'four') as  $value) {
                  if(isset($page['footer_' . $value]) && $page['footer_' . $value]){
                     $footer_count ++;
                  }
               }
              $col_class = '';
               switch( $footer_count ){
                  case 2: $col_class = 'footer-2col col-lg-6 col-md-6 col-md-6 col-xs-12'; break;
                  case 3: $col_class = 'footer-3col col-lg-4 col-md-4 col-md-1 col-xs-12'; break;
                  case 4: $col_class = 'footer-4col col-lg-3 col-md-3 col-md-6 col-xs-12'; break;
                  default: $col_class = 'footer-full col-xs-12';break;
               }

               foreach (array('first', 'second', 'third', 'four') as  $value) {
                  if(isset($page['footer_' . $value]) && $page['footer_' . $value]){
                     echo '<div class="'. $col_class .' column">';
                        print render($page['footer_' . $value]);
                     echo '</div>';
                  }
               }
            ?>
         </div>   
      </div>
   </div>   
   <div class="copyright">
      <div class="container">
         <div class="copyright-inner">
            <?php if($page['copyright']){
               print render($page['copyright']);
            } ?>
         </div>   
      </div>   
   </div>
     
</footer>