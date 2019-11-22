/*
 * jQuery Text Area Limit
 * https://iamjoberror.com/projects/jQTarea
 * info@iamjoberror.com
 * Version: 1.2.0
 * Copyright 2019 Bolarinwa Olakunle
 */

$(document).ready(function (){

    var parent = document.getElementById('chat_section');
    var child = document.getElementById('chat_window');
    
    child.style.paddingRight = child.offsetWidth - child.clientWidth + "px";

    alert(child.offsetWidth + " - " + child.clientWidth);


console.log("bbbbbbbbbbbbbbbb44444444444444444444444");

    
    $.fn.jQTArea = function (options) {
        
        console.log("aaaaaaaab44444444444444444444444");

        var
            defaults =
                {
                    setLimit: 200, // Input limit
                    setExt: "W", // Animate Width (W) or Height (H) based on input length
                    setExtR: false // calculate setExt in reverse
                },
            plugin = $.extend({}, defaults, options);

        

        this.each(function () {
            var
                // get textarea element
                getTextarea = $(this);

            //set default values
            $(".jQTAreaValue").html(plugin.setLimit);
            $(".jQTAreaCount").html(0);

            // bind events to textarea
            if (getTextarea.is('input')) {
                getTextarea.bind("keyup focus change", function () {
                            console.log("gfgfgfgfgfgfgfg");

                    // validate on event trigger
                    fnValidate($(this));
                });
            }

            function fnValidate(e) {

                console.log("gggggggggggggggggggggggggg");

                var
                    // get input
                    calPerc,
                    getInput = e.val(),
                    // get input length
                    inputLength = getInput.length,
                    // get set limit
                    limit = plugin.setLimit;

                if (inputLength > limit) {
                    // truncate any input beyond the set limit
                    e.val(getInput.substring(0, limit));

                } else {
                    // set .jQTALimitCount to display input length
                    $(".jQTAreaCount").html(inputLength);

                    // set .jQTALimitCountR to display input length remaining
                    $(".jQTAreaCountR").html(limit - inputLength);

                    // set .jQTALimitExt to animate either width or height of element based on input length
                    calPerc = inputLength * 100 / limit;

                    //set setExt value to reverse eg, 80% instead of 20%
                    if (plugin.setExtR) {
                        calPerc = 100 - calPerc;
                    }

                    if (plugin.setExt === "W") {
                        $(".jQTAreaExt").width(
                             calPerc + "%"
                        )
                    } else {
                        $(".jQTAreaExt").height(
                            calPerc + "%"
                        )
                    }
                }
            }
        });

        return this;
    }



    // Initiate plugin
    $(".my_message").find("input").jQTArea({
        // Set Max input for Textarea
        setLimit: 100,
        // Set Animation to Width (W) or Height (H)
        setExt: "W",
        // setExt val in reverse eg, 80% instead of 20%
        setExtR: false
    });




});