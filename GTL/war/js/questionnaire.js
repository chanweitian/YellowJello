/* Created by jankoatwarpspeed.com */

(function($jq) {
    $jq.fn.formToWizard = function(options) {
        options = $jq.extend({  
            submitButton: "" 
        }, options); 
        
        var element = this;

        var steps = $jq(element).find("fieldset");
        var count = steps.size();
        var submmitButtonName = "#" + options.submitButton;
        $jq(submmitButtonName).hide();

        // 2
        $jq(element).before("<ul id='steps'></ul>");

        steps.each(function(i) {
            $jq(this).wrap("<div id='step" + i + "'></div>");
            $jq(this).append("<p id='step" + i + "commands'></p>");

            // 2
            var name = $jq(this).find("legend").html();
            $jq("#steps").append("<li id='stepDesc" + i + "'>Step " + (i + 1) + "<span>" + name + "</span></li>");

            if (i == 0) {
                createNextButton(i);
                selectStep(i);
            }
            else if (i == count - 1) {
                $jq("#step" + i).hide();
                createPrevButton(i);
            }
            else {
                $jq("#step" + i).hide();
                createPrevButton(i);
                createNextButton(i);
            }
        });

        function createPrevButton(i) {
            var stepName = "step" + i;
            $jq("#" + stepName + "commands").append("<a href='#' id='" + stepName + "Prev' class='prev'>< Back</a>");

            $jq("#" + stepName + "Prev").bind("click", function(e) {
                $jq("#" + stepName).hide();
                $jq("#step" + (i - 1)).show();
                $jq(submmitButtonName).hide();
                selectStep(i - 1);
            });
        }

        function createNextButton(i) {
            var stepName = "step" + i;
            $jq("#" + stepName + "commands").append("<a href='#' id='" + stepName + "Next' class='next'>Next ></a>");

            $jq("#" + stepName + "Next").bind("click", function(e) {
                $jq("#" + stepName).hide();
                $jq("#step" + (i + 1)).show();
                if (i + 2 == count)
                    $jq(submmitButtonName).show();
                selectStep(i + 1);
            });
        }

        function selectStep(i) {
            $jq("#steps li").removeClass("current");
            $jq("#stepDesc" + i).addClass("current");
        }

    }
})(jQuery); 

$(document).ready(function(){
    $("#questionnaire").formToWizard({ submitButton: 'SaveAccount' })
});

