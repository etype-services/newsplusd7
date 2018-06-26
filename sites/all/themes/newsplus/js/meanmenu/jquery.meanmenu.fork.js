/*!
 * jQuery meanMenu v2.0.6
 * @Copyright (C) 2012-2013 Chris Wharton (https://github.com/weare2ndfloor/meanMenu)
 *
 */
/*
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * THIS SOFTWARE AND DOCUMENTATION IS PROVIDED "AS IS," AND COPYRIGHT
 * HOLDERS MAKE NO REPRESENTATIONS OR WARRANTIES, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO, WARRANTIES OF MERCHANTABILITY OR
 * FITNESS FOR ANY PARTICULAR PURPOSE OR THAT THE USE OF THE SOFTWARE
 * OR DOCUMENTATION WILL NOT INFRINGE ANY THIRD PARTY PATENTS,
 * COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS.COPYRIGHT HOLDERS WILL NOT
 * BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL OR CONSEQUENTIAL
 * DAMAGES ARISING OUT OF ANY USE OF THE SOFTWARE OR DOCUMENTATION.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://gnu.org/licenses/>.
 *
 * Find more information at http://www.meanthemes.com/plugins/meanmenu/
 *
 */
(function ($) {
    "use strict";
    $.fn.meanmenu = function (options) {
        var defaults = {
            meanMenuTarget: $(this), // Target the current HTML markup you wish to replace
            meanMenuContainer: 'body', // Choose where meanmenu will be placed within the HTML
            meanMenuOpen: "<span /><span /><span />", // text/markup you want when menu is closed
            meanRevealPosition: "right", // left right or center positions
            meanRevealPositionDistance: "0", // Tweak the position of the menu
            meanRevealColour: "", // override CSS colours for the reveal background
            meanRevealHoverColour: "", // override CSS colours for the reveal hover
            meanScreenWidth: "480", // set the screen width you want meanmenu to kick in at
            meanNavPush: "", // set a height here in px, em or % if you want to budge your layout now the navigation is missing.
            meanShowChildren: true, // true to show children in the menu, false to hide them
            meanExpandableChildren: true, // true to allow expand/collapse children
            meanExpand: "+", // single character you want to represent the expand for ULs
            meanContract: "-", // single character you want to represent the contract for ULs
            meanRemoveAttrs: false, // true to remove classes and IDs, false to keep them
            onePage: false, // set to true for one page sites
            removeElements: "" // set to hide page elements
        };
        var options = $.extend(defaults, options);

        // get browser width
        var currentWidth = window.innerWidth || document.documentElement.clientWidth;

        return this.each(function () {
            var meanMenu = options.meanMenuTarget;
            var meanContainer = options.meanMenuContainer;
            var meanReveal = options.meanReveal;
            var meanMenuClose = options.meanMenuClose;
            var meanMenuCloseSize = options.meanMenuCloseSize;
            var meanMenuOpen = options.meanMenuOpen;
            var meanRevealPosition = options.meanRevealPosition;
            var meanRevealPositionDistance = options.meanRevealPositionDistance;
            var meanRevealColour = options.meanRevealColour;
            var meanRevealHoverColour = options.meanRevealHoverColour;
            var meanScreenWidth = options.meanScreenWidth;
            var meanNavPush = options.meanNavPush;
            var meanRevealClass = ".meanmenu-reveal";
            var meanShowChildren = options.meanShowChildren;
            var meanExpandableChildren = options.meanExpandableChildren;
            var meanExpand = options.meanExpand;
            var meanContract = options.meanContract;
            var meanRemoveAttrs = options.meanRemoveAttrs;
            var onePage = options.onePage;
            var removeElements = options.removeElements;

            //detect known mobile/tablet usage
            if ((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) || (navigator.userAgent.match(/iPad/i)) || (navigator.userAgent.match(/Android/i)) || (navigator.userAgent.match(/Blackberry/i)) || (navigator.userAgent.match(/Windows Phone/i))) {
                var isMobile = true;
            }

            if ((navigator.userAgent.match(/MSIE 8/i)) || (navigator.userAgent.match(/MSIE 7/i))) {
                // add scrollbar for IE7 & 8 to stop breaking resize function on small content sites
                $('html').css("overflow-y", "scroll");
            }

            function meanCentered() {
                if (meanRevealPosition === "center") {
                    var newWidth = window.innerWidth || document.documentElement.clientWidth;
                    var meanCenter = ((newWidth / 2) - 22) + "px";
                    meanRevealPos = "left:" + meanCenter + ";right:auto;";

                    if (!isMobile) {
                        $('.meanmenu-reveal').css("left", meanCenter);
                    } else {
                        $('.meanmenu-reveal').animate({
                            left: meanCenter
                        });
                    }
                }
            }

            var menuOn = false;
            var meanMenuExist = false;

            if (meanRevealPosition == "right") {
                meanRevealPos = "right:" + meanRevealPositionDistance + ";left:auto;";
            }
            if (meanRevealPosition == "left") {
                var meanRevealPos = "left:" + meanRevealPositionDistance + ";right:auto;";
            }
            // run center function  
            meanCentered();

            // set all styles for mean-reveal
            var meanStyles = "background:" + meanRevealColour + ";color:" + meanRevealColour + ";" + meanRevealPos;
            var $navreveal = "";

            //re-instate original nav (and call this on window.width functions)
            function meanOriginal() {
                $(meanContainer + ' .mean-bar, ' + meanContainer + ' .mean-push').remove();
                $(meanContainer).removeClass("mean-container");
                $("#superfish-1").css("display", "block");
                $(".menu-moved").remove();
                $(meanMenu).show();
                menuOn = false;
                meanMenuExist = false;
                $(removeElements).removeClass('mean-remove');
            }

            // navigation reveal
            // adjusted to add superfish 1 elements to superfish 2
            function showMeanMenu() {
                if (currentWidth <= meanScreenWidth) {
                    $("#superfish-1").css("display", "none");
                    $('#superfish-1 li').clone().appendTo($('#superfish-2')).addClass('menu-moved');
                    $(removeElements).addClass('mean-remove');
                    meanMenuExist = true;
                    // add class to body so we don't need to worry about media queries here, all CSS is wrapped in '.mean-container'
                    $(meanContainer).addClass("mean-container");
                    $(meanContainer).prepend('<div class="mean-bar"><a href="#nav" class="meanmenu-reveal" style="' + meanStyles + '">Show Navigation</a><nav class="mean-nav"></nav></div>');

                    // push meanMenu navigation into .mean-nav
                    var meanMenuContents = $(meanMenu).html();
                    $(meanContainer + ' .mean-nav').html(meanMenuContents);

                    // remove all classes from EVERYTHING inside meanmenu nav
                    if (meanRemoveAttrs) {
                        $(meanContainer + ' nav.mean-nav ul, ' + meanContainer + ' nav.mean-nav ul *').each(function () {
                            $(this).removeAttr("style");
                            $(this).removeAttr("class");
                            $(this).removeAttr("id");
                        });
                    }

                    // push in a holder div (this can be used if removal of nav is causing layout issues)
                    $(meanMenu).before('<div class="mean-push" />');
                    $(meanContainer + ' .mean-push').css("margin-top", meanNavPush);

                    // hide current navigation and reveal mean nav link
                    $(meanMenu).hide();
                    $(meanContainer + " .meanmenu-reveal").show();

                    // turn 'X' on or off 
                    $(meanContainer + ' ' + meanRevealClass).html(meanMenuOpen);
                    $navreveal = $(meanContainer + ' ' + meanRevealClass);

                    //hide mean-nav ul
                    $(meanContainer + ' .mean-nav ul').hide();

                    // hide sub nav
                    if (meanShowChildren) {
                        // allow expandable sub nav(s)
                        if (meanExpandableChildren) {
                            $(meanContainer + ' .mean-nav ul ul').each(function () {
                                if ($(this).children().length) {
                                    $(this, 'li:first').parent().append('<a class="mean-expand" href="#" style="font-size: ' + meanMenuCloseSize + '">' + meanExpand + '</a>');
                                }
                            });
                            $(meanContainer + ' .mean-expand').on("click", function (e) {
                                e.preventDefault();
                                if ($(this).hasClass("mean-clicked")) {
                                    $(this).text(meanExpand);
                                    $(this).prev('ul').slideUp(300, function () {
                                    });
                                } else {
                                    $(this).text(meanContract);
                                    $(this).prev('ul').slideDown(300, function () {
                                    });
                                }
                                $(this).toggleClass("mean-clicked");
                            });
                        } else {
                            $(meanContainer + ' .mean-nav ul ul').show();
                        }
                    } else {
                        $(meanContainer + ' .mean-nav ul ul').hide();
                    }

                    // add last class to tidy up borders
                    $(meanContainer + ' .mean-nav ul li').last().addClass('mean-last');

                    $($navreveal).click(function (e) {
                        e.preventDefault();
                        if (menuOn == false) {
                            $navreveal.css("text-align", "center");
                            $navreveal.css("text-indent", "0");
                            $navreveal.css("font-size", meanMenuCloseSize);
                            $(meanContainer + ' .mean-nav ul:first').slideDown();
                            menuOn = true;
                        } else {
                            $(meanContainer + ' .mean-nav ul:first').slideUp();
                            menuOn = false;
                        }
                        $(removeElements).addClass('mean-remove');
                    });

                    // for one page websites, reset all variables...
                    if (onePage) {

                        $(meanContainer + ' .mean-nav ul > li > a:first-child').on("click", function () {
                            $(meanContainer + ' .mean-nav ul:first').slideUp();
                            menuOn = false;
                            $($navreveal).html(meanMenuOpen);

                        });

                    }

                } else {
                    meanOriginal();
                }
            }

            if (!isMobile) {
                //reset menu on resize above meanScreenWidth
                $(window).resize(function () {
                    currentWidth = window.innerWidth || document.documentElement.clientWidth;
                    if (currentWidth > meanScreenWidth) {
                        meanOriginal();
                    } else {
                        meanOriginal();
                    }
                    if (currentWidth <= meanScreenWidth) {
                        showMeanMenu();
                        meanCentered();
                    } else {
                        meanOriginal();
                    }
                });
            }

            // adjust menu positioning on centered navigation
            window.onorientationchange = function () {
                meanCentered();
                // get browser width
                currentWidth = window.innerWidth || document.documentElement.clientWidth;
                if (currentWidth >= meanScreenWidth) {
                    meanOriginal();
                }
                if (currentWidth <= meanScreenWidth) {
                    if (meanMenuExist == false) {
                        showMeanMenu();
                    }
                }
            }
            // run main menuMenu function on load
            showMeanMenu();
        });
    };
})(jQuery);